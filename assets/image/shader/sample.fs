extern number ang;
extern vec2 scrSize;
extern vec2 r;
extern vec2 curve;
extern vec2 basePos;

vec4 effect(vec4 color,Image texture,vec2 texture_coords,vec2 screen_coords){
  number factor_x=radians(r.x*(screen_coords.x/scrSize.x));
  number factor_y=radians(r.y*(screen_coords.y/scrSize.y));
  vec2 uv=texture_coords;
  uv.x=mod(-basePos.x+uv.x-curve.x*sin(ang+factor_y),1.);
  uv.y=mod(-basePos.y+uv.y-curve.y*sin(ang+factor_x),1.);
  vec4 pixel=Texel(texture,uv);
  return pixel*color;
}
