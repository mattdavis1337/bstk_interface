
renderer.setClearColor('black')
reset()
camera.position.set(2.25789505516114,2.2445963087260883,2.25789505516114);
controls.target.set(-0.8017250293253402,-2.5934277299727513e-17,-0.8017250293253402);
var started;
var beats;
var lastBeats;
var lastRow;
s1.colorTab = gradient()
s1.tileTab = s.tileAtlas.star.indices
var t0 = 20
var t1 = 40

var t2 = 128
var substeps = 1

s1.agingRate = 0.0025*substeps

s.simulate=(s,time)=>{
	if(app.beatmonger && app.beatmonger.amplitudeArray){
		var aa = app.beatmonger.amplitudeArray;
		if((beats&&beats.length!=aa.length)||(!beats)){
			beats = new Array(aa.length);
			lastBeats = new Array(aa.length);
			lastRow = new Array(aa.length);
			var i=0;
			s.alloc( aa.length , (pp)=>{
				pp.set({
					py:0,
					pz:-5,
					px:((i/aa.length)-.5)*10,
        			r: rnd() * 7.1,
        			s: 0.02*substeps,
        			cr: 1,
        			cg: 1,
        			cb: 1,
					si:i,
					colorTab:s.colorTab,
					vy:0,
				})
				beats[i]=pp;
				if(i){}
				i++;
			})
		}
		for(var i=0;i<aa.length;i++){
			beats[i].py = aa[i]* 0.0185
		
			//beats[i].s = (aa[beats[i].si]*0.1)/256;
		}
		for(var i=0;i<aa.length;i+=substeps){


 			//if(lastBeats[i]<=t0&& aa[i]>t0){
var dlt = (aa[i]-lastBeats[i]);
 			if( dlt > 20 ){
			//	beats[i].colorTab = gradient()
				beats[i].tileTab = getTile(s)
				beats[i].s = 0.1;
				beats[i].vy=dlt*0.001;
//beats[i].py=4;
			}else{
				beats[i].vy=0;
				beats[i].s = 0.025;
			}
//continue;
 			if(lastBeats[i]>t1&& aa[i]<=t1)
				beats[i].colorTab = gradient()
				

				s1.alloc(1,(pp)=>{
                    pp.set({
                        py:beats[i].py,
                        pz:beats[i].pz,
                        px:beats[i].px,
                        r: 0,//rnd() * 7.1,
                        s: beats[i].s,
                        age:0,
                        colorTab:beats[i].colorTab,//gradient((aa[i]/256)*.03),
                        tileTab:beats[i].tileTab,
                        vy:beats[i].vy,
                        si:beats[i].si,
                        behavior:(ppp)=>{
                            ppp.pz+=(0.025*substeps);
                            if(ppp.age>0.99)
                                return false;
                            //ppp.s = (aa[ppp.si]*0.03)/256;
							ppp.r-=0.1;
							if(ppp.vy){
								ppp.vy-=0.00098
								ppp.py+=ppp.vy;
								if(ppp.py<pp.startY){
									ppp.py=pp.startY;ppp.vy*=-.25;
									
								}
							}
                        }
                    })

					if(lastRow[i]){
						pp.previous = lastRow[i];
						if(i==64)//i>0)
							pp.ribbon = lastRow[i-substeps];
					}
					lastRow[i]=pp;
					pp.startY=pp.py;
                })
			lastBeats[i]=aa[i];
		}
	}
}