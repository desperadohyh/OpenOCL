function testVarStructure
  
x = OclTreeTensorBuilder();
assertEqual(x.size,[0 1]);
x.add('x1',[1,2]);
x.add('x2',[3,2]);

assertSqueezeEqual(x.get('x1').indizes,[1,2])
assertSqueezeEqual(x.get('x2').indizes,[3,4,5;6,7,8]')
assertSqueezeEqual(x.size,[8 1])

x = OclTreeTensorBuilder();
x.add('x1',[1,8]);
assertEqual(x.size,[8 1])

x = OclTreeTensorBuilder();
x.add('x1',[1,3]);
x.add('x2',[3,2]);
x.add('x1',[1,3]);

assertSqueezeEqual(x.get('x1').indizes,{[1,2,3],[10,11,12]})
assertSqueezeEqual(x.get('x2').indizes,{4:9})

u = OclTreeTensorBuilder();
u.add('x1',[1,3]);
u.add('x3',[3,3]);
u.add('x1',[1,3]);
u.add('x3',[3,3]);

x = OclTreeTensorBuilder();
x.add('x1',[1,3]);
x.add('u',u);
x.add('u',u);
x.add('x2',[3,2]);
x.add('x1',[1,3]);

y = OclTreeTensorBuilder();
y.add('x1',[1,2]);
y.add('x1',[1,2]);
y.add('x1',[1,2]);
y.add('x1',[1,2]);

% get by name
assertSqueezeEqual(x.get('u').get('x1').indizes, {[4,5,6],[16,17,18],[28,29,30],[40,41,42]} );

% get by selector
r = x.get('u');
r.indizes = r.indizes(1);
assertSqueezeEqual(r.get('x1').indizes, {[4,5,6],[16,17,18]} );

% flat operator
f = x.flat();
assertSetEqual(f.get('x1').indizes,{[1,2,3],[4,5,6],[16,17,18],[28,29,30],[40,41,42],[58,59,60]} );
