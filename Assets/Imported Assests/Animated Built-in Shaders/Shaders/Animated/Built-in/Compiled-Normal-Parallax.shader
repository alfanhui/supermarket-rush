Shader "Animated/Built-in/Parallax Diffuse" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_Parallax ("Height", Range (0.005, 0.08)) = 0.02
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_BumpMap ("Normalmap", 2D) = "bump" {}
	_PanMT("Pan <Base (RGB) & Normalmap> (Speed(XY))", Vector) = (0,0,0,0)
	_RotMT("Rot <Base (RGB) & Normalmap> (Pivot(XY), Angle Speed(Z), Angle(W))", Vector) = (0.5,0.5,0,0)
	_ParallaxMap ("Heightmap (A)", 2D) = "black" {}
	_PanPM("Pan <Heightmap (A)> (Speed(XY))", Vector) = (0,0,0,0)
	_RotPM("Rot <Heightmap (A)> (Pivot(XY), Angle Speed(Z), Angle(W))", Vector) = (0.5,0.5,0,0)
}

SubShader {
	Tags { "RenderType"="Opaque" }
	LOD 500

	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 12
//   opengl - ALU: 20 to 80
//   d3d9 - ALU: 21 to 83
//   d3d11 - ALU: 18 to 66, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 44 ALU
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.y, R1, c[19];
DP4 R3.x, R1, c[18];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[3].xyz, R2, R3;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[22].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[14];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 44 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 21 [unity_Scale]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 47 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c24.x
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c20
add o4.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1.w, c24.x
mov r1.xyz, c12
dp4 r4.y, c13, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c21.w, -v0
mov r1, c8
dp4 r4.x, c13, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 176 used size, 11 vars
Vector 144 [_MainTex_ST] 4
Vector 160 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 41 instructions, 4 temp regs, 0 temp arrays:
// ALU 39 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkdeffldhmjmfaanpdaeiccmfelnbjcoiabaaaaaanaahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdeagaaaaeaaaabaa
inabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_6 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 c_16;
  c_16.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * (max (0.0, dot (((texture2D (_BumpMap, tmpvar_15).xyz * 2.0) - 1.0), xlv_TEXCOORD2)) * 2.0));
  c_16.w = tmpvar_14.w;
  c_1.w = c_16.w;
  c_1.xyz = (c_16.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_6 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, tmpvar_15).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 c_17;
  c_17.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * (max (0.0, dot (normal_16, xlv_TEXCOORD2)) * 2.0));
  c_17.w = tmpvar_14.w;
  c_1.w = c_17.w;
  c_1.xyz = (c_17.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 450
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 432
v2f_surf vert_surf( in appdata_full v ) {
    #line 434
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 438
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 442
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    #line 446
    o.vlight = shlight;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 450
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 450
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 454
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 458
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 462
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, IN.lightDir, atten);
    #line 466
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 20 ALU
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_3_0
; 21 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c17.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o2.y, r0, r1
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o3.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 192 // 192 used size, 12 vars
Vector 144 [unity_LightmapST] 4
Vector 160 [_MainTex_ST] 4
Vector 176 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 19 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedonkpgfodejcbnkpoannilhhbpbhaepioabaaaaaanaaeaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
emadaaaaeaaaabaandaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaa
alaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  mediump float height_5;
  height_5 = _Parallax;
  mediump vec3 viewDir_6;
  viewDir_6 = xlv_TEXCOORD1;
  highp vec3 v_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((h_2 * height_5) - (height_5 / 2.0));
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(viewDir_6);
  v_7 = tmpvar_9;
  v_7.z = (v_7.z + 0.42);
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy + (tmpvar_8 * (v_7.xy / v_7.z)));
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((_RotMT.x - (((tmpvar_10.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_10.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_11.y = ((_RotMT.y - (((tmpvar_10.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_10.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, tmpvar_11) * _Color);
  c_1.xyz = (tmpvar_12.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.w = tmpvar_12.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, tmpvar_15).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  c_1.xyz = (tmpvar_14.xyz * ((8.0 * tmpvar_17.w) * tmpvar_17.xyz));
  c_1.w = tmpvar_14.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 429
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 432
v2f_surf vert_surf( in appdata_full v ) {
    #line 434
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 438
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 442
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 446
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 429
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 449
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 451
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 455
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 459
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 463
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * lm);
    #line 467
    c.w = o.Alpha;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Matrix 9 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 20 ALU
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_3_0
; 21 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c17.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o2.y, r0, r1
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o3.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 192 // 192 used size, 12 vars
Vector 144 [unity_LightmapST] 4
Vector 160 [_MainTex_ST] 4
Vector 176 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 19 instructions, 2 temp regs, 0 temp arrays:
// ALU 18 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedonkpgfodejcbnkpoannilhhbpbhaepioabaaaaaanaaeaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
emadaaaaeaaaabaandaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaa
alaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 tmpvar_16;
  tmpvar_16 = ((texture2D (_BumpMap, tmpvar_15).xyz * 2.0) - 1.0);
  mat3 tmpvar_17;
  tmpvar_17[0].x = 0.816497;
  tmpvar_17[0].y = -0.408248;
  tmpvar_17[0].z = -0.408248;
  tmpvar_17[1].x = 0.0;
  tmpvar_17[1].y = 0.707107;
  tmpvar_17[1].z = -0.707107;
  tmpvar_17[2].x = 0.57735;
  tmpvar_17[2].y = 0.57735;
  tmpvar_17[2].z = 0.57735;
  mediump vec3 normal_18;
  normal_18 = tmpvar_16;
  mediump vec3 scalePerBasisVector_19;
  mediump vec3 lm_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_20 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_19 = tmpvar_22;
  lm_20 = (lm_20 * dot (clamp ((tmpvar_17 * normal_18), 0.0, 1.0), scalePerBasisVector_19));
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_14.xyz * lm_20);
  c_1.xyz = tmpvar_23;
  c_1.w = tmpvar_14.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, tmpvar_15).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_LightmapInd, xlv_TEXCOORD2);
  mat3 tmpvar_19;
  tmpvar_19[0].x = 0.816497;
  tmpvar_19[0].y = -0.408248;
  tmpvar_19[0].z = -0.408248;
  tmpvar_19[1].x = 0.0;
  tmpvar_19[1].y = 0.707107;
  tmpvar_19[1].z = -0.707107;
  tmpvar_19[2].x = 0.57735;
  tmpvar_19[2].y = 0.57735;
  tmpvar_19[2].z = 0.57735;
  mediump vec3 normal_20;
  normal_20 = normal_16;
  mediump vec3 scalePerBasisVector_21;
  mediump vec3 lm_22;
  lowp vec3 tmpvar_23;
  tmpvar_23 = ((8.0 * tmpvar_17.w) * tmpvar_17.xyz);
  lm_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((8.0 * tmpvar_18.w) * tmpvar_18.xyz);
  scalePerBasisVector_21 = tmpvar_24;
  lm_22 = (lm_22 * dot (clamp ((tmpvar_19 * normal_20), 0.0, 1.0), scalePerBasisVector_21));
  mediump vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_14.xyz * lm_22);
  c_1.xyz = tmpvar_25;
  c_1.w = tmpvar_14.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 429
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 450
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 432
v2f_surf vert_surf( in appdata_full v ) {
    #line 434
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 438
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 442
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    #line 446
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 429
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 450
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 353
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 355
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 450
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 454
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 458
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 462
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 466
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, true).xyz;
    c.xyz += (o.Albedo * lm);
    c.w = o.Alpha;
    #line 470
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 49 ALU
PARAM c[26] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[21];
DP4 R3.y, R1, c[20];
DP4 R3.x, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[22];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[3].xyz, R2, R3;
MOV R0.w, c[0].x;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[23].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 49 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"vs_3_0
; 52 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c26, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c26.x
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c21
dp4 r3.y, r1, c20
dp4 r3.x, r1, c19
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c22
add o4.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1.w, c26.x
mov r1.xyz, c12
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c23.w, -v0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c26.y
mul r1.y, r1, c13.x
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o5.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c25.xyxy, c25
mad o1.xy, v3, c24, c24.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 240 // 240 used size, 12 vars
Vector 208 [_MainTex_ST] 4
Vector 224 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 46 instructions, 5 temp regs, 0 temp arrays:
// ALU 42 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedojlpddepfippanigmikakhpdhemcamhlabaaaaaaiaaiaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmmagaaaaeaaaabaaldabaaaafjaaaaae
egiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacafaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaa
aoaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
aaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
diaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_6 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp float tmpvar_16;
  mediump float lightShadowDataX_17;
  highp float dist_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((dist_18 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_17);
  tmpvar_16 = tmpvar_21;
  lowp vec4 c_22;
  c_22.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * ((max (0.0, dot (((texture2D (_BumpMap, tmpvar_15).xyz * 2.0) - 1.0), xlv_TEXCOORD2)) * tmpvar_16) * 2.0));
  c_22.w = tmpvar_14.w;
  c_1.w = c_22.w;
  c_1.xyz = (c_22.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = o_30;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, tmpvar_15).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 c_17;
  c_17.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_16, xlv_TEXCOORD2)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 2.0));
  c_17.w = tmpvar_14.w;
  c_1.w = c_17.w;
  c_1.xyz = (c_17.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 439
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 460
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 441
v2f_surf vert_surf( in appdata_full v ) {
    #line 443
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 447
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 451
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    #line 455
    o.vlight = shlight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 439
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 460
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 415
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 419
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 423
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 427
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 460
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 464
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 468
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 472
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, IN.lightDir, atten);
    #line 476
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Matrix 9 [_World2Object]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 25 ALU
PARAM c[20] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 25 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 26 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c19.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c19.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o4.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o4.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o3.xy, v4, c16, c16.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 256 // 256 used size, 13 vars
Vector 208 [unity_LightmapST] 4
Vector 224 [_MainTex_ST] 4
Vector 240 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 24 instructions, 3 temp regs, 0 temp arrays:
// ALU 21 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgepamcfadhcdpnihidjaokfcigeopiamabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aoaaaaaaogikcaaaaaaaaaaaaoaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaapaaaaaakgiocaaaaaaaaaaaapaaaaaadiaaaaah
hcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaa
acaaaaaaegacbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
eccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  mediump float height_5;
  height_5 = _Parallax;
  mediump vec3 viewDir_6;
  viewDir_6 = xlv_TEXCOORD1;
  highp vec3 v_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((h_2 * height_5) - (height_5 / 2.0));
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(viewDir_6);
  v_7 = tmpvar_9;
  v_7.z = (v_7.z + 0.42);
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy + (tmpvar_8 * (v_7.xy / v_7.z)));
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((_RotMT.x - (((tmpvar_10.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_10.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_11.y = ((_RotMT.y - (((tmpvar_10.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_10.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, tmpvar_11) * _Color);
  lowp float tmpvar_13;
  mediump float lightShadowDataX_14;
  highp float dist_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = _LightShadowData.x;
  lightShadowDataX_14 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max (float((dist_15 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_14);
  tmpvar_13 = tmpvar_18;
  c_1.xyz = (tmpvar_12.xyz * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz), vec3((tmpvar_13 * 2.0))));
  c_1.w = tmpvar_12.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = o_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, tmpvar_15).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec3 tmpvar_19;
  tmpvar_19 = ((8.0 * tmpvar_18.w) * tmpvar_18.xyz);
  c_1.xyz = (tmpvar_14.xyz * max (min (tmpvar_19, ((tmpvar_17.x * 2.0) * tmpvar_18.xyz)), (tmpvar_19 * tmpvar_17.x)));
  c_1.w = tmpvar_14.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 438
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 441
v2f_surf vert_surf( in appdata_full v ) {
    #line 443
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 447
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 451
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 456
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
    xlv_TEXCOORD3 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 438
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 415
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 419
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 423
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 427
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 459
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 461
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 465
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 469
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 473
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    #line 477
    c.w = o.Alpha;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Matrix 9 [_World2Object]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 25 ALU
PARAM c[20] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 25 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Matrix 8 [_World2Object]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 26 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c19.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c19.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o4.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o4.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o3.xy, v4, c16, c16.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 256 // 256 used size, 13 vars
Vector 208 [unity_LightmapST] 4
Vector 224 [_MainTex_ST] 4
Vector 240 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 24 instructions, 3 temp regs, 0 temp arrays:
// ALU 21 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgepamcfadhcdpnihidjaokfcigeopiamabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aoaaaaaaogikcaaaaaaaaaaaaoaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaapaaaaaakgiocaaaaaaaaaaaapaaaaaadiaaaaah
hcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaa
acaaaaaaegacbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
eccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 tmpvar_16;
  tmpvar_16 = ((texture2D (_BumpMap, tmpvar_15).xyz * 2.0) - 1.0);
  lowp float tmpvar_17;
  mediump float lightShadowDataX_18;
  highp float dist_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = max (float((dist_19 > (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w))), lightShadowDataX_18);
  tmpvar_17 = tmpvar_22;
  mat3 tmpvar_23;
  tmpvar_23[0].x = 0.816497;
  tmpvar_23[0].y = -0.408248;
  tmpvar_23[0].z = -0.408248;
  tmpvar_23[1].x = 0.0;
  tmpvar_23[1].y = 0.707107;
  tmpvar_23[1].z = -0.707107;
  tmpvar_23[2].x = 0.57735;
  tmpvar_23[2].y = 0.57735;
  tmpvar_23[2].z = 0.57735;
  mediump vec3 normal_24;
  normal_24 = tmpvar_16;
  mediump vec3 scalePerBasisVector_25;
  mediump vec3 lm_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_25 = tmpvar_28;
  lm_26 = (lm_26 * dot (clamp ((tmpvar_23 * normal_24), 0.0, 1.0), scalePerBasisVector_25));
  lowp vec3 tmpvar_29;
  tmpvar_29 = vec3((tmpvar_17 * 2.0));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_14.xyz * min (lm_26, tmpvar_29));
  c_1.xyz = tmpvar_30;
  c_1.w = tmpvar_14.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_8).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = o_9;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, tmpvar_15).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (unity_LightmapInd, xlv_TEXCOORD2);
  mat3 tmpvar_20;
  tmpvar_20[0].x = 0.816497;
  tmpvar_20[0].y = -0.408248;
  tmpvar_20[0].z = -0.408248;
  tmpvar_20[1].x = 0.0;
  tmpvar_20[1].y = 0.707107;
  tmpvar_20[1].z = -0.707107;
  tmpvar_20[2].x = 0.57735;
  tmpvar_20[2].y = 0.57735;
  tmpvar_20[2].z = 0.57735;
  mediump vec3 normal_21;
  normal_21 = normal_16;
  mediump vec3 scalePerBasisVector_22;
  mediump vec3 lm_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = ((8.0 * tmpvar_18.w) * tmpvar_18.xyz);
  lm_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((8.0 * tmpvar_19.w) * tmpvar_19.xyz);
  scalePerBasisVector_22 = tmpvar_25;
  lm_23 = (lm_23 * dot (clamp ((tmpvar_20 * normal_21), 0.0, 1.0), scalePerBasisVector_22));
  lowp vec3 arg1_26;
  arg1_26 = ((tmpvar_17.x * 2.0) * tmpvar_18.xyz);
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_14.xyz * max (min (lm_23, arg1_26), (lm_23 * tmpvar_17.x)));
  c_1.xyz = tmpvar_27;
  c_1.w = tmpvar_14.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 438
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 460
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 441
v2f_surf vert_surf( in appdata_full v ) {
    #line 443
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 447
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 451
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 456
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
    xlv_TEXCOORD3 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 438
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 460
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 353
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 355
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 415
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 419
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 423
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 427
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 460
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 464
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 468
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 472
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 476
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, true).xyz;
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    #line 480
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 30 [unity_Scale]
Vector 31 [_MainTex_ST]
Vector 32 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 75 ALU
PARAM c[33] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..32] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[30].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MUL R1.w, R3, R3;
MAD R0.x, R4, R4, -R1.w;
MOV R0.w, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[29];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[3].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[30].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[14];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 75 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 29 [unity_Scale]
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
"vs_3_0
; 78 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c32, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c32.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c32.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o4.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1.w, c32.x
mov r1.xyz, c12
dp4 r4.y, c13, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c29.w, -v0
mov r1, c8
dp4 r4.x, c13, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 176 used size, 11 vars
Vector 144 [_MainTex_ST] 4
Vector 160 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 160 [unity_LightColor4] 4
Vector 176 [unity_LightColor5] 4
Vector 192 [unity_LightColor6] 4
Vector 208 [unity_LightColor7] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 65 instructions, 6 temp regs, 0 temp arrays:
// ALU 63 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedimbbloegpbloappomlhjppgegkedkfngabaaaaaacaalaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcieajaaaaeaaaabaa
gbacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaa
abaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
abaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaa
egadbaaaabaaaaaabbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaa
acaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaa
adaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaa
aaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaa
acaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaa
acaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaa
aaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaa
afaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaa
adaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaa
egiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
aoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
adaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaacaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaa
agaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_8;
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_30;
  tmpvar_30 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_30.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_30.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_30.z);
  highp vec4 tmpvar_34;
  tmpvar_34 = (((tmpvar_31 * tmpvar_31) + (tmpvar_32 * tmpvar_32)) + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_35;
  tmpvar_35 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_31 * tmpvar_8.x) + (tmpvar_32 * tmpvar_8.y)) + (tmpvar_33 * tmpvar_8.z)) * inversesqrt(tmpvar_34))) * (1.0/((1.0 + (tmpvar_34 * unity_4LightAtten0)))));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_35.x) + (unity_LightColor[1].xyz * tmpvar_35.y)) + (unity_LightColor[2].xyz * tmpvar_35.z)) + (unity_LightColor[3].xyz * tmpvar_35.w)));
  tmpvar_6 = tmpvar_36;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 c_16;
  c_16.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * (max (0.0, dot (((texture2D (_BumpMap, tmpvar_15).xyz * 2.0) - 1.0), xlv_TEXCOORD2)) * 2.0));
  c_16.w = tmpvar_14.w;
  c_1.w = c_16.w;
  c_1.xyz = (c_16.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_8;
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_30;
  tmpvar_30 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_30.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_30.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_30.z);
  highp vec4 tmpvar_34;
  tmpvar_34 = (((tmpvar_31 * tmpvar_31) + (tmpvar_32 * tmpvar_32)) + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_35;
  tmpvar_35 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_31 * tmpvar_8.x) + (tmpvar_32 * tmpvar_8.y)) + (tmpvar_33 * tmpvar_8.z)) * inversesqrt(tmpvar_34))) * (1.0/((1.0 + (tmpvar_34 * unity_4LightAtten0)))));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_35.x) + (unity_LightColor[1].xyz * tmpvar_35.y)) + (unity_LightColor[2].xyz * tmpvar_35.z)) + (unity_LightColor[3].xyz * tmpvar_35.w)));
  tmpvar_6 = tmpvar_36;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, tmpvar_15).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 c_17;
  c_17.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * (max (0.0, dot (normal_16, xlv_TEXCOORD2)) * 2.0));
  c_17.w = tmpvar_14.w;
  c_1.w = c_17.w;
  c_1.xyz = (c_17.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 432
v2f_surf vert_surf( in appdata_full v ) {
    #line 434
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 438
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 442
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    #line 446
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    #line 450
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 452
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 454
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 458
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 462
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 466
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 80 ALU
PARAM c[34] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..33] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[31].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MUL R1.w, R3, R3;
MOV R0.w, c[0].x;
MAD R0.x, R4, R4, -R1.w;
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[30];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[3].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[31].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 80 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"vs_3_0
; 83 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c34, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c31.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c34.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c34.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c34.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o4.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1.w, c34.x
mov r1.xyz, c12
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c31.w, -v0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c34.z
mul r1.y, r1, c13.x
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o5.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c33.xyxy, c33
mad o1.xy, v3, c32, c32.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 240 // 240 used size, 12 vars
Vector 208 [_MainTex_ST] 4
Vector 224 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 160 [unity_LightColor4] 4
Vector 176 [unity_LightColor5] 4
Vector 192 [unity_LightColor6] 4
Vector 208 [unity_LightColor7] 4
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 70 instructions, 7 temp regs, 0 temp arrays:
// ALU 66 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednmichigaojmfppiplggiaebgoojhpbkgabaaaaaanaalaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcbmakaaaaeaaaabaaihacaaaafjaaaaae
egiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaa
aoaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
aaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
diaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaf
icaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaacaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaa
acaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaacaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaa
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaaj
pcaabaaaaeaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaa
diaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaah
pcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaa
agaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaaj
pcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaa
dcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaa
egaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaa
agaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaa
adaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaa
aeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_8;
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_30;
  tmpvar_30 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_30.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_30.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_30.z);
  highp vec4 tmpvar_34;
  tmpvar_34 = (((tmpvar_31 * tmpvar_31) + (tmpvar_32 * tmpvar_32)) + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_35;
  tmpvar_35 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_31 * tmpvar_8.x) + (tmpvar_32 * tmpvar_8.y)) + (tmpvar_33 * tmpvar_8.z)) * inversesqrt(tmpvar_34))) * (1.0/((1.0 + (tmpvar_34 * unity_4LightAtten0)))));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_35.x) + (unity_LightColor[1].xyz * tmpvar_35.y)) + (unity_LightColor[2].xyz * tmpvar_35.z)) + (unity_LightColor[3].xyz * tmpvar_35.w)));
  tmpvar_6 = tmpvar_36;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp float tmpvar_16;
  mediump float lightShadowDataX_17;
  highp float dist_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_17 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((dist_18 > (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w))), lightShadowDataX_17);
  tmpvar_16 = tmpvar_21;
  lowp vec4 c_22;
  c_22.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * ((max (0.0, dot (((texture2D (_BumpMap, tmpvar_15).xyz * 2.0) - 1.0), xlv_TEXCOORD2)) * tmpvar_16) * 2.0));
  c_22.w = tmpvar_14.w;
  c_1.w = c_22.w;
  c_1.xyz = (c_22.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_10 = tmpvar_1.xyz;
  tmpvar_11 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10.x;
  tmpvar_12[0].y = tmpvar_11.x;
  tmpvar_12[0].z = tmpvar_2.x;
  tmpvar_12[1].x = tmpvar_10.y;
  tmpvar_12[1].y = tmpvar_11.y;
  tmpvar_12[1].z = tmpvar_2.y;
  tmpvar_12[2].x = tmpvar_10.z;
  tmpvar_12[2].y = tmpvar_11.z;
  tmpvar_12[2].z = tmpvar_2.z;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_9;
  mediump vec3 tmpvar_16;
  mediump vec4 normal_17;
  normal_17 = tmpvar_15;
  highp float vC_18;
  mediump vec3 x3_19;
  mediump vec3 x2_20;
  mediump vec3 x1_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAr, normal_17);
  x1_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAg, normal_17);
  x1_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHAb, normal_17);
  x1_21.z = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_17.xyzz * normal_17.yzzx);
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBr, tmpvar_25);
  x2_20.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBg, tmpvar_25);
  x2_20.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = dot (unity_SHBb, tmpvar_25);
  x2_20.z = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = ((normal_17.x * normal_17.x) - (normal_17.y * normal_17.y));
  vC_18 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_SHC.xyz * vC_18);
  x3_19 = tmpvar_30;
  tmpvar_16 = ((x1_21 + x2_20) + x3_19);
  shlight_3 = tmpvar_16;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_31;
  tmpvar_31 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosX0 - tmpvar_31.x);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosY0 - tmpvar_31.y);
  highp vec4 tmpvar_34;
  tmpvar_34 = (unity_4LightPosZ0 - tmpvar_31.z);
  highp vec4 tmpvar_35;
  tmpvar_35 = (((tmpvar_32 * tmpvar_32) + (tmpvar_33 * tmpvar_33)) + (tmpvar_34 * tmpvar_34));
  highp vec4 tmpvar_36;
  tmpvar_36 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_32 * tmpvar_9.x) + (tmpvar_33 * tmpvar_9.y)) + (tmpvar_34 * tmpvar_9.z)) * inversesqrt(tmpvar_35))) * (1.0/((1.0 + (tmpvar_35 * unity_4LightAtten0)))));
  highp vec3 tmpvar_37;
  tmpvar_37 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_36.x) + (unity_LightColor[1].xyz * tmpvar_36.y)) + (unity_LightColor[2].xyz * tmpvar_36.z)) + (unity_LightColor[3].xyz * tmpvar_36.w)));
  tmpvar_6 = tmpvar_37;
  highp vec4 o_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_40;
  tmpvar_40.x = tmpvar_39.x;
  tmpvar_40.y = (tmpvar_39.y * _ProjectionParams.x);
  o_38.xy = (tmpvar_40 + tmpvar_39.w);
  o_38.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_12 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = o_38;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_16;
  normal_16.xy = ((texture2D (_BumpMap, tmpvar_15).wy * 2.0) - 1.0);
  normal_16.z = sqrt((1.0 - clamp (dot (normal_16.xy, normal_16.xy), 0.0, 1.0)));
  lowp vec4 c_17;
  c_17.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_16, xlv_TEXCOORD2)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 2.0));
  c_17.w = tmpvar_14.w;
  c_1.w = c_17.w;
  c_1.xyz = (c_17.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 439
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 441
v2f_surf vert_surf( in appdata_full v ) {
    #line 443
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 447
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 451
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    #line 455
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 460
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 439
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 415
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 419
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 423
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 427
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 397
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 462
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 464
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 468
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 472
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 476
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_14;
  mediump vec4 normal_15;
  normal_15 = tmpvar_13;
  highp float vC_16;
  mediump vec3 x3_17;
  mediump vec3 x2_18;
  mediump vec3 x1_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHAr, normal_15);
  x1_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAg, normal_15);
  x1_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAb, normal_15);
  x1_19.z = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = (normal_15.xyzz * normal_15.yzzx);
  highp float tmpvar_24;
  tmpvar_24 = dot (unity_SHBr, tmpvar_23);
  x2_18.x = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBg, tmpvar_23);
  x2_18.y = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBb, tmpvar_23);
  x2_18.z = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y));
  vC_16 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = (unity_SHC.xyz * vC_16);
  x3_17 = tmpvar_28;
  tmpvar_14 = ((x1_19 + x2_18) + x3_17);
  shlight_3 = tmpvar_14;
  tmpvar_6 = shlight_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_10 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp float shadow_16;
  lowp float tmpvar_17;
  tmpvar_17 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_18;
  tmpvar_18 = (_LightShadowData.x + (tmpvar_17 * (1.0 - _LightShadowData.x)));
  shadow_16 = tmpvar_18;
  lowp vec4 c_19;
  c_19.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * ((max (0.0, dot (((texture2D (_BumpMap, tmpvar_15).xyz * 2.0) - 1.0), xlv_TEXCOORD2)) * shadow_16) * 2.0));
  c_19.w = tmpvar_14.w;
  c_1.w = c_19.w;
  c_1.xyz = (c_19.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 439
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 460
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 441
v2f_surf vert_surf( in appdata_full v ) {
    #line 443
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 447
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 451
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    #line 455
    o.vlight = shlight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 439
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 460
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 415
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 419
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 423
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 427
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 460
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 464
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 468
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 472
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, IN.lightDir, atten);
    #line 476
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  mediump float height_5;
  height_5 = _Parallax;
  mediump vec3 viewDir_6;
  viewDir_6 = xlv_TEXCOORD1;
  highp vec3 v_7;
  mediump float tmpvar_8;
  tmpvar_8 = ((h_2 * height_5) - (height_5 / 2.0));
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(viewDir_6);
  v_7 = tmpvar_9;
  v_7.z = (v_7.z + 0.42);
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy + (tmpvar_8 * (v_7.xy / v_7.z)));
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((_RotMT.x - (((tmpvar_10.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_10.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_11.y = ((_RotMT.y - (((tmpvar_10.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_10.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, tmpvar_11) * _Color);
  lowp float shadow_13;
  lowp float tmpvar_14;
  tmpvar_14 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_13 = tmpvar_15;
  c_1.xyz = (tmpvar_12.xyz * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz), vec3((shadow_13 * 2.0))));
  c_1.w = tmpvar_12.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 438
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 441
v2f_surf vert_surf( in appdata_full v ) {
    #line 443
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 447
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 451
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 456
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
    xlv_TEXCOORD3 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 438
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 415
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 419
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 423
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 427
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 459
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 461
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 465
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 469
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 473
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    #line 477
    c.w = o.Alpha;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_4 = tmpvar_1.xyz;
  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = tmpvar_2.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = tmpvar_2.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = tmpvar_2.z;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_6 * (((_World2Object * tmpvar_7).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 tmpvar_16;
  tmpvar_16 = ((texture2D (_BumpMap, tmpvar_15).xyz * 2.0) - 1.0);
  lowp float shadow_17;
  lowp float tmpvar_18;
  tmpvar_18 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_19;
  tmpvar_19 = (_LightShadowData.x + (tmpvar_18 * (1.0 - _LightShadowData.x)));
  shadow_17 = tmpvar_19;
  mat3 tmpvar_20;
  tmpvar_20[0].x = 0.816497;
  tmpvar_20[0].y = -0.408248;
  tmpvar_20[0].z = -0.408248;
  tmpvar_20[1].x = 0.0;
  tmpvar_20[1].y = 0.707107;
  tmpvar_20[1].z = -0.707107;
  tmpvar_20[2].x = 0.57735;
  tmpvar_20[2].y = 0.57735;
  tmpvar_20[2].z = 0.57735;
  mediump vec3 normal_21;
  normal_21 = tmpvar_16;
  mediump vec3 scalePerBasisVector_22;
  mediump vec3 lm_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  scalePerBasisVector_22 = tmpvar_25;
  lm_23 = (lm_23 * dot (clamp ((tmpvar_20 * normal_21), 0.0, 1.0), scalePerBasisVector_22));
  lowp vec3 tmpvar_26;
  tmpvar_26 = vec3((shadow_17 * 2.0));
  mediump vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_14.xyz * min (lm_23, tmpvar_26));
  c_1.xyz = tmpvar_27;
  c_1.w = tmpvar_14.w;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 438
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 460
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 441
v2f_surf vert_surf( in appdata_full v ) {
    #line 443
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 447
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 451
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 456
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec2(xl_retval.lmap);
    xlv_TEXCOORD3 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 438
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 460
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 353
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 355
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 415
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 419
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 423
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 427
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 460
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 464
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 468
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 472
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 476
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, true).xyz;
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    #line 480
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lmap = vec2(xlv_TEXCOORD2);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 shlight_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (tmpvar_2 * unity_Scale.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_5 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_8;
  mediump vec3 tmpvar_15;
  mediump vec4 normal_16;
  normal_16 = tmpvar_14;
  highp float vC_17;
  mediump vec3 x3_18;
  mediump vec3 x2_19;
  mediump vec3 x1_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHAr, normal_16);
  x1_20.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHAg, normal_16);
  x1_20.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHAb, normal_16);
  x1_20.z = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24 = (normal_16.xyzz * normal_16.yzzx);
  highp float tmpvar_25;
  tmpvar_25 = dot (unity_SHBr, tmpvar_24);
  x2_19.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (unity_SHBg, tmpvar_24);
  x2_19.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = dot (unity_SHBb, tmpvar_24);
  x2_19.z = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = ((normal_16.x * normal_16.x) - (normal_16.y * normal_16.y));
  vC_17 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (unity_SHC.xyz * vC_17);
  x3_18 = tmpvar_29;
  tmpvar_15 = ((x1_20 + x2_19) + x3_18);
  shlight_3 = tmpvar_15;
  tmpvar_6 = shlight_3;
  highp vec3 tmpvar_30;
  tmpvar_30 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_30.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_30.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_30.z);
  highp vec4 tmpvar_34;
  tmpvar_34 = (((tmpvar_31 * tmpvar_31) + (tmpvar_32 * tmpvar_32)) + (tmpvar_33 * tmpvar_33));
  highp vec4 tmpvar_35;
  tmpvar_35 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_31 * tmpvar_8.x) + (tmpvar_32 * tmpvar_8.y)) + (tmpvar_33 * tmpvar_8.z)) * inversesqrt(tmpvar_34))) * (1.0/((1.0 + (tmpvar_34 * unity_4LightAtten0)))));
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_6 + ((((unity_LightColor[0].xyz * tmpvar_35.x) + (unity_LightColor[1].xyz * tmpvar_35.y)) + (unity_LightColor[2].xyz * tmpvar_35.z)) + (unity_LightColor[3].xyz * tmpvar_35.w)));
  tmpvar_6 = tmpvar_36;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (tmpvar_11 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  mediump float h_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_3.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_ParallaxMap, tmpvar_3).w;
  h_2 = tmpvar_4;
  highp vec2 tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_2 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  tmpvar_5 = (tmpvar_9 * (v_8.xy / v_8.z));
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0.xy + tmpvar_5);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.zw + tmpvar_5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp float shadow_16;
  lowp float tmpvar_17;
  tmpvar_17 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_18;
  tmpvar_18 = (_LightShadowData.x + (tmpvar_17 * (1.0 - _LightShadowData.x)));
  shadow_16 = tmpvar_18;
  lowp vec4 c_19;
  c_19.xyz = ((tmpvar_14.xyz * _LightColor0.xyz) * ((max (0.0, dot (((texture2D (_BumpMap, tmpvar_15).xyz * 2.0) - 1.0), xlv_TEXCOORD2)) * shadow_16) * 2.0));
  c_19.w = tmpvar_14.w;
  c_1.w = c_19.w;
  c_1.xyz = (c_19.xyz + (tmpvar_14.xyz * xlv_TEXCOORD3));
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 439
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 96
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 100
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 104
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 108
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 112
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 116
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 441
v2f_surf vert_surf( in appdata_full v ) {
    #line 443
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 447
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    #line 451
    o.lightDir = lightDir;
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    #line 455
    o.vlight = shlight;
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 460
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
    xlv_TEXCOORD4 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 408
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 429
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    lowp vec3 lightDir;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 401
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 405
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 415
#line 439
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 415
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 419
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 423
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 427
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 393
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 397
    return shadow;
}
#line 462
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 464
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 468
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 472
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 476
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, IN.lightDir, atten);
    c.xyz += (o.Albedo * IN.vlight);
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 51 to 84, TEX: 3 to 6
//   d3d9 - ALU: 71 to 102, TEX: 3 to 6
//   d3d11 - ALU: 33 to 51, TEX: 3 to 6, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"3.0-!!ARBfp1.0
# 72 ALU, 3 TEX
PARAM c[10] = { program.local[0..7],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 2, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[5].w;
MAD R0.x, R0, c[8], c[8].y;
MOV R0.z, c[0].y;
MUL R0.x, R0, c[8].z;
MAD R0.x, R0.z, c[5].z, R0;
COS R0.y, R0.x;
SIN R0.w, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[5].y;
MUL R1.x, R0, R0.w;
MUL R1.y, R0, R0.x;
ADD R0.x, fragment.texcoord[0].z, -c[5];
MAD R0.w, R0.x, R0, R1.y;
MAD R0.x, R0, R0.y, -R1;
ADD R0.y, -R0.w, c[5];
ADD R0.x, -R0, c[5];
MAD R0.y, R0.z, c[4], R0;
MAD R0.x, R0.z, c[4], R0;
TEX R0.w, R0, texture[0], 2D;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R1.xyz, R0.y, fragment.texcoord[1];
MOV R0.x, c[7];
MUL R0.x, R0, c[8].w;
MAD R2.z, R0.w, c[7].x, -R0.x;
ADD R0.x, R1.z, c[9];
RCP R0.x, R0.x;
MUL R1.zw, R1.xyxy, R0.x;
MOV R0.y, c[3].w;
MAD R0.y, R0, c[8].x, c[8];
MUL R0.w, R0.y, c[8].z;
MAD R0.xy, R2.z, R1.zwzw, fragment.texcoord[0].zwzw;
MAD R0.w, R0.z, c[3].z, R0;
SIN R2.y, R0.w;
COS R2.x, R0.w;
ADD R0.y, R0, -c[3];
MUL R0.w, R2.x, R0.y;
ADD R0.x, R0, -c[3];
MUL R0.y, R0, R2;
MAD R0.y, R0.x, R2.x, -R0;
MAD R0.w, R0.x, R2.y, R0;
ADD R0.x, -R0.y, c[3];
ADD R0.y, -R0.w, c[3];
MAD R0.x, R0.z, c[2], R0;
MAD R0.y, R0.z, c[2], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R1.x, c[8].y;
MAD R1.xy, R0.wyzw, c[9].y, -R1.x;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.w, -R0.x, c[8].y;
MAD R0.xy, R2.z, R1.zwzw, fragment.texcoord[0];
RSQ R0.w, R0.w;
RCP R1.z, R0.w;
ADD R0.y, R0, -c[3];
MUL R0.w, R2.y, R0.y;
DP3 R1.x, R1, fragment.texcoord[2];
ADD R0.x, R0, -c[3];
MUL R0.y, R2.x, R0;
MAD R0.y, R2, R0.x, R0;
MAD R0.x, R2, R0, -R0.w;
ADD R0.y, -R0, c[3];
ADD R0.x, -R0, c[3];
MAX R1.w, R1.x, c[9].z;
MAD R0.y, R0.z, c[2], R0;
MAD R0.x, R0.z, c[2], R0;
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[6];
MUL R1.xyz, R0, c[1];
MUL R0.xyz, R0, fragment.texcoord[3];
MUL R1.xyz, R1.w, R1;
MAD result.color.xyz, R1, c[9].y, R0;
MOV result.color.w, R0;
END
# 72 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 93 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c8, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c9, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c10, 0.41999999, 2.00000000, -1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.x, c5.w
mad r0.x, r0, c8, c8.y
mul r0.y, r0.x, c8.z
mov r0.x, c5.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c9, c9.y
frc r0.x, r0
mad r1.x, r0, c9.z, c9.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c5.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c5.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c5.x
add r0.w, -r0.z, c5.y
mov r0.x, c4
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c8.w
mov r0.y, c4
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c7.x, r0
mov r0.y, c3.w
dp3_pp r0.x, v1, v1
mad_pp r2.x, r0.w, c7, -r0.z
mad r0.y, r0, c8.x, c8
mul r0.z, r0.y, c8
mov r0.y, c3.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c9.x, c9.y
frc r0.w, r0
add r0.z, r0, c10.x
rcp r0.z, r0.z
mul r1.zw, r0.xyxy, r0.z
mad r1.x, r0.w, c9.z, c9.w
sincos r0.xy, r1.x
mad r0.zw, r2.x, r1, v0
add r0.w, r0, -c3.y
mul r1.x, r0.w, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c3.x
mad r1.y, r0.z, r0, r0.w
mad r0.w, r0.z, r0.x, -r1.x
add r1.x, -r1.y, c3.y
mov r0.z, c2.y
mad r1.y, c0, r0.z, r1.x
add r0.w, -r0, c3.x
mov r0.z, c2.x
mad r1.x, c0.y, r0.z, r0.w
texld r2.yw, r1, s2
mad_pp r1.xy, r2.wyzw, c10.y, c10.z
mul_pp r0.zw, r1.xyxy, r1.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r2.y, -r0.z, c8
mad r0.zw, r2.x, r1, v0.xyxy
add r0.w, r0, -c3.y
mul r1.w, r0.y, r0
rsq_pp r1.z, r2.y
rcp_pp r1.z, r1.z
mul r0.w, r0.x, r0
add r0.z, r0, -c3.x
mad r0.y, r0, r0.z, r0.w
mad r0.z, r0.x, r0, -r1.w
dp3_pp r1.x, r1, v2
mov r0.x, c2.y
add r0.y, -r0, c3
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c3.x
mov r0.x, c2
mad r0.x, c0.y, r0, r0.z
texld r0, r0, s1
mul r0, r0, c6
max_pp r1.w, r1.x, c10
mul_pp r1.xyz, r0, c1
mul_pp r0.xyz, r0, v3
mul_pp r1.xyz, r1.w, r1
mad_pp oC0.xyz, r1, c10.y, r0
mov_pp oC0.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 176 // 132 used size, 11 vars
Vector 16 [_LightColor0] 4
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_BumpMap] 2D 1
// 48 instructions, 3 temp regs, 0 temp arrays:
// ALU 41 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfchkklggjldpckiohilffgdkemlnnkiaabaaaaaabaaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcaiahaaaaeaaaaaaamcabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
abeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaa
agaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaa
aaaaaaaabcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaa
pgbobaaaabaaaaaafgiecaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaa
aaaaaaaaagaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaa
agaaaaaadcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaa
abaaaaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaa
aaaaaaaaafaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
diaaaaaibcaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadp
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
akaabaiaebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
mcaabaaaaaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaa
aaaaaaaackbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaah
pcaabaaaabaaaaaalgalbaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaaj
pcaabaaaaaaaaaaaegaobaaaaaaaaaaabgibcaiaebaaaaaaaaaaaaaaaeaaaaaa
dcaaaaakbcaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdl
abeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
nlapejeadcaaaaalbcaabaaaabaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaabaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaa
acaaaaaaakaabaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaa
agaabaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaa
acaaaaaaagaibaiaebaaaaaaabaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaa
aaaaaaaaagaabaaaacaaaaaafgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaa
agacbaiaebaaaaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaadcaaaaalmcaabaaa
abaaaaaafgifcaaaaaaaaaaaadaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaa
aaaaaaaaaaaaaaajdcaabaaaaaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaa
aaaaaaaaaeaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
ngafbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
# 51 ALU, 3 TEX
PARAM c[9] = { program.local[0..6],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 8 } };
TEMP R0;
TEMP R1;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[7], c[7].y;
MOV R1.x, c[0].y;
MUL R0.x, R0, c[7].z;
MAD R0.y, R1.x, c[4].z, R0.x;
COS R0.x, R0.y;
SIN R0.z, R0.y;
ADD R0.y, fragment.texcoord[0].w, -c[4];
MUL R0.w, R0.y, R0.z;
MUL R1.y, R0.x, R0;
ADD R0.y, fragment.texcoord[0].z, -c[4].x;
MAD R0.x, R0.y, R0, -R0.w;
MAD R0.z, R0.y, R0, R1.y;
ADD R0.y, -R0.z, c[4];
ADD R0.x, -R0, c[4];
MAD R0.y, R1.x, c[3], R0;
MAD R0.x, R1, c[3], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[6];
MUL R1.y, R0.x, c[7].w;
MAD R0.w, R0, c[6].x, -R1.y;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[8].x;
RCP R0.z, R0.z;
MUL R0.xy, R0, R0.z;
MAD R0.xy, R0.w, R0, fragment.texcoord[0];
MOV R1.y, c[2].w;
MAD R1.y, R1, c[7].x, c[7];
MUL R0.z, R1.y, c[7];
MAD R0.z, R1.x, c[2], R0;
ADD R1.y, R0, -c[2];
SIN R0.y, R0.z;
COS R0.w, R0.z;
MUL R0.z, R0.w, R1.y;
MUL R1.y, R1, R0;
ADD R0.x, R0, -c[2];
MAD R0.y, R0.x, R0, R0.z;
MAD R0.w, R0.x, R0, -R1.y;
ADD R0.x, -R0.w, c[2];
ADD R0.y, -R0, c[2];
MAD R0.x, R1, c[1], R0;
MAD R0.y, R1.x, c[1], R0;
TEX R1, fragment.texcoord[2], texture[3], 2D;
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[5];
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0, R1;
MOV result.color.w, R0;
MUL result.color.xyz, R0, c[8].y;
END
# 51 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [unity_Lightmap] 2D
"ps_3_0
; 71 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c7, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c8, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c9, 0.41999999, 8.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xy
mov r0.x, c4.w
mad r0.x, r0, c7, c7.y
mul r0.y, r0.x, c7.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c8, c8.y
frc r0.x, r0
mad r1.x, r0, c8.z, c8.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c7.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
mov r0.y, c2.w
dp3_pp r0.x, v1, v1
mad_pp r1.z, r0.w, c6.x, -r0
mad r0.y, r0, c7.x, c7
mul r0.z, r0.y, c7
mov r0.y, c2.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c8.x, c8.y
frc r0.w, r0
add r0.z, r0, c9.x
rcp r0.z, r0.z
mul r1.xy, r0, r0.z
mad r1.w, r0, c8.z, c8
sincos r0.xy, r1.w
mad r0.zw, r1.z, r1.xyxy, v0.xyxy
add r0.w, r0, -c2.y
mul r1.x, r0.w, r0
mul r0.w, r0, r0.y
add r0.z, r0, -c2.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.y
texld r1, v2, s3
add r0.z, -r0, c2.y
mov r0.y, c1
mad r0.y, c0, r0, r0.z
texld r0, r0, s1
mul r0, r0, c5
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r0, r1
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, c9.y
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 192 // 132 used size, 12 vars
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 1
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
// 40 instructions, 3 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedpmkiibcjminoenlndljogobichamacmiabaaaaaaoeagaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcpeafaaaaeaaaaaaahnabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaa
gballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaa
abaaaaaafgiecaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaaaaaaaaaa
agaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaa
dcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaabaaaaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaa
afaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadpdcaaaaal
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaakaabaia
ebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaa
ckbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahgcaabaaa
aaaaaaaapgaobaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaabgbfbaaaabaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegaabaaaaaaaaaaabgifcaiaebaaaaaaaaaaaaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejea
dcaaaaalecaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaaabaaaaaa
aaaaaaaackaabaaaaaaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaa
ckaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaaagaebaaaaaaaaaaaagaabaaa
abaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
ckaabaiaebaaaaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaadcaaaaalccaabaaaabaaaaaa
bkiacaaaaaaaaaaaadaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
aeaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 78 ALU, 5 TEX
PARAM c[12] = { program.local[0..6],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 2, 8 },
		{ -0.40824828, -0.70710677, 0.57735026 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[7], c[7].y;
MOV R1.w, c[0].y;
MUL R0.x, R0, c[7].z;
MAD R0.x, R1.w, c[4].z, R0;
COS R0.y, R0.x;
SIN R0.z, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[4].y;
MUL R0.w, R0.x, R0.z;
MUL R1.x, R0.y, R0;
ADD R0.x, fragment.texcoord[0].z, -c[4];
MAD R0.z, R0.x, R0, R1.x;
MAD R0.x, R0, R0.y, -R0.w;
ADD R0.y, -R0.z, c[4];
ADD R0.x, -R0, c[4];
MAD R0.y, R1.w, c[3], R0;
MAD R0.x, R1.w, c[3], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[6];
MUL R1.x, R0, c[7].w;
MAD R3.x, R0.w, c[6], -R1;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[8].x;
RCP R0.z, R0.z;
MUL R2.xy, R0, R0.z;
MAD R0.xy, R3.x, R2, fragment.texcoord[0].zwzw;
MOV R0.w, c[2];
MAD R0.w, R0, c[7].x, c[7].y;
MUL R0.z, R0.w, c[7];
MAD R0.z, R1.w, c[2], R0;
SIN R2.w, R0.z;
COS R2.z, R0.z;
ADD R0.y, R0, -c[2];
MUL R0.z, R2, R0.y;
ADD R0.x, R0, -c[2];
MUL R0.y, R2.w, R0;
MAD R2.xy, R3.x, R2, fragment.texcoord[0];
MAD R0.y, R2.z, R0.x, -R0;
MAD R0.z, R2.w, R0.x, R0;
ADD R0.x, -R0.y, c[2];
ADD R0.y, -R0.z, c[2];
MAD R0.x, R1.w, c[1], R0;
MAD R0.y, R1.w, c[1], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R0.z, c[7].y;
MAD R0.xy, R0.wyzw, c[8].y, -R0.z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[7].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3_SAT R1.z, R0, c[9];
DP3_SAT R1.y, R0, c[10];
DP3_SAT R1.x, R0, c[11];
TEX R0, fragment.texcoord[2], texture[4], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
ADD R0.w, R2.y, -c[2].y;
DP3 R2.y, R0, c[8].z;
ADD R0.x, R2, -c[2];
MUL R0.z, R2, R0.w;
MUL R0.y, R0.w, R2.w;
MAD R0.y, R0.x, R2.z, -R0;
MAD R0.z, R0.x, R2.w, R0;
ADD R0.x, -R0.y, c[2];
ADD R0.y, -R0.z, c[2];
MAD R0.x, R1.w, c[1], R0;
MAD R0.y, R1.w, c[1], R0;
TEX R1, fragment.texcoord[2], texture[3], 2D;
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[5];
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, R2.y;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[8].z;
MOV result.color.w, R0;
END
# 78 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_3_0
; 97 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c7, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c8, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c9, 0.41999999, 2.00000000, -1.00000000, 8.00000000
def c10, -0.40824828, -0.70710677, 0.57735026, 0
def c11, -0.40824831, 0.70710677, 0.57735026, 0
def c12, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xy
mov r0.x, c4.w
mad r0.x, r0, c7, c7.y
mul r0.y, r0.x, c7.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c8, c8.y
frc r0.x, r0
mad r1.x, r0, c8.z, c8.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c7.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
dp3_pp r0.x, v1, v1
mad_pp r1.w, r0, c6.x, -r0.z
mov r0.y, c2.w
mad r0.w, r0.y, c7.x, c7.y
mul r1.x, r0.w, c7.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mov r0.w, c2.z
mad r0.w, c0.y, r0, r1.x
add r0.z, r0, c9.x
rcp r0.z, r0.z
mul r3.xy, r0, r0.z
mad r0.xy, r1.w, r3, v0.zwzw
mad r0.w, r0, c8.x, c8.y
frc r0.w, r0
mad r0.z, r0.w, c8, c8.w
sincos r2.xy, r0.z
add r0.y, r0, -c2
mul r0.z, r2.y, r0.y
add r0.x, r0, -c2
mad r0.z, r2.x, r0.x, -r0
mul r0.y, r2.x, r0
mad r0.y, r2, r0.x, r0
mad r2.zw, r1.w, r3.xyxy, v0.xyxy
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r0.yw, r0, s2
mad_pp r0.xy, r0.wyzw, c9.y, c9.z
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c7.y
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp_sat r1.z, r0, c10
dp3_pp_sat r1.y, r0, c11
dp3_pp_sat r1.x, r0, c12
texld r0, v2, s4
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
add r0.w, r2, -c2.y
dp3_pp r2.w, r0, c9.w
texld r1, v2, s3
mul_pp r1.xyz, r1.w, r1
add r0.x, r2.z, -c2
mul r0.z, r0.w, r2.x
mul r0.y, r0.w, r2
mad r0.y, r0.x, r2.x, -r0
mad r0.z, r0.x, r2.y, r0
add r0.y, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.y
add r0.z, -r0, c2.y
mov r0.y, c1
mad r0.y, c0, r0, r0.z
texld r0, r0, s1
mul r0, r0, c5
mul_pp r1.xyz, r1, r2.w
mul_pp r0.xyz, r0, r1
mul_pp oC0.xyz, r0, c9.w
mov_pp oC0.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 192 // 132 used size, 12 vars
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_BumpMap] 2D 1
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
// 54 instructions, 3 temp regs, 0 temp arrays:
// ALU 45 float, 0 int, 0 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedilkbpeldgagmlminipghhomfngajmgdlabaaaaaapeaiaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaeaiaaaaeaaaaaaaabacaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadcaaaaak
bcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaanlapejea
dcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaabkiacaaaabaaaaaa
aaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaaabaaaaaafgiecaia
ebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaaaaaaaaaaagaabaaaaaaaaaaa
fgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaadcaaaaalccaabaaa
abaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaabaaaaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaibcaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadpdcaaaaalbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaafgafbaaa
aaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaackbabaaaacaaaaaa
bkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahpcaabaaaabaaaaaalgalbaaa
aaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaajpcaabaaaaaaaaaaaegaobaaa
aaaaaaaabgibcaiaebaaaaaaaaaaaaaaaeaaaaaadcaaaaakbcaabaaaabaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeadcaaaaalbcaabaaa
abaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaa
abaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaadcaaaaak
kcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaaagaibaiaebaaaaaa
abaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaaaaaaaaaaagaabaaaacaaaaaa
fgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaaagacbaiaebaaaaaaaaaaaaaa
fgifcaaaaaaaaaaaaeaaaaaadcaaaaalmcaabaaaabaaaaaafgifcaaaaaaaaaaa
adaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaaaaaaaaaaaeaaaaaadcaaaaal
dcaabaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaafgifcaaaabaaaaaaaaaaaaaa
egaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaangafbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaaapcaaaakbcaabaaa
acaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaaaaaaaaa
bacaaaakccaabaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
egacbaaaaaaaaaaabacaaaakecaabaaaacaaaaaaaceaaaaaolafnblopdaedflp
dkmnbddpaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 74 ALU, 4 TEX
PARAM c[10] = { program.local[0..7],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 2, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[5].w;
MAD R0.x, R0, c[8], c[8].y;
MOV R1.z, c[0].y;
MUL R0.x, R0, c[8].z;
MAD R0.x, R1.z, c[5].z, R0;
COS R0.y, R0.x;
SIN R0.z, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[5].y;
MUL R0.w, R0.x, R0.z;
MUL R1.x, R0.y, R0;
ADD R0.x, fragment.texcoord[0].z, -c[5];
MAD R0.z, R0.x, R0, R1.x;
MAD R0.x, R0, R0.y, -R0.w;
ADD R0.y, -R0.z, c[5];
ADD R0.x, -R0, c[5];
MAD R0.y, R1.z, c[4], R0;
MAD R0.x, R1.z, c[4], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[7];
MUL R1.x, R0, c[8].w;
MAD R2.x, R0.w, c[7], -R1;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[9].x;
RCP R0.z, R0.z;
MUL R1.xy, R0, R0.z;
MAD R0.xy, R2.x, R1, fragment.texcoord[0].zwzw;
MOV R0.w, c[3];
MAD R0.w, R0, c[8].x, c[8].y;
MUL R0.z, R0.w, c[8];
MAD R0.z, R1, c[3], R0;
COS R1.w, R0.z;
SIN R2.y, R0.z;
ADD R0.y, R0, -c[3];
MUL R0.z, R1.w, R0.y;
ADD R0.x, R0, -c[3];
MUL R0.y, R0, R2;
MAD R0.y, R0.x, R1.w, -R0;
MAD R0.z, R0.x, R2.y, R0;
ADD R0.x, -R0.y, c[3];
ADD R0.y, -R0.z, c[3];
MAD R0.x, R1.z, c[2], R0;
MAD R0.y, R1.z, c[2], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R0.z, c[8].y;
MAD R0.xy, R0.wyzw, c[9].y, -R0.z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[8].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.x, R0, fragment.texcoord[2];
MAD R1.xy, R2.x, R1, fragment.texcoord[0];
ADD R0.z, R1.y, -c[3].y;
MAX R0.y, R0.x, c[9].z;
MUL R0.w, R2.y, R0.z;
ADD R0.x, R1, -c[3];
MUL R0.z, R1.w, R0;
MAD R0.z, R2.y, R0.x, R0;
MAD R0.x, R1.w, R0, -R0.w;
ADD R0.z, -R0, c[3].y;
MAD R0.w, R1.z, c[2].y, R0.z;
ADD R0.x, -R0, c[3];
MAD R0.z, R1, c[2].x, R0.x;
TEX R1, R0.zwzw, texture[1], 2D;
MUL R1, R1, c[6];
TXP R0.x, fragment.texcoord[4], texture[3], 2D;
MUL R0.w, R0.y, R0.x;
MUL R0.xyz, R1, c[1];
MUL R1.xyz, R1, fragment.texcoord[3];
MUL R0.xyz, R0.w, R0;
MAD result.color.xyz, R0, c[9].y, R1;
MOV result.color.w, R1;
END
# 74 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
"ps_3_0
; 94 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c8, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c9, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c10, 0.41999999, 2.00000000, -1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
mov r0.x, c5.w
mad r0.x, r0, c8, c8.y
mul r0.y, r0.x, c8.z
mov r0.x, c5.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c9, c9.y
frc r0.x, r0
mad r1.x, r0, c9.z, c9.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c5.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c5.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c5.x
add r0.w, -r0.z, c5.y
mov r0.x, c4
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c8.w
mov r0.y, c4
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c7.x, r0
mov r0.y, c3.w
dp3_pp r0.x, v1, v1
mad_pp r1.z, r0.w, c7.x, -r0
mad r0.y, r0, c8.x, c8
mul r0.z, r0.y, c8
mov r0.y, c3.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c9.x, c9.y
frc r0.w, r0
add r0.z, r0, c10.x
rcp r0.z, r0.z
mad r1.w, r0, c9.z, c9
mul r1.xy, r0, r0.z
sincos r0.xy, r1.w
mad r0.zw, r1.z, r1.xyxy, v0
add r0.w, r0, -c3.y
mul r1.w, r0, r0.y
mad r1.xy, r1.z, r1, v0
mul r0.w, r0, r0.x
add r0.z, r0, -c3.x
mad r2.x, r0.z, r0.y, r0.w
mad r0.w, r0.z, r0.x, -r1
add r1.w, -r2.x, c3.y
mov r0.z, c2.y
mad r2.y, c0, r0.z, r1.w
add r0.w, -r0, c3.x
mov r0.z, c2.x
mad r2.x, c0.y, r0.z, r0.w
texld r2.yw, r2, s2
mad_pp r2.xy, r2.wyzw, c10.y, c10.z
mul_pp r0.zw, r2.xyxy, r2.xyxy
add_pp_sat r0.z, r0, r0.w
add r0.w, r1.y, -c3.y
add_pp r0.z, -r0, c8.y
rsq_pp r0.z, r0.z
rcp_pp r2.z, r0.z
dp3_pp r0.z, r2, v2
mul r1.y, r0, r0.w
mul r1.z, r0.x, r0.w
add r0.w, r1.x, -c3.x
mad r0.y, r0, r0.w, r1.z
mad r0.w, r0.x, r0, -r1.y
max_pp r0.z, r0, c10.w
mov r0.x, c2.y
add r0.y, -r0, c3
mad r0.y, c0, r0.x, r0
add r0.w, -r0, c3.x
mov r0.x, c2
mad r0.x, c0.y, r0, r0.w
texld r1, r0, s1
mul r1, r1, c6
texldp r0.x, v4, s3
mul_pp r0.w, r0.z, r0.x
mul_pp r0.xyz, r1, c1
mul_pp r1.xyz, r1, v3
mul_pp r0.xyz, r0.w, r0
mad_pp oC0.xyz, r0, c10.y, r1
mov_pp oC0.w, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 240 // 196 used size, 12 vars
Vector 16 [_LightColor0] 4
Vector 112 [_PanMT] 4
Vector 128 [_RotMT] 4
Vector 144 [_PanPM] 4
Vector 160 [_RotPM] 4
Vector 176 [_Color] 4
Float 192 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 3
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
// 50 instructions, 3 temp regs, 0 temp arrays:
// ALU 42 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhgknjgepphlcpfbfpiaenclaammfnpcdabaaaaaajaaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchaahaaaa
eaaaaaaanmabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaa
abeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaa
akaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaa
aaaaaaaabcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaa
pgbobaaaabaaaaaafgiecaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaahjcaabaaa
aaaaaaaaagaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaa
akaaaaaadcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkiacaaa
abaaaaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaa
aaaaaaaaajaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaa
diaaaaaibcaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaadp
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
akaabaiaebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
mcaabaaaaaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaa
aaaaaaaackbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaah
pcaabaaaabaaaaaalgalbaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaaj
pcaabaaaaaaaaaaaegaobaaaaaaaaaaabgibcaiaebaaaaaaaaaaaaaaaiaaaaaa
dcaaaaakbcaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaagballgdl
abeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
nlapejeadcaaaaalbcaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaabaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaa
acaaaaaaakaabaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaa
agaabaaaabaaaaaadcaaaaakkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaa
acaaaaaaagaibaiaebaaaaaaabaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaa
aaaaaaaaagaabaaaacaaaaaafgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaa
agacbaiaebaaaaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaadcaaaaalmcaabaaa
abaaaaaafgifcaaaaaaaaaaaahaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaa
aaaaaaaaaaaaaaajdcaabaaaaaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaa
aaaaaaaaaiaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
ngafbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaalaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaoaaaaah
gcaabaaaaaaaaaaaagbbbaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaa
acaaaaaajgafbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaacaaaaaadiaaaaaiocaabaaa
aaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
# 57 ALU, 4 TEX
PARAM c[9] = { program.local[0..6],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2, fragment.texcoord[2], texture[4], 2D;
MUL R3.xyz, R2.w, R2;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[7], c[7].y;
MUL R0.y, R0.x, c[7].z;
MOV R0.x, c[0].y;
MAD R0.y, R0.x, c[4].z, R0;
COS R0.z, R0.y;
SIN R0.w, R0.y;
ADD R0.y, fragment.texcoord[0].w, -c[4];
MUL R1.x, R0.y, R0.w;
MUL R1.y, R0.z, R0;
ADD R0.y, fragment.texcoord[0].z, -c[4].x;
MAD R0.w, R0.y, R0, R1.y;
MAD R0.y, R0, R0.z, -R1.x;
ADD R0.z, -R0.w, c[4].y;
MAD R0.w, R0.x, c[3].y, R0.z;
ADD R0.y, -R0, c[4].x;
MAD R0.z, R0.x, c[3].x, R0.y;
TEX R0.w, R0.zwzw, texture[0], 2D;
DP3 R0.z, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.z, R0.z;
MUL R1.xyz, R0.z, fragment.texcoord[1];
ADD R0.z, R1, c[8].x;
MOV R0.y, c[6].x;
MUL R0.y, R0, c[7].w;
MAD R0.y, R0.w, c[6].x, -R0;
MOV R0.w, c[2];
MAD R1.z, R0.w, c[7].x, c[7].y;
RCP R0.z, R0.z;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0.y, R0, fragment.texcoord[0].xyxy;
MUL R1.x, R1.z, c[7].z;
MAD R0.y, R0.x, c[2].z, R1.x;
ADD R1.x, R0.w, -c[2].y;
SIN R1.y, R0.y;
COS R0.w, R0.y;
MUL R1.z, R1.x, R1.y;
MUL R1.x, R0.w, R1;
ADD R0.y, R0.z, -c[2].x;
MAD R0.z, R0.y, R1.y, R1.x;
MAD R0.y, R0, R0.w, -R1.z;
ADD R0.w, -R0.z, c[2].y;
ADD R0.z, -R0.y, c[2].x;
MAD R0.y, R0.x, c[1], R0.w;
MAD R0.x, R0, c[1], R0.z;
TEX R1, R0, texture[1], 2D;
TXP R0.x, fragment.texcoord[3], texture[3], 2D;
MUL R2.xyz, R2, R0.x;
MUL R3.xyz, R3, c[8].y;
MUL R1, R1, c[5];
MUL R2.xyz, R2, c[8].z;
MUL R0.xyz, R3, R0.x;
MIN R2.xyz, R3, R2;
MAX R0.xyz, R2, R0;
MUL result.color.xyz, R1, R0;
MOV result.color.w, R1;
END
# 57 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
"ps_3_0
; 76 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
def c7, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c8, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c9, 0.41999999, 8.00000000, 2.00000000, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
texld r2, v2, s4
mul_pp r3.xyz, r2.w, r2
mov r0.x, c4.w
mad r0.x, r0, c7, c7.y
mul r0.y, r0.x, c7.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c8, c8.y
frc r0.x, r0
mad r1.x, r0, c8.z, c8.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c7.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
mov r0.y, c2.w
dp3_pp r0.x, v1, v1
mad_pp r1.x, r0.w, c6, -r0.z
mad r0.y, r0, c7.x, c7
mul r0.z, r0.y, c7
mov r0.y, c2.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c8.x, c8.y
frc r0.w, r0
add r0.z, r0, c9.x
rcp r0.z, r0.z
mad r1.y, r0.w, c8.z, c8.w
mul r1.zw, r0.xyxy, r0.z
sincos r0.xy, r1.y
mad r0.zw, r1.x, r1, v0.xyxy
add r0.w, r0, -c2.y
mul r1.x, r0.w, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c2.x
mad r0.y, r0.z, r0, r0.w
mad r0.z, r0, r0.x, -r1.x
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r1, r0, s1
texldp r0.x, v3, s3
mul_pp r2.xyz, r2, r0.x
mul_pp r3.xyz, r3, c9.y
mul r1, r1, c5
mul_pp r2.xyz, r2, c9.z
mul_pp r0.xyz, r3, r0.x
min_pp r2.xyz, r3, r2
max_pp r0.xyz, r2, r0
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 256 // 196 used size, 13 vars
Vector 112 [_PanMT] 4
Vector 128 [_RotMT] 4
Vector 144 [_PanPM] 4
Vector 160 [_RotPM] 4
Vector 176 [_Color] 4
Float 192 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 2
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
// 47 instructions, 3 temp regs, 0 temp arrays:
// ALU 39 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddpdhgejodnddndhlghkgcgdoiifaojonabaaaaaapaahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiagaaaaeaaaaaaalkabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaaddcbabaaa
adaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaaabeaaaaa
gballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaakaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaa
abaaaaaafgiecaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaahjcaabaaaaaaaaaaa
agaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaakaaaaaa
dcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkiacaaaabaaaaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaa
ajaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaadpdcaaaaal
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaakaabaia
ebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaa
ckbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahgcaabaaa
aaaaaaaapgaobaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaabgbfbaaaabaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegaabaaaaaaaaaaabgifcaiaebaaaaaaaaaaaaaaaiaaaaaadcaaaaak
ecaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejea
dcaaaaalecaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaabkiacaaaabaaaaaa
aaaaaaaackaabaaaaaaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaa
ckaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaaagaebaaaaaaaaaaaagaabaaa
abaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
ckaabaiaebaaaaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaaabaaaaaa
bkiacaaaaaaaaaaaahaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahocaabaaaabaaaaaa
fgafbaaaabaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgapbaaaacaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaa
acaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
deaaaaahhcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 84 ALU, 6 TEX
PARAM c[12] = { program.local[0..6],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 2, 8 },
		{ -0.40824828, -0.70710677, 0.57735026 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[7], c[7].y;
MOV R2.w, c[0].y;
MUL R0.x, R0, c[7].z;
MAD R0.x, R2.w, c[4].z, R0;
COS R0.y, R0.x;
SIN R0.z, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[4].y;
MUL R0.w, R0.x, R0.z;
MUL R1.x, R0.y, R0;
ADD R0.x, fragment.texcoord[0].z, -c[4];
MAD R0.z, R0.x, R0, R1.x;
MAD R0.x, R0, R0.y, -R0.w;
ADD R0.y, -R0.z, c[4];
ADD R0.x, -R0, c[4];
MAD R0.y, R2.w, c[3], R0;
MAD R0.x, R2.w, c[3], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[6];
MUL R1.x, R0, c[7].w;
MAD R3.z, R0.w, c[6].x, -R1.x;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[8].x;
RCP R0.z, R0.z;
MUL R3.xy, R0, R0.z;
MAD R0.xy, R3.z, R3, fragment.texcoord[0].zwzw;
MOV R0.w, c[2];
MAD R0.w, R0, c[7].x, c[7].y;
MUL R0.z, R0.w, c[7];
MAD R0.z, R2.w, c[2], R0;
SIN R4.x, R0.z;
COS R3.w, R0.z;
ADD R0.y, R0, -c[2];
MUL R0.z, R3.w, R0.y;
ADD R0.x, R0, -c[2];
MUL R0.y, R4.x, R0;
MAD R0.y, R3.w, R0.x, -R0;
MAD R0.z, R4.x, R0.x, R0;
ADD R0.x, -R0.y, c[2];
ADD R0.y, -R0.z, c[2];
MAD R0.x, R2.w, c[1], R0;
MAD R0.y, R2.w, c[1], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R0.z, c[7].y;
MAD R2.xy, R0.wyzw, c[8].y, -R0.z;
MUL R0.xy, R2, R2;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[7].y;
RSQ R0.x, R0.x;
RCP R2.z, R0.x;
TEX R0, fragment.texcoord[2], texture[5], 2D;
DP3_SAT R1.z, R2, c[9];
DP3_SAT R1.y, R2, c[10];
DP3_SAT R1.x, R2, c[11];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
DP3 R0.y, R0, c[8].z;
TEX R1, fragment.texcoord[2], texture[4], 2D;
MUL R2.xyz, R1.w, R1;
TXP R0.x, fragment.texcoord[3], texture[3], 2D;
MUL R2.xyz, R2, R0.y;
MAD R0.zw, R3.z, R3.xyxy, fragment.texcoord[0].xyxy;
MUL R1.xyz, R1, R0.x;
ADD R0.y, R0.w, -c[2];
MUL R0.w, R0.y, R4.x;
MUL R2.xyz, R2, c[8].z;
MUL R1.xyz, R1, c[8].y;
MIN R1.xyz, R2, R1;
MUL R2.xyz, R2, R0.x;
ADD R0.x, R0.z, -c[2];
MUL R0.y, R3.w, R0;
MAD R0.y, R0.x, R4.x, R0;
MAD R0.x, R0, R3.w, -R0.w;
ADD R0.y, -R0, c[2];
ADD R0.x, -R0, c[2];
MAD R0.y, R2.w, c[1], R0;
MAD R0.x, R2.w, c[1], R0;
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[5];
MAX R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 84 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_ShadowMapTexture] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 102 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c7, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c8, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c9, 0.41999999, 2.00000000, -1.00000000, 8.00000000
def c10, -0.40824828, -0.70710677, 0.57735026, 0
def c11, -0.40824831, 0.70710677, 0.57735026, 0
def c12, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xy
dcl_texcoord3 v3
mov r0.x, c4.w
mad r0.x, r0, c7, c7.y
mul r0.y, r0.x, c7.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c8, c8.y
frc r0.x, r0
mad r1.x, r0, c8.z, c8.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c7.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
dp3_pp r0.x, v1, v1
mad_pp r3.w, r0, c6.x, -r0.z
mov r0.y, c2.w
mad r0.w, r0.y, c7.x, c7.y
mul r1.x, r0.w, c7.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mov r0.w, c2.z
mad r0.w, c0.y, r0, r1.x
add r0.z, r0, c9.x
rcp r0.z, r0.z
mul r4.xy, r0, r0.z
mad r0.xy, r3.w, r4, v0.zwzw
mad r0.w, r0, c8.x, c8.y
frc r0.w, r0
mad r0.z, r0.w, c8, c8.w
sincos r1.xy, r0.z
add r0.y, r0, -c2
mul r0.z, r1.y, r0.y
add r0.x, r0, -c2
mad r0.z, r1.x, r0.x, -r0
mul r0.y, r1.x, r0
mad r0.y, r1, r0.x, r0
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r0.yw, r0, s2
mad_pp r3.xy, r0.wyzw, c9.y, c9.z
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c7.y
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
texld r0, v2, s5
dp3_pp_sat r2.z, r3, c10
dp3_pp_sat r2.y, r3, c11
dp3_pp_sat r2.x, r3, c12
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r2
dp3_pp r0.y, r0, c9.w
texld r2, v2, s4
mul_pp r3.xyz, r2.w, r2
texldp r0.x, v3, s3
mul_pp r3.xyz, r3, r0.y
mad r0.zw, r3.w, r4.xyxy, v0.xyxy
mul_pp r2.xyz, r2, r0.x
add r0.y, r0.w, -c2
mul r0.w, r0.y, r1.y
mul r0.y, r0, r1.x
mul_pp r3.xyz, r3, c9.w
mul_pp r2.xyz, r2, c9.y
min_pp r2.xyz, r3, r2
mul_pp r3.xyz, r3, r0.x
add r0.x, r0.z, -c2
mad r0.z, r0.x, r1.x, -r0.w
mad r0.y, r0.x, r1, r0
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r0, r0, s1
mul r0, r0, c5
max_pp r1.xyz, r2, r3
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 256 // 196 used size, 13 vars
Vector 112 [_PanMT] 4
Vector 128 [_RotMT] 4
Vector 144 [_PanPM] 4
Vector 160 [_RotPM] 4
Vector 176 [_Color] 4
Float 192 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 3
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
// 61 instructions, 4 temp regs, 0 temp arrays:
// ALU 51 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddnckbdkbjjlccedelbmcapdoepbgaeaoabaaaaaaaaakaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpiaiaaaaeaaaaaaadoacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadcaaaaak
bcaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaanlapejea
dcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaakaaaaaabkiacaaaabaaaaaa
aaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaaabaaaaaafgiecaia
ebaaaaaaaaaaaaaaakaaaaaadiaaaaahjcaabaaaaaaaaaaaagaabaaaaaaaaaaa
fgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaalccaabaaa
abaaaaaabkiacaaaaaaaaaaaajaaaaaabkiacaaaabaaaaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadiaaaaaibcaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaadpdcaaaaalbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaakaabaiaebaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaafgafbaaa
aaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaackbabaaaacaaaaaa
bkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahpcaabaaaabaaaaaalgalbaaa
aaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaajpcaabaaaaaaaaaaaegaobaaa
aaaaaaaabgibcaiaebaaaaaaaaaaaaaaaiaaaaaadcaaaaakbcaabaaaabaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaabeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeadcaaaaalbcaabaaa
abaaaaaackiacaaaaaaaaaaaaiaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaa
abaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaadcaaaaak
kcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaaagaibaiaebaaaaaa
abaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaaaaaaaaaaagaabaaaacaaaaaa
fgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaaagacbaiaebaaaaaaaaaaaaaa
fgifcaaaaaaaaaaaaiaaaaaadcaaaaalmcaabaaaabaaaaaafgifcaaaaaaaaaaa
ahaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaadcaaaaal
dcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaafgifcaaaabaaaaaaaaaaaaaa
egaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaangafbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaalaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaaapcaaaakbcaabaaa
acaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaaaaaaaaa
bacaaaakccaabaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
egacbaaaaaaaaaaabacaaaakecaabaaaacaaaaaaaceaaaaaolafnblopdaedflp
dkmnbddpaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
adaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
aoaaaaahdcaabaaaadaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaaaaaaaaaagaabaaaadaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaddaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadeaaaaahhcaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 26 to 35
//   d3d9 - ALU: 29 to 38
//   d3d11 - ALU: 24 to 33, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[18];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[17];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c17, r1
mad r0.xyz, r3, c18.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c16
mov r1.w, c21.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c18.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 240 // 240 used size, 12 vars
Matrix 48 [_LightMatrix0] 4
Vector 208 [_MainTex_ST] 4
Vector 224 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 34 instructions, 2 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcdameokfbbhnbjglgnlppmjkbmmghkfjabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaa
kgiocaaaaaaaaaaaaoaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_19;
  c_19.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * ((max (0.0, dot (((texture2D (_BumpMap, tmpvar_16).xyz * 2.0) - 1.0), lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_18)).w) * 2.0));
  c_19.w = tmpvar_15.w;
  c_1.xyz = c_19.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_17;
  normal_17.xy = ((texture2D (_BumpMap, tmpvar_16).wy * 2.0) - 1.0);
  normal_17.z = sqrt((1.0 - clamp (dot (normal_17.xy, normal_17.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_20;
  c_20.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_17, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_19)).w) * 2.0));
  c_20.w = tmpvar_15.w;
  c_1.xyz = c_20.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 423
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
#line 397
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
#line 401
uniform highp float _Parallax;
#line 409
#line 432
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 434
v2f_surf vert_surf( in appdata_full v ) {
    #line 436
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 440
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 444
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 448
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 423
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
#line 397
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
#line 401
uniform highp float _Parallax;
#line 409
#line 432
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 413
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 417
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 421
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 450
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 452
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 456
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 460
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    #line 464
    lowp vec4 c = LightingLambert( o, lightDir, (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * 1.0));
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Matrix 5 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [_MainTex_ST]
Vector 13 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 26 ALU
PARAM c[14] = { { 1 },
		state.matrix.mvp,
		program.local[5..13] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0.xyz, c[9];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[7];
DP4 R2.x, R0, c[5];
DP4 R2.y, R0, c[6];
MAD R0.xyz, R2, c[11].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[10];
DP4 R3.z, R1, c[7];
DP4 R3.x, R1, c[5];
DP4 R3.y, R1, c[6];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_World2Object]
Vector 10 [unity_Scale]
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c13, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c6
dp4 r4.z, c9, r0
mov r0, c5
mov r1.w, c13.x
mov r1.xyz, c8
dp4 r4.y, c9, r0
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r2.xyz, r2, c10.w, -v0
mov r1, c4
dp4 r4.x, c9, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o1.zw, v3.xyxy, c12.xyxy, c12
mad o1.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 176 // 176 used size, 11 vars
Vector 144 [_MainTex_ST] 4
Vector 160 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 25 instructions, 2 temp regs, 0 temp arrays:
// ALU 24 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjediogjdflnpbimlblngcabdadpdekhfabaaaaaakeafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
caaeaaaaeaaaabaaaiabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
aaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_17;
  c_17.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * (max (0.0, dot (((texture2D (_BumpMap, tmpvar_16).xyz * 2.0) - 1.0), lightDir_2)) * 2.0));
  c_17.w = tmpvar_15.w;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_17;
  normal_17.xy = ((texture2D (_BumpMap, tmpvar_16).wy * 2.0) - 1.0);
  normal_17.z = sqrt((1.0 - clamp (dot (normal_17.xy, normal_17.xy), 0.0, 1.0)));
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_18;
  c_18.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * (max (0.0, dot (normal_17, lightDir_2)) * 2.0));
  c_18.w = tmpvar_15.w;
  c_1.xyz = c_18.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 429
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 446
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 431
v2f_surf vert_surf( in appdata_full v ) {
    #line 433
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 437
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 441
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 429
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 446
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 446
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 450
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 454
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 458
    surf( surfIN, o);
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingLambert( o, lightDir, 1.0);
    c.w = 0.0;
    #line 462
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[18];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[17];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c17, r1
mad r0.xyz, r3, c18.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c16
mov r1.w, c21.x
dp4 r0.w, v0, c7
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c18.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 240 // 240 used size, 12 vars
Matrix 48 [_LightMatrix0] 4
Vector 208 [_MainTex_ST] 4
Vector 224 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 34 instructions, 2 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedahjnghnnndjbhdjheakbaffhdkdaaolgabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaa
kgiocaaaaaaaaaaaaoaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_17;
  highp vec2 P_18;
  P_18 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_20;
  atten_20 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_18).w) * texture2D (_LightTextureB0, vec2(tmpvar_19)).w);
  lowp vec4 c_21;
  c_21.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * ((max (0.0, dot (((texture2D (_BumpMap, tmpvar_16).xyz * 2.0) - 1.0), lightDir_2)) * atten_20) * 2.0));
  c_21.w = tmpvar_15.w;
  c_1.xyz = c_21.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_17;
  normal_17.xy = ((texture2D (_BumpMap, tmpvar_16).wy * 2.0) - 1.0);
  normal_17.z = sqrt((1.0 - clamp (dot (normal_17.xy, normal_17.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_18;
  highp vec2 P_19;
  P_19 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_20;
  tmpvar_20 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_21;
  atten_21 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_19).w) * texture2D (_LightTextureB0, vec2(tmpvar_20)).w);
  lowp vec4 c_22;
  c_22.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_17, lightDir_2)) * atten_21) * 2.0));
  c_22.w = tmpvar_15.w;
  c_1.xyz = c_22.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 411
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 432
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec4 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
#line 398
#line 402
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
#line 406
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
#line 410
uniform highp float _Parallax;
#line 418
#line 441
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 443
v2f_surf vert_surf( in appdata_full v ) {
    #line 445
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 449
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 453
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 457
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec4(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 411
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 432
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec4 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
#line 398
#line 402
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
#line 406
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
#line 410
uniform highp float _Parallax;
#line 418
#line 441
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 398
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 394
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 418
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 422
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 426
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 430
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 459
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 461
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 465
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 469
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    #line 473
    lowp vec4 c = LightingLambert( o, lightDir, (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * 1.0));
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1, c[18];
MOV R0.w, c[0].x;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[17];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.xyz, v1
mov r0, c10
dp4 r3.z, c17, r0
mov r0, c9
dp4 r3.y, c17, r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r3.x, c17, r1
mad r0.xyz, r3, c18.w, -v0
mul r2.xyz, r2, v1.w
mov r1.xyz, c16
mov r1.w, c21.x
dp3 o3.y, r2, r0
dp3 o3.z, v2, r0
dp3 o3.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c18.w, -v0
dp3 o2.y, r1, r2
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 240 // 240 used size, 12 vars
Matrix 48 [_LightMatrix0] 4
Vector 208 [_MainTex_ST] 4
Vector 224 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 34 instructions, 2 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcdameokfbbhnbjglgnlppmjkbmmghkfjabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaa
kgiocaaaaaaaaaaaaoaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_19;
  c_19.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * ((max (0.0, dot (((texture2D (_BumpMap, tmpvar_16).xyz * 2.0) - 1.0), lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_18)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_19.w = tmpvar_15.w;
  c_1.xyz = c_19.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - _glesVertex.xyz));
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_17;
  normal_17.xy = ((texture2D (_BumpMap, tmpvar_16).wy * 2.0) - 1.0);
  normal_17.z = sqrt((1.0 - clamp (dot (normal_17.xy, normal_17.xy), 0.0, 1.0)));
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_20;
  c_20.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_17, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_19)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_20.w = tmpvar_15.w;
  c_1.xyz = c_20.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 403
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform highp vec4 _PanMT;
#line 397
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
uniform highp vec4 _RotPM;
#line 401
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 410
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return ((objSpaceLightPos.xyz * unity_Scale.w) - v.xyz);
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 435
v2f_surf vert_surf( in appdata_full v ) {
    #line 437
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 441
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 445
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 449
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 403
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 424
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform highp vec4 _PanMT;
#line 397
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
uniform highp vec4 _RotPM;
#line 401
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 410
#line 433
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 410
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 414
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 418
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 422
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 451
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 453
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 457
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 461
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    #line 465
    lowp vec4 c = LightingLambert( o, lightDir, ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * 1.0));
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 19 [unity_Scale]
Matrix 13 [_LightMatrix0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 32 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0.w, c[0].x;
MOV R0.xyz, c[17];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[19].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[18];
DP3 result.texcoord[1].y, R0, R2;
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 18 [unity_Scale]
Matrix 12 [_LightMatrix0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1.w, c21.x
mov r1.xyz, c16
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c18.w, -v0
mov r1, c8
dp4 r4.x, c17, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 240 // 240 used size, 12 vars
Matrix 48 [_LightMatrix0] 4
Vector 208 [_MainTex_ST] 4
Vector 224 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720 // 16 used size, 17 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 33 instructions, 2 temp regs, 0 temp arrays:
// ALU 32 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecednobekokbaieoolfocliefmhlppnjfmpdabaaaaaapiagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfmafaaaaeaaaabaa
fhabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaa
kgiocaaaaaaaaaaaaoaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaaeaaaaaaegiacaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_17;
  c_17.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * ((max (0.0, dot (((texture2D (_BumpMap, tmpvar_16).xyz * 2.0) - 1.0), lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_17.w = tmpvar_15.w;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_1.xyz;
  tmpvar_6 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = tmpvar_2.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = tmpvar_2.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = tmpvar_2.z;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  tmpvar_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  highp vec2 tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_3 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  tmpvar_6 = (tmpvar_10 * (v_9.xy / v_9.z));
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + tmpvar_6);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.zw + tmpvar_6);
  highp vec2 tmpvar_14;
  tmpvar_14.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_14.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_15;
  tmpvar_15 = (texture2D (_MainTex, tmpvar_14) * _Color);
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_17;
  normal_17.xy = ((texture2D (_BumpMap, tmpvar_16).wy * 2.0) - 1.0);
  normal_17.z = sqrt((1.0 - clamp (dot (normal_17.xy, normal_17.xy), 0.0, 1.0)));
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_18;
  c_18.xyz = ((tmpvar_15.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_17, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_18.w = tmpvar_15.w;
  c_1.xyz = c_18.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 423
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec2 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
#line 397
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
#line 401
uniform highp float _Parallax;
#line 409
#line 432
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 82
highp vec3 ObjSpaceLightDir( in highp vec4 v ) {
    highp vec3 objSpaceLightPos = (_World2Object * _WorldSpaceLightPos0).xyz;
    return objSpaceLightPos.xyz;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 434
v2f_surf vert_surf( in appdata_full v ) {
    #line 436
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 440
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    highp vec3 lightDir = (rotation * ObjSpaceLightDir( v.vertex));
    o.lightDir = lightDir;
    #line 444
    highp vec3 viewDirForLight = (rotation * ObjSpaceViewDir( v.vertex));
    o.viewDir = viewDirForLight;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 448
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD3 = vec2(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 402
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 423
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    mediump vec3 lightDir;
    highp vec2 _LightCoord;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 393
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
#line 397
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
#line 401
uniform highp float _Parallax;
#line 409
#line 432
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 338
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 342
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 409
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 413
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 417
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 421
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 450
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 452
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 456
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 460
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 lightDir = IN.lightDir;
    #line 464
    lowp vec4 c = LightingLambert( o, lightDir, (texture( _LightTexture0, IN._LightCoord).w * 1.0));
    c.w = 0.0;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD2);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 71 to 83, TEX: 3 to 5
//   d3d9 - ALU: 92 to 102, TEX: 3 to 5
//   d3d11 - ALU: 40 to 50, TEX: 3 to 5, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 77 ALU, 4 TEX
PARAM c[10] = { program.local[0..7],
		{ 0, 0.0055555557, 1, 3.1415927 },
		{ 0.5, 0.41999999, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[5].w;
MAD R0.x, R0, c[8].y, c[8].z;
MOV R0.z, c[0].y;
MUL R0.x, R0, c[8].w;
MAD R0.x, R0.z, c[5].z, R0;
COS R1.x, R0.x;
SIN R0.w, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[5].y;
MUL R0.y, R0.x, R0.w;
ADD R1.y, fragment.texcoord[0].z, -c[5].x;
MAD R0.y, R1, R1.x, -R0;
MUL R0.x, R1, R0;
MAD R0.x, R1.y, R0.w, R0;
ADD R0.x, -R0, c[5].y;
MAD R1.y, R0.z, c[4], R0.x;
ADD R0.y, -R0, c[5].x;
MAD R1.x, R0.z, c[4], R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
MOV R0.y, c[7].x;
MOV R0.x, c[3].w;
TEX R0.w, R1, texture[0], 2D;
MUL R0.y, R0, c[9].x;
MAD R1.z, R0.w, c[7].x, -R0.y;
ADD R0.y, R2.z, c[9];
RCP R0.y, R0.y;
MUL R1.xy, R2, R0.y;
MAD R0.x, R0, c[8].y, c[8].z;
MUL R0.w, R0.x, c[8];
MAD R0.xy, R1.z, R1, fragment.texcoord[0].zwzw;
MAD R1.w, R0.z, c[3].z, R0;
SIN R2.x, R1.w;
COS R1.w, R1.w;
ADD R0.w, R0.y, -c[3].y;
MUL R0.y, R1.w, R0.w;
MAD R1.xy, R1.z, R1, fragment.texcoord[0];
ADD R0.x, R0, -c[3];
MUL R0.w, R0, R2.x;
MAD R0.w, R0.x, R1, -R0;
MAD R0.x, R0, R2, R0.y;
ADD R0.y, -R0.x, c[3];
ADD R0.w, -R0, c[3].x;
MAD R0.x, R0.z, c[2], R0.w;
MAD R0.y, R0.z, c[2], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R2.y, c[8].z;
MAD R2.yz, R0.xwyw, c[9].z, -R2.y;
MUL R0.xy, R2.yzzw, R2.yzzw;
ADD_SAT R0.x, R0, R0.y;
ADD R0.y, -R0.x, c[8].z;
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RCP R2.w, R0.y;
RSQ R0.x, R0.x;
MUL R0.xyw, R0.x, fragment.texcoord[2].xyzz;
DP3 R0.y, R2.yzww, R0.xyww;
ADD R0.x, R1.y, -c[3].y;
MAX R1.y, R0, c[8].x;
MUL R0.y, R2.x, R0.x;
ADD R0.w, R1.x, -c[3].x;
MAD R0.y, R1.w, R0.w, -R0;
MUL R0.x, R1.w, R0;
MAD R0.x, R2, R0.w, R0;
ADD R0.x, -R0, c[3].y;
MAD R0.w, R0.z, c[2].y, R0.x;
ADD R0.y, -R0, c[3].x;
MAD R0.z, R0, c[2].x, R0.y;
TEX R0.xyz, R0.zwzw, texture[1], 2D;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, c[6];
TEX R0.w, R0.w, texture[3], 2D;
MUL R0.xyz, R0, c[1];
MUL R0.w, R1.y, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[9].z;
MOV result.color.w, c[8].x;
END
# 77 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 97 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c8, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c9, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c10, 0.41999999, 2.00000000, -1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.x, c5.w
mad r0.x, r0, c8, c8.y
mul r0.y, r0.x, c8.z
mov r0.x, c5.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c9, c9.y
frc r0.x, r0
mad r1.x, r0, c9.z, c9.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c5.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c5.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c5.x
add r0.w, -r0.z, c5.y
mov r0.x, c4
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c8.w
mov r0.y, c4
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c7.x, r0
mov r0.y, c3.w
dp3_pp r0.x, v1, v1
mad_pp r1.w, r0, c7.x, -r0.z
mad r0.y, r0, c8.x, c8
mul r0.z, r0.y, c8
mov r0.y, c3.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c9.x, c9.y
frc r0.w, r0
add r0.z, r0, c10.x
rcp r0.z, r0.z
mad r1.x, r0.w, c9.z, c9.w
mul r3.xy, r0, r0.z
sincos r0.xy, r1.x
mad r0.zw, r1.w, r3.xyxy, v0
add r0.w, r0, -c3.y
mul r1.x, r0.w, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c3.x
mad r1.y, r0.z, r0, r0.w
mad r0.w, r0.z, r0.x, -r1.x
add r1.x, -r1.y, c3.y
mov r0.z, c2.y
mad r1.y, c0, r0.z, r1.x
add r0.w, -r0, c3.x
mov r0.z, c2.x
mad r1.x, c0.y, r0.z, r0.w
texld r2.yw, r1, s2
mad_pp r1.xy, r2.wyzw, c10.y, c10.z
mul_pp r0.zw, r1.xyxy, r1.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c8.y
rsq_pp r0.z, r0.z
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.z
mul_pp r2.xyz, r0.w, v2
mad r0.zw, r1.w, r3.xyxy, v0.xyxy
dp3_pp r1.x, r1, r2
add r1.y, r0.w, -c3
max_pp r0.w, r1.x, c10
mul r1.x, r0.y, r1.y
mul r1.y, r0.x, r1
add r0.z, r0, -c3.x
mad r0.y, r0, r0.z, r1
mad r0.z, r0.x, r0, -r1.x
mov r0.x, c2.y
add r0.y, -r0, c3
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c3.x
mov r0.x, c2
mad r0.x, c0.y, r0, r0.z
texld r1.xyz, r0, s1
dp3 r0.x, v3, v3
mul r1.xyz, r1, c6
texld r0.x, r0.x, s3
mul_pp r1.xyz, r1, c1
mul_pp r0.x, r0.w, r0
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c10.y
mov_pp oC0.w, c10
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
ConstBuffer "$Globals" 240 // 196 used size, 12 vars
Vector 16 [_LightColor0] 4
Vector 112 [_PanMT] 4
Vector 128 [_RotMT] 4
Vector 144 [_PanPM] 4
Vector 160 [_RotPM] 4
Vector 176 [_Color] 4
Float 192 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 3
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
// 52 instructions, 3 temp regs, 0 temp arrays:
// ALU 44 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedikdeihcpihlchefpjoaknjbecoicjkdgabaaaaaajeaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcimahaaaaeaaaaaaaodabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaaabeaaaaa
gballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaakaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaa
abaaaaaafgiecaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaahjcaabaaaaaaaaaaa
agaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaakaaaaaa
dcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkiacaaaabaaaaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaa
ajaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadiaaaaai
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaadpdcaaaaal
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaakaabaia
ebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaa
ckbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahpcaabaaa
abaaaaaalgalbaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaajpcaabaaa
aaaaaaaaegaobaaaaaaaaaaabgibcaiaebaaaaaaaaaaaaaaaiaaaaaadcaaaaak
bcaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejea
dcaaaaalbcaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaabkiacaaaabaaaaaa
aaaaaaaaakaabaaaabaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaa
akaabaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaa
abaaaaaadcaaaaakkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaa
agaibaiaebaaaaaaabaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaaaaaaaaaa
agaabaaaacaaaaaafgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaaagacbaia
ebaaaaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaadcaaaaalmcaabaaaabaaaaaa
fgifcaaaaaaaaaaaahaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaaaaaaaaaa
aaaaaaajdcaabaaaaaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaaaaaaaaaa
aiaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaafgifcaaa
abaaaaaaaaaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaangafbaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
igaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegbcbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
efaaaaajpcaabaaaacaaaaaafgafbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaacaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"3.0-!!ARBfp1.0
# 71 ALU, 3 TEX
PARAM c[10] = { program.local[0..7],
		{ 0, 0.0055555557, 1, 3.1415927 },
		{ 0.5, 0.41999999, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[5].w;
MAD R0.x, R0, c[8].y, c[8].z;
MOV R1.z, c[0].y;
MUL R0.x, R0, c[8].w;
MAD R0.x, R1.z, c[5].z, R0;
COS R0.y, R0.x;
SIN R0.z, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[5].y;
MUL R0.w, R0.x, R0.z;
MUL R1.x, R0.y, R0;
ADD R0.x, fragment.texcoord[0].z, -c[5];
MAD R0.z, R0.x, R0, R1.x;
MAD R0.x, R0, R0.y, -R0.w;
ADD R0.y, -R0.z, c[5];
ADD R0.x, -R0, c[5];
MAD R0.y, R1.z, c[4], R0;
MAD R0.x, R1.z, c[4], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[7];
MUL R1.x, R0, c[9];
MAD R1.w, R0, c[7].x, -R1.x;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[9].y;
RCP R0.z, R0.z;
MUL R1.xy, R0, R0.z;
MAD R0.xy, R1.w, R1, fragment.texcoord[0].zwzw;
MOV R0.w, c[3];
MAD R0.w, R0, c[8].y, c[8].z;
MUL R0.z, R0.w, c[8].w;
MAD R0.z, R1, c[3], R0;
SIN R2.y, R0.z;
COS R2.x, R0.z;
ADD R0.y, R0, -c[3];
MUL R0.z, R2.x, R0.y;
ADD R0.x, R0, -c[3];
MUL R0.y, R0, R2;
MAD R0.y, R0.x, R2.x, -R0;
MAD R0.z, R0.x, R2.y, R0;
ADD R0.x, -R0.y, c[3];
ADD R0.y, -R0.z, c[3];
MAD R0.x, R1.z, c[2], R0;
MAD R0.y, R1.z, c[2], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R0.z, c[8];
MAD R0.xy, R0.wyzw, c[9].z, -R0.z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R2.z, R0, R0.w;
MAD R0.zw, R1.w, R1.xyxy, fragment.texcoord[0].xyxy;
ADD R1.y, R0.w, -c[3];
ADD R1.x, -R2.z, c[8].z;
RSQ R0.w, R1.x;
MUL R1.x, R2.y, R1.y;
ADD R0.z, R0, -c[3].x;
MUL R1.y, R2.x, R1;
MAD R1.y, R2, R0.z, R1;
MAD R0.z, R2.x, R0, -R1.x;
ADD R1.x, -R1.y, c[3].y;
MAD R1.y, R1.z, c[2], R1.x;
ADD R0.z, -R0, c[3].x;
MAD R1.x, R1.z, c[2], R0.z;
RCP R0.z, R0.w;
DP3 R0.x, R0, fragment.texcoord[2];
TEX R1.xyz, R1, texture[1], 2D;
MUL R1.xyz, R1, c[6];
MUL R1.xyz, R1, c[1];
MAX R0.x, R0, c[8];
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[9].z;
MOV result.color.w, c[8].x;
END
# 71 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
"ps_3_0
; 92 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c8, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c9, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c10, 0.41999999, 2.00000000, -1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r0.x, c5.w
mad r0.x, r0, c8, c8.y
mul r0.y, r0.x, c8.z
mov r0.x, c5.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c9, c9.y
frc r0.x, r0
mad r1.x, r0, c9.z, c9.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c5.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c5.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c5.x
add r0.w, -r0.z, c5.y
mov r0.x, c4
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c8.w
mov r0.y, c4
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c7.x, r0
mov r0.y, c3.w
dp3_pp r0.x, v1, v1
mad_pp r1.z, r0.w, c7.x, -r0
mad r0.y, r0, c8.x, c8
mul r0.z, r0.y, c8
mov r0.y, c3.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c9.x, c9.y
frc r0.w, r0
add r0.z, r0, c10.x
rcp r0.z, r0.z
mul r1.xy, r0, r0.z
mad r1.w, r0, c9.z, c9
sincos r0.xy, r1.w
mad r0.zw, r1.z, r1.xyxy, v0
add r0.w, r0, -c3.y
mul r1.w, r0, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c3.x
mad r2.x, r0.z, r0.y, r0.w
mad r0.w, r0.z, r0.x, -r1
add r1.w, -r2.x, c3.y
mov r0.z, c2.y
mad r2.y, c0, r0.z, r1.w
add r0.w, -r0, c3.x
mov r0.z, c2.x
mad r2.x, c0.y, r0.z, r0.w
texld r2.yw, r2, s2
mad_pp r2.xy, r2.wyzw, c10.y, c10.z
mul_pp r0.zw, r2.xyxy, r2.xyxy
add_pp_sat r1.w, r0.z, r0
mad r0.zw, r1.z, r1.xyxy, v0.xyxy
add r1.y, r0.w, -c3
add_pp r1.x, -r1.w, c8.y
rsq_pp r0.w, r1.x
mul r1.x, r0.y, r1.y
rcp_pp r2.z, r0.w
mul r1.y, r0.x, r1
add r0.z, r0, -c3.x
mad r0.y, r0, r0.z, r1
mad r0.z, r0.x, r0, -r1.x
mov r0.x, c2.y
add r0.y, -r0, c3
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c3.x
mov r0.x, c2
mad r0.x, c0.y, r0, r0.z
texld r0.xyz, r0, s1
mul r0.xyz, r0, c6
mul_pp r1.xyz, r0, c1
dp3_pp r0.w, r2, v2
max_pp r0.x, r0.w, c10.w
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c10.y
mov_pp oC0.w, c10
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 176 // 132 used size, 11 vars
Vector 16 [_LightColor0] 4
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_BumpMap] 2D 1
// 47 instructions, 3 temp regs, 0 temp arrays:
// ALU 40 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjhmkeacgjaandkiojogjdjjaflibpojmabaaaaaamiahaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcniagaaaaeaaaaaaalgabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaa
gballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaa
abaaaaaafgiecaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaaaaaaaaaa
agaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaa
dcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaabaaaaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaa
afaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadpdcaaaaal
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaakaabaia
ebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaa
ckbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahpcaabaaa
abaaaaaalgalbaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaajpcaabaaa
aaaaaaaaegaobaaaaaaaaaaabgibcaiaebaaaaaaaaaaaaaaaeaaaaaadcaaaaak
bcaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejea
dcaaaaalbcaabaaaabaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaaabaaaaaa
aaaaaaaaakaabaaaabaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaa
akaabaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaa
abaaaaaadcaaaaakkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaa
agaibaiaebaaaaaaabaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaaaaaaaaaa
agaabaaaacaaaaaafgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaaagacbaia
ebaaaaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaadcaaaaalmcaabaaaabaaaaaa
fgifcaaaaaaaaaaaadaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaaaaaaaaaa
aaaaaaajdcaabaaaaaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaaaaaaaaaa
aeaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaafgifcaaa
abaaaaaaaaaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaangafbaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
igaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
# 83 ALU, 5 TEX
PARAM c[10] = { program.local[0..7],
		{ 0, 0.0055555557, 1, 3.1415927 },
		{ 0.5, 0.41999999, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[5].w;
MAD R0.x, R0, c[8].y, c[8].z;
MOV R0.z, c[0].y;
MUL R0.x, R0, c[8].w;
MAD R0.x, R0.z, c[5].z, R0;
COS R1.x, R0.x;
SIN R0.w, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[5].y;
MUL R0.y, R0.x, R0.w;
ADD R1.y, fragment.texcoord[0].z, -c[5].x;
MAD R0.y, R1, R1.x, -R0;
MUL R0.x, R1, R0;
MAD R0.x, R1.y, R0.w, R0;
ADD R0.x, -R0, c[5].y;
MAD R1.y, R0.z, c[4], R0.x;
ADD R0.y, -R0, c[5].x;
MAD R1.x, R0.z, c[4], R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[1];
MOV R0.y, c[7].x;
MOV R0.x, c[3].w;
TEX R0.w, R1, texture[0], 2D;
MUL R0.y, R0, c[9].x;
MAD R1.z, R0.w, c[7].x, -R0.y;
ADD R0.y, R2.z, c[9];
RCP R0.y, R0.y;
MUL R1.xy, R2, R0.y;
MAD R0.x, R0, c[8].y, c[8].z;
MUL R0.w, R0.x, c[8];
MAD R0.xy, R1.z, R1, fragment.texcoord[0].zwzw;
MAD R1.w, R0.z, c[3].z, R0;
SIN R2.x, R1.w;
MAD R1.xy, R1.z, R1, fragment.texcoord[0];
COS R1.w, R1.w;
ADD R0.w, R0.y, -c[3].y;
MUL R0.y, R1.w, R0.w;
ADD R0.x, R0, -c[3];
MUL R0.w, R0, R2.x;
MAD R0.w, R0.x, R1, -R0;
MAD R0.x, R0, R2, R0.y;
ADD R0.y, -R0.x, c[3];
ADD R0.w, -R0, c[3].x;
MAD R0.x, R0.z, c[2], R0.w;
MAD R0.y, R0.z, c[2], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R2.y, c[8].z;
MAD R2.yz, R0.xwyw, c[9].z, -R2.y;
MUL R0.xy, R2.yzzw, R2.yzzw;
ADD_SAT R0.x, R0, R0.y;
ADD R0.y, -R0.x, c[8].z;
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RCP R2.w, R0.y;
RSQ R0.x, R0.x;
MUL R0.xyw, R0.x, fragment.texcoord[2].xyzz;
DP3 R0.y, R2.yzww, R0.xyww;
ADD R0.w, R1.x, -c[3].x;
ADD R0.x, R1.y, -c[3].y;
MAX R1.y, R0, c[8].x;
MUL R0.y, R2.x, R0.x;
MAD R0.y, R1.w, R0.w, -R0;
MUL R0.x, R1.w, R0;
MAD R0.x, R2, R0.w, R0;
ADD R0.x, -R0, c[3].y;
MAD R0.w, R0.z, c[2].y, R0.x;
ADD R0.y, -R0, c[3].x;
MAD R0.z, R0, c[2].x, R0.y;
TEX R0.xyz, R0.zwzw, texture[1], 2D;
RCP R0.w, fragment.texcoord[3].w;
MAD R1.zw, fragment.texcoord[3].xyxy, R0.w, c[9].x;
MUL R0.xyz, R0, c[6];
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R1.zwzw, texture[3], 2D;
TEX R1.w, R1.x, texture[4], 2D;
SLT R1.x, c[8], fragment.texcoord[3].z;
MUL R0.w, R1.x, R0;
MUL R0.w, R0, R1;
MUL R0.xyz, R0, c[1];
MUL R0.w, R1.y, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[9].z;
MOV result.color.w, c[8].x;
END
# 83 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
SetTexture 4 [_LightTextureB0] 2D
"ps_3_0
; 102 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c8, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c9, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c10, 0.41999999, 2.00000000, -1.00000000, 0.00000000
def c11, 0.00000000, 1.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
mov r0.x, c5.w
mad r0.x, r0, c8, c8.y
mul r0.y, r0.x, c8.z
mov r0.x, c5.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c9, c9.y
frc r0.x, r0
mad r1.x, r0, c9.z, c9.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c5.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c5.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c5.x
add r0.w, -r0.z, c5.y
mov r0.x, c4
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c8.w
mov r0.y, c4
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c7.x, r0
mov r0.y, c3.w
dp3_pp r0.x, v1, v1
mad_pp r1.w, r0, c7.x, -r0.z
mad r0.y, r0, c8.x, c8
mul r0.z, r0.y, c8
mov r0.y, c3.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c9.x, c9.y
frc r0.w, r0
add r0.z, r0, c10.x
rcp r0.z, r0.z
mad r1.x, r0.w, c9.z, c9.w
mul r3.xy, r0, r0.z
sincos r0.xy, r1.x
mad r0.zw, r1.w, r3.xyxy, v0
add r0.w, r0, -c3.y
mul r1.x, r0.w, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c3.x
mad r1.y, r0.z, r0, r0.w
mad r0.w, r0.z, r0.x, -r1.x
add r1.x, -r1.y, c3.y
mov r0.z, c2.y
mad r1.y, c0, r0.z, r1.x
add r0.w, -r0, c3.x
mov r0.z, c2.x
mad r1.x, c0.y, r0.z, r0.w
texld r2.yw, r1, s2
mad_pp r1.xy, r2.wyzw, c10.y, c10.z
mul_pp r0.zw, r1.xyxy, r1.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c8.y
rsq_pp r0.z, r0.z
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
rcp_pp r1.z, r0.z
mul_pp r2.xyz, r0.w, v2
mad r0.zw, r1.w, r3.xyxy, v0.xyxy
dp3_pp r1.x, r1, r2
add r0.w, r0, -c3.y
max_pp r1.w, r1.x, c10
mul r1.x, r0.y, r0.w
mul r0.w, r0.x, r0
add r0.z, r0, -c3.x
mad r0.y, r0, r0.z, r0.w
mad r0.z, r0.x, r0, -r1.x
rcp r0.w, v3.w
mad r2.xy, v3, r0.w, c8.w
mov r0.x, c2.y
add r0.y, -r0, c3
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c3.x
mov r0.x, c2
mad r0.x, c0.y, r0, r0.z
texld r0.xyz, r0, s1
mul r1.xyz, r0, c6
dp3 r0.x, v3, v3
texld r0.w, r2, s3
cmp r0.y, -v3.z, c11.x, c11
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r1.xyz, r1, c1
mul_pp r0.x, r1.w, r0
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c10.y
mov_pp oC0.w, c10
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 240 // 196 used size, 12 vars
Vector 16 [_LightColor0] 4
Vector 112 [_PanMT] 4
Vector 128 [_RotMT] 4
Vector 144 [_PanPM] 4
Vector 160 [_RotPM] 4
Vector 176 [_Color] 4
Float 192 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 4
SetTexture 1 [_MainTex] 2D 2
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
// 59 instructions, 3 temp regs, 0 temp arrays:
// ALU 49 float, 0 int, 1 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfhaphokpmeppplidfmgfoflciaffkaoeabaaaaaaiiajaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciaaiaaaaeaaaaaaacaacaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
dcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaaabeaaaaagballgdl
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
nlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaakaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaa
abaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaaabaaaaaa
fgiecaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaahjcaabaaaaaaaaaaaagaabaaa
aaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaal
ccaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkiacaaaabaaaaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaadiaaaaaibcaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaadpdcaaaaalbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaakaabaiaebaaaaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaackbabaaa
acaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahpcaabaaaabaaaaaa
lgalbaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaajpcaabaaaaaaaaaaa
egaobaaaaaaaaaaabgibcaiaebaaaaaaaaaaaaaaaiaaaaaadcaaaaakbcaabaaa
abaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaagballgdlabeaaaaaaaaaiadp
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeadcaaaaal
bcaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaabkiacaaaabaaaaaaaaaaaaaa
akaabaaaabaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaa
dcaaaaakkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaaagaibaia
ebaaaaaaabaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaaaaaaaaaaagaabaaa
acaaaaaafgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaaagacbaiaebaaaaaa
aaaaaaaafgifcaaaaaaaaaaaaiaaaaaadcaaaaalmcaabaaaabaaaaaafgifcaaa
aaaaaaaaahaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaa
dcaaaaaldcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaafgifcaaaabaaaaaa
aaaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaangafbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaa
hgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aoaaaaahgcaabaaaaaaaaaaaagbbbaaaaeaaaaaapgbpbaaaaeaaaaaaaaaaaaak
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaaaaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaa
aeaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaakgakbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaapaaaaahbcaabaaa
aaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 79 ALU, 5 TEX
PARAM c[10] = { program.local[0..7],
		{ 0, 0.0055555557, 1, 3.1415927 },
		{ 0.5, 0.41999999, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[5].w;
MAD R0.x, R0, c[8].y, c[8].z;
MOV R1.w, c[0].y;
MUL R0.x, R0, c[8].w;
MAD R0.x, R1.w, c[5].z, R0;
COS R0.y, R0.x;
SIN R0.z, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[5].y;
MUL R0.w, R0.x, R0.z;
MUL R1.x, R0.y, R0;
ADD R0.x, fragment.texcoord[0].z, -c[5];
MAD R0.z, R0.x, R0, R1.x;
MAD R0.x, R0, R0.y, -R0.w;
ADD R0.y, -R0.z, c[5];
ADD R0.x, -R0, c[5];
MAD R0.y, R1.w, c[4], R0;
MAD R0.x, R1.w, c[4], R0;
TEX R0.w, R0, texture[0], 2D;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R1.xyz, R0.y, fragment.texcoord[1];
MOV R0.x, c[7];
MUL R0.x, R0, c[9];
MAD R0.z, R0.w, c[7].x, -R0.x;
ADD R0.x, R1.z, c[9].y;
MOV R0.y, c[3].w;
MAD R0.w, R0.y, c[8].y, c[8].z;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0.x;
MAD R1.xy, R0.z, R0, fragment.texcoord[0].zwzw;
MUL R0.w, R0, c[8];
MAD R0.w, R1, c[3].z, R0;
SIN R2.z, R0.w;
COS R0.w, R0.w;
ADD R1.y, R1, -c[3];
MUL R1.z, R0.w, R1.y;
ADD R1.x, R1, -c[3];
MUL R1.y, R1, R2.z;
MAD R1.y, R1.x, R0.w, -R1;
MAD R1.z, R1.x, R2, R1;
ADD R1.x, -R1.y, c[3];
ADD R1.y, -R1.z, c[3];
MAD R1.x, R1.w, c[2], R1;
MAD R1.y, R1.w, c[2], R1;
TEX R2.yw, R1, texture[2], 2D;
MOV R1.z, c[8];
MAD R1.xy, R2.wyzw, c[9].z, -R1.z;
MUL R2.xy, R1, R1;
ADD_SAT R1.z, R2.x, R2.y;
DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.w, R2.x;
MAD R2.xy, R0.z, R0, fragment.texcoord[0];
ADD R1.z, -R1, c[8];
RSQ R1.z, R1.z;
MUL R0.xyz, R2.w, fragment.texcoord[2];
RCP R1.z, R1.z;
DP3 R1.x, R1, R0;
ADD R2.y, R2, -c[3];
MUL R0.y, R2.z, R2;
MUL R0.z, R0.w, R2.y;
ADD R0.x, R2, -c[3];
MAD R0.z, R2, R0.x, R0;
MAD R0.x, R0.w, R0, -R0.y;
ADD R0.y, -R0.z, c[3];
ADD R0.x, -R0, c[3];
MAD R0.y, R1.w, c[2], R0;
MAD R0.x, R1.w, c[2], R0;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, c[6];
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
MUL R2.xyz, R0, c[1];
MAX R1.x, R1, c[8];
TEX R0.w, fragment.texcoord[3], texture[4], CUBE;
TEX R1.w, R1.y, texture[3], 2D;
MUL R0.w, R1, R0;
MUL R0.x, R1, R0.w;
MUL R0.xyz, R0.x, R2;
MUL result.color.xyz, R0, c[9].z;
MOV result.color.w, c[8].x;
END
# 79 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 98 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c8, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c9, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c10, 0.41999999, 2.00000000, -1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.x, c5.w
mad r0.x, r0, c8, c8.y
mov r0.y, c5.z
mul r0.x, r0, c8.z
mad r0.x, c0.y, r0.y, r0
mad r0.x, r0, c9, c9.y
frc r0.x, r0
mad r1.x, r0, c9.z, c9.w
sincos r0.xy, r1.x
add r0.w, v0, -c5.y
mul r0.z, r0.w, r0.x
mul r0.w, r0, r0.y
add r1.x, v0.z, -c5
mad r0.x, r1, r0, -r0.w
mad r0.y, r1.x, r0, r0.z
mov r0.z, c4.x
add r0.x, -r0, c5
mad r0.x, c0.y, r0.z, r0
mov_pp r0.z, c8.w
mov r0.w, c4.y
add r0.y, -r0, c5
mad r0.y, c0, r0.w, r0
texld r0.w, r0, s0
mul_pp r0.z, c7.x, r0
mov r0.x, c3.w
mad r0.x, r0, c8, c8.y
mad_pp r1.z, r0.w, c7.x, -r0
dp3_pp r0.y, v1, v1
rsq_pp r0.z, r0.y
mul r0.x, r0, c8.z
mov r0.y, c3.z
mad r0.w, c0.y, r0.y, r0.x
mul_pp r0.xyz, r0.z, v1
add r1.x, r0.z, c10
mad r0.w, r0, c9.x, c9.y
frc r0.z, r0.w
rcp r0.w, r1.x
mul r1.xy, r0, r0.w
mad r1.w, r0.z, c9.z, c9
sincos r0.xy, r1.w
mad r0.zw, r1.z, r1.xyxy, v0
add r0.w, r0, -c3.y
mul r1.w, r0, r0.y
mul r0.w, r0, r0.x
add r2.x, r0.z, -c3
mad r0.z, r2.x, r0.y, r0.w
mad r0.w, r2.x, r0.x, -r1
add r0.z, -r0, c3.y
mov r1.w, c2.y
mad r2.y, c0, r1.w, r0.z
add r0.z, -r0.w, c3.x
mov r0.w, c2.x
mad r2.x, c0.y, r0.w, r0.z
texld r2.yw, r2, s2
mad_pp r2.xy, r2.wyzw, c10.y, c10.z
mul_pp r0.zw, r2.xyxy, r2.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c8.y
rsq_pp r0.w, r0.z
dp3_pp r0.z, v2, v2
rsq_pp r1.w, r0.z
rcp_pp r2.z, r0.w
mad r0.zw, r1.z, r1.xyxy, v0.xyxy
mul_pp r1.xyz, r1.w, v2
add r1.w, r0, -c3.y
dp3_pp r0.w, r2, r1
mul r1.y, r0, r1.w
mul r1.x, r0, r1.w
add r0.z, r0, -c3.x
mad r0.y, r0, r0.z, r1.x
mad r0.z, r0.x, r0, -r1.y
add r0.x, -r0.y, c3.y
max_pp r1.w, r0, c10
mov r0.y, c2
mad r0.y, c0, r0, r0.x
add r0.x, -r0.z, c3
mov r0.z, c2.x
mad r0.x, c0.y, r0.z, r0
texld r0.xyz, r0, s1
mul r1.xyz, r0, c6
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
texld r0.w, v3, s4
mul r0.w, r0.x, r0
mul_pp r0.xyz, r1, c1
mul_pp r0.w, r1, r0
mul_pp r0.xyz, r0.w, r0
mul_pp oC0.xyz, r0, c10.y
mov_pp oC0.w, c10
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 240 // 196 used size, 12 vars
Vector 16 [_LightColor0] 4
Vector 112 [_PanMT] 4
Vector 128 [_RotMT] 4
Vector 144 [_PanPM] 4
Vector 160 [_RotPM] 4
Vector 176 [_Color] 4
Float 192 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 4
SetTexture 1 [_MainTex] 2D 2
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
// 54 instructions, 4 temp regs, 0 temp arrays:
// ALU 45 float, 0 int, 0 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefieceddhfbccdgdomjobhkphelpcbjbnaebedhabaaaaaapaaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiahaaaaeaaaaaaapkabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
dcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaaabeaaaaagballgdl
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
nlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaakaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaa
abaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaaabaaaaaa
fgiecaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaahjcaabaaaaaaaaaaaagaabaaa
aaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaal
ccaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkiacaaaabaaaaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaadiaaaaaibcaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaadpdcaaaaalbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaakaabaiaebaaaaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaackbabaaa
acaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahpcaabaaaabaaaaaa
lgalbaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaajpcaabaaaaaaaaaaa
egaobaaaaaaaaaaabgibcaiaebaaaaaaaaaaaaaaaiaaaaaadcaaaaakbcaabaaa
abaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaagballgdlabeaaaaaaaaaiadp
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeadcaaaaal
bcaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaabkiacaaaabaaaaaaaaaaaaaa
akaabaaaabaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaa
dcaaaaakkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaaagaibaia
ebaaaaaaabaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaaaaaaaaaaagaabaaa
acaaaaaafgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaaagacbaiaebaaaaaa
aaaaaaaafgifcaaaaaaaaaaaaiaaaaaadcaaaaalmcaabaaaabaaaaaafgifcaaa
aaaaaaaaahaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaa
dcaaaaaldcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaafgifcaaaabaaaaaa
aaaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaangafbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaa
hgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaaj
pcaabaaaacaaaaaafgafbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegbcbaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaa
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaah
hccabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 73 ALU, 4 TEX
PARAM c[10] = { program.local[0..7],
		{ 0, 0.0055555557, 1, 3.1415927 },
		{ 0.5, 0.41999999, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[5].w;
MAD R0.x, R0, c[8].y, c[8].z;
MOV R1.z, c[0].y;
MUL R0.x, R0, c[8].w;
MAD R0.x, R1.z, c[5].z, R0;
COS R0.y, R0.x;
SIN R0.z, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[5].y;
MUL R0.w, R0.x, R0.z;
MUL R1.x, R0.y, R0;
ADD R0.x, fragment.texcoord[0].z, -c[5];
MAD R0.z, R0.x, R0, R1.x;
MAD R0.x, R0, R0.y, -R0.w;
ADD R0.y, -R0.z, c[5];
ADD R0.x, -R0, c[5];
MAD R0.y, R1.z, c[4], R0;
MAD R0.x, R1.z, c[4], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[7];
MUL R1.x, R0, c[9];
MAD R2.y, R0.w, c[7].x, -R1.x;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[9].y;
RCP R0.z, R0.z;
MUL R1.xy, R0, R0.z;
MAD R0.xy, R2.y, R1, fragment.texcoord[0].zwzw;
MAD R1.xy, R2.y, R1, fragment.texcoord[0];
MOV R0.w, c[3];
MAD R0.w, R0, c[8].y, c[8].z;
MUL R0.z, R0.w, c[8].w;
MAD R0.z, R1, c[3], R0;
SIN R2.x, R0.z;
COS R1.w, R0.z;
ADD R0.y, R0, -c[3];
MUL R0.z, R1.w, R0.y;
ADD R0.x, R0, -c[3];
MUL R0.y, R0, R2.x;
MAD R0.z, R0.x, R2.x, R0;
MAD R0.y, R0.x, R1.w, -R0;
ADD R0.x, -R0.y, c[3];
ADD R0.y, -R0.z, c[3];
MAD R0.x, R1.z, c[2], R0;
MAD R0.y, R1.z, c[2], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R0.z, c[8];
MAD R0.xy, R0.wyzw, c[9].z, -R0.z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[8];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.w, R0, fragment.texcoord[2];
ADD R1.y, R1, -c[3];
ADD R0.x, R1, -c[3];
MAX R1.x, R0.w, c[8];
MUL R0.z, R1.w, R1.y;
MAD R0.z, R2.x, R0.x, R0;
MUL R0.y, R2.x, R1;
MAD R0.x, R1.w, R0, -R0.y;
ADD R0.y, -R0.z, c[3];
ADD R0.x, -R0, c[3];
MAD R0.y, R1.z, c[2], R0;
MAD R0.x, R1.z, c[2], R0;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, c[6];
MUL R2.xyz, R0, c[1];
TEX R0.w, fragment.texcoord[3], texture[3], 2D;
MUL R0.x, R1, R0.w;
MUL R0.xyz, R0.x, R2;
MUL result.color.xyz, R0, c[9].z;
MOV result.color.w, c[8].x;
END
# 73 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_PanMT]
Vector 3 [_RotMT]
Vector 4 [_PanPM]
Vector 5 [_RotPM]
Vector 6 [_Color]
Float 7 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 93 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c8, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c9, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c10, 0.41999999, 2.00000000, -1.00000000, 0.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
mov r0.x, c5.w
mad r0.x, r0, c8, c8.y
mul r0.y, r0.x, c8.z
mov r0.x, c5.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c9, c9.y
frc r0.x, r0
mad r1.x, r0, c9.z, c9.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c5.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c5.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c5.x
add r0.w, -r0.z, c5.y
mov r0.x, c4
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c8.w
mov r0.y, c4
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c7.x, r0
mov r0.y, c3.w
dp3_pp r0.x, v1, v1
mad_pp r1.z, r0.w, c7.x, -r0
mad r0.y, r0, c8.x, c8
mul r0.z, r0.y, c8
mov r0.y, c3.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c9.x, c9.y
frc r0.w, r0
add r0.z, r0, c10.x
rcp r0.z, r0.z
mul r1.xy, r0, r0.z
mad r1.w, r0, c9.z, c9
sincos r0.xy, r1.w
mad r0.zw, r1.z, r1.xyxy, v0
add r0.w, r0, -c3.y
mul r1.w, r0, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c3.x
mad r2.x, r0.z, r0.y, r0.w
mad r0.w, r0.z, r0.x, -r1
add r1.w, -r2.x, c3.y
mov r0.z, c2.y
mad r2.y, c0, r0.z, r1.w
add r0.w, -r0, c3.x
mov r0.z, c2.x
mad r2.x, c0.y, r0.z, r0.w
texld r2.yw, r2, s2
mad_pp r2.xy, r2.wyzw, c10.y, c10.z
mul_pp r0.zw, r2.xyxy, r2.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c8.y
rsq_pp r1.w, r0.z
mad r0.zw, r1.z, r1.xyxy, v0.xyxy
add r1.x, r0.w, -c3.y
mul r1.y, r0, r1.x
rcp_pp r2.z, r1.w
dp3_pp r0.w, r2, v2
mul r1.x, r0, r1
add r0.z, r0, -c3.x
mad r0.y, r0, r0.z, r1.x
mad r0.z, r0.x, r0, -r1.y
max_pp r1.x, r0.w, c10.w
mov r0.x, c2.y
add r0.y, -r0, c3
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c3.x
mov r0.x, c2
mad r0.x, c0.y, r0, r0.z
texld r0.xyz, r0, s1
mul r0.xyz, r0, c6
mul_pp r2.xyz, r0, c1
texld r0.w, v3, s3
mul_pp r0.x, r1, r0.w
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c10.y
mov_pp oC0.w, c10
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 240 // 196 used size, 12 vars
Vector 16 [_LightColor0] 4
Vector 112 [_PanMT] 4
Vector 128 [_RotMT] 4
Vector 144 [_PanPM] 4
Vector 160 [_RotPM] 4
Vector 176 [_Color] 4
Float 192 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 3
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
// 48 instructions, 3 temp regs, 0 temp arrays:
// ALU 40 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecednjlljmhjcjmcpjjlaijhpoinjmipfnapabaaaaaacmaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcceahaaaaeaaaaaaamjabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaaabeaaaaa
gballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaakaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaa
abaaaaaafgiecaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaahjcaabaaaaaaaaaaa
agaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaakaaaaaa
dcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkiacaaaabaaaaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaa
ajaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadiaaaaai
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaadpdcaaaaal
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaakaabaia
ebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaa
ckbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahpcaabaaa
abaaaaaalgalbaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaajpcaabaaa
aaaaaaaaegaobaaaaaaaaaaabgibcaiaebaaaaaaaaaaaaaaaiaaaaaadcaaaaak
bcaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejea
dcaaaaalbcaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaabkiacaaaabaaaaaa
aaaaaaaaakaabaaaabaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaa
akaabaaaabaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaa
abaaaaaadcaaaaakkcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaa
agaibaiaebaaaaaaabaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaaaaaaaaaa
agaabaaaacaaaaaafgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaaagacbaia
ebaaaaaaaaaaaaaafgifcaaaaaaaaaaaaiaaaaaadcaaaaalmcaabaaaabaaaaaa
fgifcaaaaaaaaaaaahaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaaaaaaaaaa
aaaaaaajdcaabaaaaaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaaaaaaaaaa
aiaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaafgifcaaa
abaaaaaaaaaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaangafbaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
igaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }
		Fog {Mode Off}
Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 30 to 30
//   d3d9 - ALU: 31 to 31
//   d3d11 - ALU: 28 to 28, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 14 [unity_Scale]
Vector 15 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 30 ALU
PARAM c[16] = { { 1 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[14].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2].xyz, R0, c[14].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3].xyz, R0, c[14].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[4].xyz, R0, c[14].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 30 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_BumpMap_ST]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c15.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o2.y, r0, r1
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3.xyz, r0, c13.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4.xyz, r0, c13.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5.xyz, r0, c13.w
mad o1.xy, v3, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 160 // 160 used size, 10 vars
Vector 144 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 76 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 38 instructions, 3 temp regs, 0 temp arrays:
// ALU 28 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedipmkjiehjbmchpepgdmkfdbhckdfcagdabaaaaaaoiagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcdeafaaaaeaaaabaaenabaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaajhcaabaaaaaaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
aaaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaagbcaabaaaaaaaaaaaakiacaaa
acaaaaaaamaaaaaadgaaaaagccaabaaaaaaaaaaaakiacaaaacaaaaaaanaaaaaa
dgaaaaagecaabaaaaaaaaaaaakiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaacaaaaaa
egbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadgaaaaagbcaabaaaaaaaaaaabkiacaaaacaaaaaa
amaaaaaadgaaaaagccaabaaaaaaaaaaabkiacaaaacaaaaaaanaaaaaadgaaaaag
ecaabaaaaaaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaihccabaaaaeaaaaaaegacbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadgaaaaagbcaabaaaaaaaaaaackiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaaaaaaaaackiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
aaaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
aaaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  vec3 v_6;
  v_6.x = _Object2World[0].x;
  v_6.y = _Object2World[1].x;
  v_6.z = _Object2World[2].x;
  vec3 v_7;
  v_7.x = _Object2World[0].y;
  v_7.y = _Object2World[1].y;
  v_7.z = _Object2World[2].y;
  vec3 v_8;
  v_8.x = _Object2World[0].z;
  v_8.y = _Object2World[1].z;
  v_8.z = _Object2World[2].z;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_5 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((tmpvar_5 * v_6) * unity_Scale.w);
  xlv_TEXCOORD3 = ((tmpvar_5 * v_7) * unity_Scale.w);
  xlv_TEXCOORD4 = ((tmpvar_5 * v_8) * unity_Scale.w);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 worldN_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_3 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0 + (tmpvar_9 * (v_8.xy / v_8.z)));
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_12.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 tmpvar_13;
  tmpvar_13 = ((texture2D (_BumpMap, tmpvar_12).xyz * 2.0) - 1.0);
  highp float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD2, tmpvar_13);
  worldN_2.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD3, tmpvar_13);
  worldN_2.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, tmpvar_13);
  worldN_2.z = tmpvar_16;
  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_3 = tmpvar_1.xyz;
  tmpvar_4 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_5;
  tmpvar_5[0].x = tmpvar_3.x;
  tmpvar_5[0].y = tmpvar_4.x;
  tmpvar_5[0].z = tmpvar_2.x;
  tmpvar_5[1].x = tmpvar_3.y;
  tmpvar_5[1].y = tmpvar_4.y;
  tmpvar_5[1].z = tmpvar_2.y;
  tmpvar_5[2].x = tmpvar_3.z;
  tmpvar_5[2].y = tmpvar_4.z;
  tmpvar_5[2].z = tmpvar_2.z;
  vec3 v_6;
  v_6.x = _Object2World[0].x;
  v_6.y = _Object2World[1].x;
  v_6.z = _Object2World[2].x;
  vec3 v_7;
  v_7.x = _Object2World[0].y;
  v_7.y = _Object2World[1].y;
  v_7.z = _Object2World[2].y;
  vec3 v_8;
  v_8.x = _Object2World[0].z;
  v_8.y = _Object2World[1].z;
  v_8.z = _Object2World[2].z;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_5 * (((_World2Object * tmpvar_9).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = ((tmpvar_5 * v_6) * unity_Scale.w);
  xlv_TEXCOORD3 = ((tmpvar_5 * v_7) * unity_Scale.w);
  xlv_TEXCOORD4 = ((tmpvar_5 * v_8) * unity_Scale.w);
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp float _Parallax;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 worldN_2;
  mediump float h_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = ((_RotPM.x - (((xlv_TEXCOORD0.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_4.y = ((_RotPM.y - (((xlv_TEXCOORD0.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_ParallaxMap, tmpvar_4).w;
  h_3 = tmpvar_5;
  mediump float height_6;
  height_6 = _Parallax;
  mediump vec3 viewDir_7;
  viewDir_7 = xlv_TEXCOORD1;
  highp vec3 v_8;
  mediump float tmpvar_9;
  tmpvar_9 = ((h_3 * height_6) - (height_6 / 2.0));
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(viewDir_7);
  v_8 = tmpvar_10;
  v_8.z = (v_8.z + 0.42);
  highp vec2 tmpvar_11;
  tmpvar_11 = (xlv_TEXCOORD0 + (tmpvar_9 * (v_8.xy / v_8.z)));
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_RotMT.x - (((tmpvar_11.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_11.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_12.y = ((_RotMT.y - (((tmpvar_11.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_11.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_13;
  normal_13.xy = ((texture2D (_BumpMap, tmpvar_12).wy * 2.0) - 1.0);
  normal_13.z = sqrt((1.0 - clamp (dot (normal_13.xy, normal_13.xy), 0.0, 1.0)));
  highp float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD2, normal_13);
  worldN_2.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD3, normal_13);
  worldN_2.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (xlv_TEXCOORD4, normal_13);
  worldN_2.z = tmpvar_16;
  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec3 viewDir;
    highp vec3 TtoW0;
    highp vec3 TtoW1;
    highp vec3 TtoW2;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 431
uniform highp vec4 _BumpMap_ST;
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 432
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 435
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 439
    o.TtoW0 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 0).xyz) * unity_Scale.w);
    o.TtoW1 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 1).xyz) * unity_Scale.w);
    o.TtoW2 = ((rotation * xll_matrixindex_mf3x3_i (mat3( _Object2World), 2).xyz) * unity_Scale.w);
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    #line 443
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec3(xl_retval.TtoW0);
    xlv_TEXCOORD3 = vec3(xl_retval.TtoW1);
    xlv_TEXCOORD4 = vec3(xl_retval.TtoW2);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec2 pack0;
    highp vec3 viewDir;
    highp vec3 TtoW0;
    highp vec3 TtoW1;
    highp vec3 TtoW2;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 431
uniform highp vec4 _BumpMap_ST;
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 445
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 447
    Input surfIN;
    surfIN.uv_BumpMap = IN.pack0.xy;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 451
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 455
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp vec3 worldN;
    worldN.x = dot( IN.TtoW0, o.Normal);
    #line 459
    worldN.y = dot( IN.TtoW1, o.Normal);
    worldN.z = dot( IN.TtoW2, o.Normal);
    o.Normal = worldN;
    lowp vec4 res;
    #line 463
    res.xyz = ((o.Normal * 0.5) + 0.5);
    res.w = o.Specular;
    return res;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec2(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.TtoW0 = vec3(xlv_TEXCOORD2);
    xlt_IN.TtoW1 = vec3(xlv_TEXCOORD3);
    xlt_IN.TtoW2 = vec3(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 57 to 57, TEX: 2 to 2
//   d3d9 - ALU: 77 to 77, TEX: 2 to 2
//   d3d11 - ALU: 38 to 38, TEX: 2 to 2, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Float 5 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_BumpMap] 2D
"3.0-!!ARBfp1.0
# 57 ALU, 2 TEX
PARAM c[8] = { program.local[0..5],
		{ 0, 0.0055555557, 1, 3.1415927 },
		{ 0.5, 0.41999999, 2 } };
TEMP R0;
TEMP R1;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[6].y, c[6].z;
MOV R1.x, c[0].y;
MUL R0.x, R0, c[6].w;
MAD R0.y, R1.x, c[4].z, R0.x;
COS R0.x, R0.y;
SIN R0.z, R0.y;
ADD R0.y, fragment.texcoord[0], -c[4];
MUL R0.w, R0.y, R0.z;
MUL R1.y, R0.x, R0;
ADD R0.y, fragment.texcoord[0].x, -c[4].x;
MAD R0.x, R0.y, R0, -R0.w;
MAD R0.z, R0.y, R0, R1.y;
ADD R0.y, -R0.z, c[4];
ADD R0.x, -R0, c[4];
MAD R0.y, R1.x, c[3], R0;
MAD R0.x, R1, c[3], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[5];
MUL R1.y, R0.x, c[7].x;
MAD R0.w, R0, c[5].x, -R1.y;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[7].y;
RCP R0.z, R0.z;
MUL R0.xy, R0, R0.z;
MAD R0.xy, R0.w, R0, fragment.texcoord[0];
MOV R1.y, c[2].w;
MAD R1.y, R1, c[6], c[6].z;
MUL R0.z, R1.y, c[6].w;
MAD R0.z, R1.x, c[2], R0;
ADD R1.y, R0, -c[2];
SIN R0.y, R0.z;
COS R0.w, R0.z;
MUL R0.z, R0.w, R1.y;
MUL R1.y, R1, R0;
ADD R0.x, R0, -c[2];
MAD R0.y, R0.x, R0, R0.z;
MAD R0.w, R0.x, R0, -R1.y;
ADD R0.x, -R0.w, c[2];
ADD R0.y, -R0, c[2];
MAD R0.x, R1, c[1], R0;
MAD R0.y, R1.x, c[1], R0;
TEX R0.yw, R0, texture[1], 2D;
MOV R0.z, c[6];
MAD R0.xy, R0.wyzw, c[7].z, -R0.z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[6];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R1.z, fragment.texcoord[4], R0;
DP3 R1.x, R0, fragment.texcoord[2];
DP3 R1.y, R0, fragment.texcoord[3];
MAD result.color.xyz, R1, c[7].x, c[7].x;
MOV result.color.w, c[6].x;
END
# 57 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Float 5 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_BumpMap] 2D
"ps_3_0
; 77 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c6, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c7, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c8, 0.41999999, 2.00000000, -1.00000000, 0.00000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.x, c4.w
mad r0.x, r0, c6, c6.y
mul r0.y, r0.x, c6.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c7, c7.y
frc r0.x, r0
mad r1.x, r0, c7.z, c7.w
sincos r0.xy, r1.x
add r0.z, v0.y, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0.x, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c6.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c5.x, r0
mov r0.y, c2.w
dp3_pp r0.x, v1, v1
mad_pp r1.z, r0.w, c5.x, -r0
mad r0.y, r0, c6.x, c6
mul r0.z, r0.y, c6
mov r0.y, c2.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c7.x, c7.y
frc r0.w, r0
add r0.z, r0, c8.x
rcp r0.z, r0.z
mul r1.xy, r0, r0.z
mad r1.w, r0, c7.z, c7
sincos r0.xy, r1.w
mad r0.zw, r1.z, r1.xyxy, v0.xyxy
add r0.w, r0, -c2.y
mul r1.x, r0.w, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c2.x
mad r0.y, r0.z, r0, r0.w
mad r0.z, r0, r0.x, -r1.x
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r0.yw, r0, s1
mad_pp r0.xy, r0.wyzw, c8.y, c8.z
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c6.y
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3 r1.z, v4, r0
dp3 r1.x, r0, v2
dp3 r1.y, r0, v3
mad_pp oC0.xyz, r1, c6.w, c6.w
mov_pp oC0.w, c8
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 160 // 132 used size, 10 vars
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Float 128 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 1
SetTexture 1 [_BumpMap] 2D 0
// 44 instructions, 3 temp regs, 0 temp arrays:
// ALU 38 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlghbpadefhjfhpgppanajgjnfmkiannnabaaaaaalaahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaagaaaa
eaaaaaaakeabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaa
aaaaaaaaagaaaaaaabeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaa
ckiacaaaaaaaaaaaagaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaa
enaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaaj
gcaabaaaaaaaaaaafgbebaaaabaaaaaafgiecaiaebaaaaaaaaaaaaaaagaaaaaa
diaaaaahjcaabaaaaaaaaaaaagaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaa
egiacaaaaaaaaaaaagaaaaaadcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaa
afaaaaaabkiacaaaabaaaaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaa
abaaaaaaakiacaaaaaaaaaaaafaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaaadpdcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahmcaabaaaaaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaa
dcaaaaajccaabaaaaaaaaaaackbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaa
dnaknhdoaoaaaaahgcaabaaaaaaaaaaapgaobaaaaaaaaaaafgafbaaaaaaaaaaa
dcaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaabgbfbaaa
abaaaaaaaaaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaabgifcaiaebaaaaaa
aaaaaaaaaeaaaaaadcaaaaakecaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaa
abeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaanlapejeadcaaaaalecaabaaaaaaaaaaackiacaaaaaaaaaaa
aeaaaaaabkiacaaaabaaaaaaaaaaaaaackaabaaaaaaaaaaaenaaaaahbcaabaaa
abaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaa
agaebaaaaaaaaaaaagaabaaaabaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaa
dcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaaabaaaaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaakiacaaaaaaaaaaaaeaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaa
aaaaaaaaadaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
dcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
baaaaaahecaabaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaadcaaaaap
hccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off
Program "vp" {
// Vertex combos: 6
//   opengl - ALU: 25 to 42
//   d3d9 - ALU: 26 to 43
//   d3d11 - ALU: 21 to 35, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 42 ALU
PARAM c[25] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.x, R1, c[18];
DP4 R3.y, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.w, R0.x, R0.x, -R0.y;
MUL R3.xyz, R0.w, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
ADD result.texcoord[3].xyz, R2, R3;
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 42 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c25, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.x
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r2.xyz, r2, r3
mul r3.xyz, r0.w, c21
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
add o4.xyz, r2, r3
mov r1.w, c25.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c22.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c25.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o3.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o3.zw, r0
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 192 // 176 used size, 12 vars
Vector 144 [_MainTex_ST] 4
Vector 160 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 39 instructions, 4 temp regs, 0 temp arrays:
// ALU 35 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedolffncnpmfnfcnejlggocpipcmlplkjlabaaaaaagaahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcmeafaaaaeaaaabaa
hbabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
diaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaa
egiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_9 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  tmpvar_4 = tmpvar_11;
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_26 = tmpvar_1.xyz;
  tmpvar_27 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_28;
  tmpvar_28[0].x = tmpvar_26.x;
  tmpvar_28[0].y = tmpvar_27.x;
  tmpvar_28[0].z = tmpvar_2.x;
  tmpvar_28[1].x = tmpvar_26.y;
  tmpvar_28[1].y = tmpvar_27.y;
  tmpvar_28[1].z = tmpvar_2.y;
  tmpvar_28[2].x = tmpvar_26.z;
  tmpvar_28[2].y = tmpvar_27.z;
  tmpvar_28[2].z = tmpvar_2.z;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_28 * (((_World2Object * tmpvar_29).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump float h_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_5.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_ParallaxMap, tmpvar_5).w;
  h_4 = tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_4 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + (tmpvar_10 * (v_9.xy / v_9.z)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_16.w;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16.xyz + xlv_TEXCOORD3);
  light_3.xyz = tmpvar_17;
  lowp vec4 c_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_14.xyz * light_3.xyz);
  c_18.xyz = tmpvar_19;
  c_18.w = tmpvar_14.w;
  c_2 = c_18;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_9 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  tmpvar_4 = tmpvar_11;
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_26 = tmpvar_1.xyz;
  tmpvar_27 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_28;
  tmpvar_28[0].x = tmpvar_26.x;
  tmpvar_28[0].y = tmpvar_27.x;
  tmpvar_28[0].z = tmpvar_2.x;
  tmpvar_28[1].x = tmpvar_26.y;
  tmpvar_28[1].y = tmpvar_27.y;
  tmpvar_28[1].z = tmpvar_2.y;
  tmpvar_28[2].x = tmpvar_26.z;
  tmpvar_28[2].y = tmpvar_27.z;
  tmpvar_28[2].z = tmpvar_2.z;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_28 * (((_World2Object * tmpvar_29).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump float h_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_5.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_ParallaxMap, tmpvar_5).w;
  h_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  mediump float height_8;
  height_8 = _Parallax;
  mediump vec3 viewDir_9;
  viewDir_9 = xlv_TEXCOORD1;
  highp vec3 v_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((h_4 * height_8) - (height_8 / 2.0));
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(viewDir_9);
  v_10 = tmpvar_12;
  v_10.z = (v_10.z + 0.42);
  tmpvar_7 = (tmpvar_11 * (v_10.xy / v_10.z));
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.xy + tmpvar_7);
  highp vec2 tmpvar_14;
  tmpvar_14 = (xlv_TEXCOORD0.zw + tmpvar_7);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_16;
  tmpvar_16 = (texture2D (_MainTex, tmpvar_15) * _Color);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_RotMT.x - (((tmpvar_14.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_14.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_17.y = ((_RotMT.y - (((tmpvar_14.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_14.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, tmpvar_17).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz + xlv_TEXCOORD3);
  light_3.xyz = tmpvar_21;
  lowp vec4 c_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_16.xyz * light_3.xyz);
  c_22.xyz = tmpvar_23;
  c_22.w = tmpvar_16.w;
  c_2 = c_22;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 446
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 432
v2f_surf vert_surf( in appdata_full v ) {
    #line 434
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 438
    o.screen = ComputeScreenPos( o.pos);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 442
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec4(xl_retval.screen);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 446
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 346
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 350
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 448
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 450
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 454
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 458
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    #line 462
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    light.xyz += IN.vlight;
    mediump vec4 c = LightingLambert_PrePass( o, light);
    #line 466
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.screen = vec4(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[24] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[8];
DP4 R2.z, R1, c[15];
DP4 R2.x, R1, c[13];
DP4 R2.y, R1, c[14];
MAD R2.xyz, R2, c[20].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[18].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[19];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[19].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 34 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c24, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c16
mov r1.w, c24.x
dp4 r0.w, v0, c7
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r2.xyz, r2, c20.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c24.y
mul r1.y, r1, c17.x
mad o3.xy, r1.z, c18.zwzw, r1
mov o0, r0
mov r0.x, c19.w
add r0.y, c24.x, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c19
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mov o3.zw, r0
mul o5.xyz, r1, c19.w
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o4.xy, v4, c21, c21.zwzw
mul o5.w, -r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 224 // 192 used size, 14 vars
Vector 144 [unity_LightmapST] 4
Vector 160 [_MainTex_ST] 4
Vector 176 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 36 instructions, 3 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcblkjgpaepepjdcbidbhhpkjmlhphajhabaaaaaagmahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcliafaaaaeaaaabaagoabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
alaaaaaakgiocaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaaaaaaaaaa
pgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaa
abeaaaaaaaaaiadpdiaaaaaiiccabaaaafaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  tmpvar_4.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_4.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_11 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  mediump float h_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_8.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ParallaxMap, tmpvar_8).w;
  h_7 = tmpvar_9;
  mediump float height_10;
  height_10 = _Parallax;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD1;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = ((h_7 * height_10) - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD0.xy + (tmpvar_13 * (v_12.xy / v_12.z)));
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_15.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_15.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_15.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_15.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_17;
  tmpvar_17 = (texture2D (_MainTex, tmpvar_16) * _Color);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_6 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_19.w;
  highp float tmpvar_20;
  tmpvar_20 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lmFull_4 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD3).xyz);
  lmIndirect_3 = tmpvar_22;
  light_6.xyz = (tmpvar_19.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_17.xyz * light_6.xyz);
  c_23.xyz = tmpvar_24;
  c_23.w = tmpvar_17.w;
  c_2 = c_23;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  tmpvar_4.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_4.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_11 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  mediump float h_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_8.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ParallaxMap, tmpvar_8).w;
  h_7 = tmpvar_9;
  highp vec2 tmpvar_10;
  mediump float height_11;
  height_11 = _Parallax;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD1;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = ((h_7 * height_11) - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  tmpvar_10 = (tmpvar_14 * (v_13.xy / v_13.z));
  highp vec2 tmpvar_16;
  tmpvar_16 = (xlv_TEXCOORD0.xy + tmpvar_10);
  highp vec2 tmpvar_17;
  tmpvar_17 = (xlv_TEXCOORD0.zw + tmpvar_10);
  highp vec2 tmpvar_18;
  tmpvar_18.x = ((_RotMT.x - (((tmpvar_16.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_16.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_18.y = ((_RotMT.y - (((tmpvar_16.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_16.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_19;
  tmpvar_19 = (texture2D (_MainTex, tmpvar_18) * _Color);
  highp vec2 tmpvar_20;
  tmpvar_20.x = ((_RotMT.x - (((tmpvar_17.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_17.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_20.y = ((_RotMT.y - (((tmpvar_17.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_17.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_21;
  normal_21.xy = ((texture2D (_BumpMap, tmpvar_20).wy * 2.0) - 1.0);
  normal_21.z = sqrt((1.0 - clamp (dot (normal_21.xy, normal_21.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_6 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_23.w;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (unity_Lightmap, xlv_TEXCOORD3);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_LightmapInd, xlv_TEXCOORD3);
  highp float tmpvar_26;
  tmpvar_26 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((8.0 * tmpvar_24.w) * tmpvar_24.xyz);
  lmFull_4 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((8.0 * tmpvar_25.w) * tmpvar_25.xyz);
  lmIndirect_3 = tmpvar_28;
  light_6.xyz = (tmpvar_23.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_19.xyz * light_6.xyz);
  c_29.xyz = tmpvar_30;
  c_29.w = tmpvar_19.w;
  c_2 = c_29;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 431
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 449
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 453
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 434
v2f_surf vert_surf( in appdata_full v ) {
    #line 436
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 440
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    #line 444
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec4(xl_retval.screen);
    xlv_TEXCOORD3 = vec2(xl_retval.lmap);
    xlv_TEXCOORD4 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 431
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 449
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 453
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 346
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 350
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 454
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 457
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 461
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 465
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    #line 469
    light = (-log2(light));
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 473
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    light.xyz += lm;
    #line 477
    mediump vec4 c = LightingLambert_PrePass( o, light);
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.screen = vec4(xlv_TEXCOORD2);
    xlt_IN.lmap = vec2(xlv_TEXCOORD3);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Matrix 5 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 25 ALU
PARAM c[15] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R2.xyz, R2, c[11].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[10].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 25 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_3_0
; 26 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c15, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c15.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r2.xyz, r2, c11.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c15.y
mul r1.y, r1, c9.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o3.xy, r1.z, c10.zwzw, r1
mov o0, r0
mov o3.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
mad o4.xy, v4, c12, c12.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 224 // 192 used size, 14 vars
Vector 144 [unity_LightmapST] 4
Vector 160 [_MainTex_ST] 4
Vector 176 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 24 instructions, 3 temp regs, 0 temp arrays:
// ALU 21 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkgjppbjkoiidippjbkfllnepgmojpnolabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaadiaaaaah
hcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaa
acaaaaaaegacbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
eccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_4.zw;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_10 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump float h_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_5.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_ParallaxMap, tmpvar_5).w;
  h_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  mediump float height_8;
  height_8 = _Parallax;
  mediump vec3 viewDir_9;
  viewDir_9 = xlv_TEXCOORD1;
  highp vec3 v_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((h_4 * height_8) - (height_8 / 2.0));
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(viewDir_9);
  v_10 = tmpvar_12;
  v_10.z = (v_10.z + 0.42);
  tmpvar_7 = (tmpvar_11 * (v_10.xy / v_10.z));
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.xy + tmpvar_7);
  highp vec2 tmpvar_14;
  tmpvar_14 = (xlv_TEXCOORD0.zw + tmpvar_7);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_16;
  tmpvar_16 = (texture2D (_MainTex, tmpvar_15) * _Color);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_RotMT.x - (((tmpvar_14.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_14.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_17.y = ((_RotMT.y - (((tmpvar_14.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_14.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, tmpvar_17).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_19;
  mat3 tmpvar_20;
  tmpvar_20[0].x = 0.816497;
  tmpvar_20[0].y = -0.408248;
  tmpvar_20[0].z = -0.408248;
  tmpvar_20[1].x = 0.0;
  tmpvar_20[1].y = 0.707107;
  tmpvar_20[1].z = -0.707107;
  tmpvar_20[2].x = 0.57735;
  tmpvar_20[2].y = 0.57735;
  tmpvar_20[2].z = 0.57735;
  mediump vec3 normal_21;
  normal_21 = tmpvar_18;
  mediump vec3 scalePerBasisVector_22;
  mediump vec3 lm_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lm_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD3).xyz);
  scalePerBasisVector_22 = tmpvar_25;
  lm_23 = (lm_23 * dot (clamp ((tmpvar_20 * normal_21), 0.0, 1.0), scalePerBasisVector_22));
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = lm_23;
  mediump vec4 tmpvar_27;
  tmpvar_27 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_26);
  light_3 = tmpvar_27;
  lowp vec4 c_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyz * tmpvar_27.xyz);
  c_28.xyz = tmpvar_29;
  c_28.w = tmpvar_16.w;
  c_2 = c_28;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_4.zw;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_10 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump float h_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_5.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_ParallaxMap, tmpvar_5).w;
  h_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  mediump float height_8;
  height_8 = _Parallax;
  mediump vec3 viewDir_9;
  viewDir_9 = xlv_TEXCOORD1;
  highp vec3 v_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((h_4 * height_8) - (height_8 / 2.0));
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(viewDir_9);
  v_10 = tmpvar_12;
  v_10.z = (v_10.z + 0.42);
  tmpvar_7 = (tmpvar_11 * (v_10.xy / v_10.z));
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.xy + tmpvar_7);
  highp vec2 tmpvar_14;
  tmpvar_14 = (xlv_TEXCOORD0.zw + tmpvar_7);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_16;
  tmpvar_16 = (texture2D (_MainTex, tmpvar_15) * _Color);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_RotMT.x - (((tmpvar_14.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_14.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_17.y = ((_RotMT.y - (((tmpvar_14.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_14.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, tmpvar_17).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD3);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (unity_LightmapInd, xlv_TEXCOORD3);
  mat3 tmpvar_22;
  tmpvar_22[0].x = 0.816497;
  tmpvar_22[0].y = -0.408248;
  tmpvar_22[0].z = -0.408248;
  tmpvar_22[1].x = 0.0;
  tmpvar_22[1].y = 0.707107;
  tmpvar_22[1].z = -0.707107;
  tmpvar_22[2].x = 0.57735;
  tmpvar_22[2].y = 0.57735;
  tmpvar_22[2].z = 0.57735;
  mediump vec3 normal_23;
  normal_23 = normal_18;
  mediump vec3 scalePerBasisVector_24;
  mediump vec3 lm_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((8.0 * tmpvar_20.w) * tmpvar_20.xyz);
  lm_25 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((8.0 * tmpvar_21.w) * tmpvar_21.xyz);
  scalePerBasisVector_24 = tmpvar_27;
  lm_25 = (lm_25 * dot (clamp ((tmpvar_22 * normal_23), 0.0, 1.0), scalePerBasisVector_24));
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = lm_25;
  mediump vec4 tmpvar_29;
  tmpvar_29 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_28);
  light_3 = tmpvar_29;
  lowp vec4 c_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_16.xyz * tmpvar_29.xyz);
  c_30.xyz = tmpvar_31;
  c_30.w = tmpvar_16.w;
  c_2 = c_30;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D _LightBuffer;
#line 447
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 451
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 433
v2f_surf vert_surf( in appdata_full v ) {
    #line 435
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 439
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 443
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec4(xl_retval.screen);
    xlv_TEXCOORD3 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D _LightBuffer;
#line 447
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 451
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 353
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 355
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 346
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 350
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 451
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 455
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 459
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 463
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    #line 467
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec4 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, true);
    light += lm;
    #line 471
    mediump vec4 c = LightingLambert_PrePass( o, light);
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.screen = vec4(xlv_TEXCOORD2);
    xlt_IN.lmap = vec2(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 42 ALU
PARAM c[25] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.x, R1, c[18];
DP4 R3.y, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.w, R0.x, R0.x, -R0.y;
MUL R3.xyz, R0.w, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
ADD result.texcoord[3].xyz, R2, R3;
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 42 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c25, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.x
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r2.xyz, r2, r3
mul r3.xyz, r0.w, c21
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
add o4.xyz, r2, r3
mov r1.w, c25.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c22.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c25.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o3.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o3.zw, r0
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "color" Color
ConstBuffer "$Globals" 192 // 176 used size, 12 vars
Vector 144 [_MainTex_ST] 4
Vector 160 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 720 // 720 used size, 17 vars
Vector 608 [unity_SHAr] 4
Vector 624 [unity_SHAg] 4
Vector 640 [unity_SHAb] 4
Vector 656 [unity_SHBr] 4
Vector 672 [unity_SHBg] 4
Vector 688 [unity_SHBb] 4
Vector 704 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityLighting" 2
BindCB "UnityPerDraw" 3
// 39 instructions, 4 temp regs, 0 temp arrays:
// ALU 35 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedolffncnpmfnfcnejlggocpipcmlplkjlabaaaaaagaahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcmeafaaaaeaaaabaa
hbabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
diaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaa
egiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_9 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  tmpvar_4 = tmpvar_11;
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_26 = tmpvar_1.xyz;
  tmpvar_27 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_28;
  tmpvar_28[0].x = tmpvar_26.x;
  tmpvar_28[0].y = tmpvar_27.x;
  tmpvar_28[0].z = tmpvar_2.x;
  tmpvar_28[1].x = tmpvar_26.y;
  tmpvar_28[1].y = tmpvar_27.y;
  tmpvar_28[1].z = tmpvar_2.y;
  tmpvar_28[2].x = tmpvar_26.z;
  tmpvar_28[2].y = tmpvar_27.z;
  tmpvar_28[2].z = tmpvar_2.z;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_28 * (((_World2Object * tmpvar_29).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump float h_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_5.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_ParallaxMap, tmpvar_5).w;
  h_4 = tmpvar_6;
  mediump float height_7;
  height_7 = _Parallax;
  mediump vec3 viewDir_8;
  viewDir_8 = xlv_TEXCOORD1;
  highp vec3 v_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((h_4 * height_7) - (height_7 / 2.0));
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(viewDir_8);
  v_9 = tmpvar_11;
  v_9.z = (v_9.z + 0.42);
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy + (tmpvar_10 * (v_9.xy / v_9.z)));
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((_RotMT.x - (((tmpvar_12.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_12.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_13.y = ((_RotMT.y - (((tmpvar_12.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_12.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_14;
  tmpvar_14 = (texture2D (_MainTex, tmpvar_13) * _Color);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_16.w;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16.xyz + xlv_TEXCOORD3);
  light_3.xyz = tmpvar_17;
  lowp vec4 c_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_14.xyz * light_3.xyz);
  c_18.xyz = tmpvar_19;
  c_18.w = tmpvar_14.w;
  c_2 = c_18;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_9 * (tmpvar_2 * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  tmpvar_4 = tmpvar_11;
  highp vec3 tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_26 = tmpvar_1.xyz;
  tmpvar_27 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_28;
  tmpvar_28[0].x = tmpvar_26.x;
  tmpvar_28[0].y = tmpvar_27.x;
  tmpvar_28[0].z = tmpvar_2.x;
  tmpvar_28[1].x = tmpvar_26.y;
  tmpvar_28[1].y = tmpvar_27.y;
  tmpvar_28[1].z = tmpvar_2.y;
  tmpvar_28[2].x = tmpvar_26.z;
  tmpvar_28[2].y = tmpvar_27.z;
  tmpvar_28[2].z = tmpvar_2.z;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_28 * (((_World2Object * tmpvar_29).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump float h_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_5.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_ParallaxMap, tmpvar_5).w;
  h_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  mediump float height_8;
  height_8 = _Parallax;
  mediump vec3 viewDir_9;
  viewDir_9 = xlv_TEXCOORD1;
  highp vec3 v_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((h_4 * height_8) - (height_8 / 2.0));
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(viewDir_9);
  v_10 = tmpvar_12;
  v_10.z = (v_10.z + 0.42);
  tmpvar_7 = (tmpvar_11 * (v_10.xy / v_10.z));
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.xy + tmpvar_7);
  highp vec2 tmpvar_14;
  tmpvar_14 = (xlv_TEXCOORD0.zw + tmpvar_7);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_16;
  tmpvar_16 = (texture2D (_MainTex, tmpvar_15) * _Color);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_RotMT.x - (((tmpvar_14.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_14.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_17.y = ((_RotMT.y - (((tmpvar_14.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_14.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, tmpvar_17).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_20.xyz + xlv_TEXCOORD3);
  light_3.xyz = tmpvar_21;
  lowp vec4 c_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_16.xyz * light_3.xyz);
  c_22.xyz = tmpvar_23;
  c_22.w = tmpvar_16.w;
  c_2 = c_22;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 446
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 137
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 141
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 145
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 149
    return ((x1 + x2) + x3);
}
#line 432
v2f_surf vert_surf( in appdata_full v ) {
    #line 434
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 438
    o.screen = ComputeScreenPos( o.pos);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    #line 442
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec4(xl_retval.screen);
    xlv_TEXCOORD3 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 446
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 346
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 350
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 448
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 450
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    #line 454
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 458
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    #line 462
    light = max( light, vec4( 0.001));
    light.xyz += IN.vlight;
    mediump vec4 c = LightingLambert_PrePass( o, light);
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.screen = vec4(xlv_TEXCOORD2);
    xlt_IN.vlight = vec3(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[24] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..23] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[8];
DP4 R2.z, R1, c[15];
DP4 R2.x, R1, c[13];
DP4 R2.y, R1, c[14];
MAD R2.xyz, R2, c[20].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[18].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[19];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[19].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 34 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c24, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c16
mov r1.w, c24.x
dp4 r0.w, v0, c7
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r2.xyz, r2, c20.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c24.y
mul r1.y, r1, c17.x
mad o3.xy, r1.z, c18.zwzw, r1
mov o0, r0
mov r0.x, c19.w
add r0.y, c24.x, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c19
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mov o3.zw, r0
mul o5.xyz, r1, c19.w
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o4.xy, v4, c21, c21.zwzw
mul o5.w, -r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 224 // 192 used size, 14 vars
Vector 144 [unity_LightmapST] 4
Vector 160 [_MainTex_ST] 4
Vector 176 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 36 instructions, 3 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcblkjgpaepepjdcbidbhhpkjmlhphajhabaaaaaagmahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcliafaaaaeaaaabaagoabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaa
afaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
alaaaaaakgiocaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaaaaaaaaaa
pgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaa
abeaaaaaaaaaiadpdiaaaaaiiccabaaaafaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  tmpvar_4.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_4.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_11 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  mediump float h_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_8.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ParallaxMap, tmpvar_8).w;
  h_7 = tmpvar_9;
  mediump float height_10;
  height_10 = _Parallax;
  mediump vec3 viewDir_11;
  viewDir_11 = xlv_TEXCOORD1;
  highp vec3 v_12;
  mediump float tmpvar_13;
  tmpvar_13 = ((h_7 * height_10) - (height_10 / 2.0));
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize(viewDir_11);
  v_12 = tmpvar_14;
  v_12.z = (v_12.z + 0.42);
  highp vec2 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD0.xy + (tmpvar_13 * (v_12.xy / v_12.z)));
  highp vec2 tmpvar_16;
  tmpvar_16.x = ((_RotMT.x - (((tmpvar_15.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_15.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_16.y = ((_RotMT.y - (((tmpvar_15.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_15.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_17;
  tmpvar_17 = (texture2D (_MainTex, tmpvar_16) * _Color);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_6 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_19.w;
  highp float tmpvar_20;
  tmpvar_20 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lmFull_4 = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD3).xyz);
  lmIndirect_3 = tmpvar_22;
  light_6.xyz = (tmpvar_19.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_17.xyz * light_6.xyz);
  c_23.xyz = tmpvar_24;
  c_23.w = tmpvar_17.w;
  c_2 = c_23;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_5.zw;
  tmpvar_4.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_4.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_9 = tmpvar_1.xyz;
  tmpvar_10 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9.x;
  tmpvar_11[0].y = tmpvar_10.x;
  tmpvar_11[0].z = tmpvar_2.x;
  tmpvar_11[1].x = tmpvar_9.y;
  tmpvar_11[1].y = tmpvar_10.y;
  tmpvar_11[1].z = tmpvar_2.y;
  tmpvar_11[2].x = tmpvar_9.z;
  tmpvar_11[2].y = tmpvar_10.z;
  tmpvar_11[2].z = tmpvar_2.z;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_11 * (((_World2Object * tmpvar_12).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_6;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  mediump float h_7;
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_8.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_ParallaxMap, tmpvar_8).w;
  h_7 = tmpvar_9;
  highp vec2 tmpvar_10;
  mediump float height_11;
  height_11 = _Parallax;
  mediump vec3 viewDir_12;
  viewDir_12 = xlv_TEXCOORD1;
  highp vec3 v_13;
  mediump float tmpvar_14;
  tmpvar_14 = ((h_7 * height_11) - (height_11 / 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = normalize(viewDir_12);
  v_13 = tmpvar_15;
  v_13.z = (v_13.z + 0.42);
  tmpvar_10 = (tmpvar_14 * (v_13.xy / v_13.z));
  highp vec2 tmpvar_16;
  tmpvar_16 = (xlv_TEXCOORD0.xy + tmpvar_10);
  highp vec2 tmpvar_17;
  tmpvar_17 = (xlv_TEXCOORD0.zw + tmpvar_10);
  highp vec2 tmpvar_18;
  tmpvar_18.x = ((_RotMT.x - (((tmpvar_16.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_16.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_18.y = ((_RotMT.y - (((tmpvar_16.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_16.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_19;
  tmpvar_19 = (texture2D (_MainTex, tmpvar_18) * _Color);
  highp vec2 tmpvar_20;
  tmpvar_20.x = ((_RotMT.x - (((tmpvar_17.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_17.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_20.y = ((_RotMT.y - (((tmpvar_17.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_17.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_21;
  normal_21.xy = ((texture2D (_BumpMap, tmpvar_20).wy * 2.0) - 1.0);
  normal_21.z = sqrt((1.0 - clamp (dot (normal_21.xy, normal_21.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_6 = tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_23.w;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (unity_Lightmap, xlv_TEXCOORD3);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (unity_LightmapInd, xlv_TEXCOORD3);
  highp float tmpvar_26;
  tmpvar_26 = ((sqrt(dot (xlv_TEXCOORD4, xlv_TEXCOORD4)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((8.0 * tmpvar_24.w) * tmpvar_24.xyz);
  lmFull_4 = tmpvar_27;
  lowp vec3 tmpvar_28;
  tmpvar_28 = ((8.0 * tmpvar_25.w) * tmpvar_25.xyz);
  lmIndirect_3 = tmpvar_28;
  light_6.xyz = (tmpvar_23.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_29;
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_19.xyz * light_6.xyz);
  c_29.xyz = tmpvar_30;
  c_29.w = tmpvar_19.w;
  c_2 = c_29;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 431
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 449
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 453
uniform lowp vec4 unity_Ambient;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 434
v2f_surf vert_surf( in appdata_full v ) {
    #line 436
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 440
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    #line 444
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec4(xl_retval.screen);
    xlv_TEXCOORD3 = vec2(xl_retval.lmap);
    xlv_TEXCOORD4 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 431
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
#line 449
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 453
uniform lowp vec4 unity_Ambient;
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 346
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 350
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 454
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 457
    surfIN.uv_MainTex = IN.pack0.xy;
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    #line 461
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 465
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    #line 469
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    #line 473
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    light.xyz += lm;
    mediump vec4 c = LightingLambert_PrePass( o, light);
    #line 477
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.screen = vec4(xlv_TEXCOORD2);
    xlt_IN.lmap = vec2(xlv_TEXCOORD3);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD4);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" ATTR14
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Matrix 5 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 25 ALU
PARAM c[15] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R2.xyz, R2, c[11].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[10].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 25 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Matrix 4 [_World2Object]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_3_0
; 26 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c15, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c15.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r2.xyz, r2, c11.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c15.y
mul r1.y, r1, c9.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o3.xy, r1.z, c10.zwzw, r1
mov o0, r0
mov o3.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
mad o4.xy, v4, c12, c12.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "tangent" TexCoord2
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 224 // 192 used size, 14 vars
Vector 144 [unity_LightmapST] 4
Vector 160 [_MainTex_ST] 4
Vector 176 [_BumpMap_ST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 256 [_World2Object] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 24 instructions, 3 temp regs, 0 temp arrays:
// ALU 21 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedkgjppbjkoiidippjbkfllnepgmojpnolabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaadiaaaaah
hcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaa
acaaaaaaegacbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
eccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_4.zw;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_10 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump float h_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_5.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_ParallaxMap, tmpvar_5).w;
  h_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  mediump float height_8;
  height_8 = _Parallax;
  mediump vec3 viewDir_9;
  viewDir_9 = xlv_TEXCOORD1;
  highp vec3 v_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((h_4 * height_8) - (height_8 / 2.0));
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(viewDir_9);
  v_10 = tmpvar_12;
  v_10.z = (v_10.z + 0.42);
  tmpvar_7 = (tmpvar_11 * (v_10.xy / v_10.z));
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.xy + tmpvar_7);
  highp vec2 tmpvar_14;
  tmpvar_14 = (xlv_TEXCOORD0.zw + tmpvar_7);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_16;
  tmpvar_16 = (texture2D (_MainTex, tmpvar_15) * _Color);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_RotMT.x - (((tmpvar_14.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_14.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_17.y = ((_RotMT.y - (((tmpvar_14.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_14.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 tmpvar_18;
  tmpvar_18 = ((texture2D (_BumpMap, tmpvar_17).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_19;
  mat3 tmpvar_20;
  tmpvar_20[0].x = 0.816497;
  tmpvar_20[0].y = -0.408248;
  tmpvar_20[0].z = -0.408248;
  tmpvar_20[1].x = 0.0;
  tmpvar_20[1].y = 0.707107;
  tmpvar_20[1].z = -0.707107;
  tmpvar_20[2].x = 0.57735;
  tmpvar_20[2].y = 0.57735;
  tmpvar_20[2].z = 0.57735;
  mediump vec3 normal_21;
  normal_21 = tmpvar_18;
  mediump vec3 scalePerBasisVector_22;
  mediump vec3 lm_23;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lm_23 = tmpvar_24;
  lowp vec3 tmpvar_25;
  tmpvar_25 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD3).xyz);
  scalePerBasisVector_22 = tmpvar_25;
  lm_23 = (lm_23 * dot (clamp ((tmpvar_20 * normal_21), 0.0, 1.0), scalePerBasisVector_22));
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = lm_23;
  mediump vec4 tmpvar_27;
  tmpvar_27 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_26);
  light_3 = tmpvar_27;
  lowp vec4 c_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_16.xyz * tmpvar_27.xyz);
  c_28.xyz = tmpvar_29;
  c_28.w = tmpvar_16.w;
  c_2 = c_28;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _BumpMap_ST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Scale;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = normalize(_glesTANGENT.xyz);
  tmpvar_1.w = _glesTANGENT.w;
  vec3 tmpvar_2;
  tmpvar_2 = normalize(_glesNormal);
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_4.zw;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_8 = tmpvar_1.xyz;
  tmpvar_9 = (((tmpvar_2.yzx * tmpvar_1.zxy) - (tmpvar_2.zxy * tmpvar_1.yzx)) * _glesTANGENT.w);
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_8.x;
  tmpvar_10[0].y = tmpvar_9.x;
  tmpvar_10[0].z = tmpvar_2.x;
  tmpvar_10[1].x = tmpvar_8.y;
  tmpvar_10[1].y = tmpvar_9.y;
  tmpvar_10[1].z = tmpvar_2.y;
  tmpvar_10[2].x = tmpvar_8.z;
  tmpvar_10[2].y = tmpvar_9.z;
  tmpvar_10[2].z = tmpvar_2.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_10 * (((_World2Object * tmpvar_11).xyz * unity_Scale.w) - _glesVertex.xyz));
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp float _Parallax;
uniform lowp vec4 _Color;
uniform highp vec4 _RotPM;
uniform highp vec4 _PanPM;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _RotMT;
uniform highp vec4 _PanMT;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform highp vec4 _Time;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump float h_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = ((_RotPM.x - (((xlv_TEXCOORD0.z - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((xlv_TEXCOORD0.w - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y));
  tmpvar_5.y = ((_RotPM.y - (((xlv_TEXCOORD0.z - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((xlv_TEXCOORD0.w - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y));
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_ParallaxMap, tmpvar_5).w;
  h_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  mediump float height_8;
  height_8 = _Parallax;
  mediump vec3 viewDir_9;
  viewDir_9 = xlv_TEXCOORD1;
  highp vec3 v_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((h_4 * height_8) - (height_8 / 2.0));
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(viewDir_9);
  v_10 = tmpvar_12;
  v_10.z = (v_10.z + 0.42);
  tmpvar_7 = (tmpvar_11 * (v_10.xy / v_10.z));
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.xy + tmpvar_7);
  highp vec2 tmpvar_14;
  tmpvar_14 = (xlv_TEXCOORD0.zw + tmpvar_7);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_RotMT.x - (((tmpvar_13.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_13.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_15.y = ((_RotMT.y - (((tmpvar_13.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_13.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec4 tmpvar_16;
  tmpvar_16 = (texture2D (_MainTex, tmpvar_15) * _Color);
  highp vec2 tmpvar_17;
  tmpvar_17.x = ((_RotMT.x - (((tmpvar_14.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((tmpvar_14.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y));
  tmpvar_17.y = ((_RotMT.y - (((tmpvar_14.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((tmpvar_14.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y));
  lowp vec3 normal_18;
  normal_18.xy = ((texture2D (_BumpMap, tmpvar_17).wy * 2.0) - 1.0);
  normal_18.z = sqrt((1.0 - clamp (dot (normal_18.xy, normal_18.xy), 0.0, 1.0)));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD3);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (unity_LightmapInd, xlv_TEXCOORD3);
  mat3 tmpvar_22;
  tmpvar_22[0].x = 0.816497;
  tmpvar_22[0].y = -0.408248;
  tmpvar_22[0].z = -0.408248;
  tmpvar_22[1].x = 0.0;
  tmpvar_22[1].y = 0.707107;
  tmpvar_22[1].z = -0.707107;
  tmpvar_22[2].x = 0.57735;
  tmpvar_22[2].y = 0.57735;
  tmpvar_22[2].z = 0.57735;
  mediump vec3 normal_23;
  normal_23 = normal_18;
  mediump vec3 scalePerBasisVector_24;
  mediump vec3 lm_25;
  lowp vec3 tmpvar_26;
  tmpvar_26 = ((8.0 * tmpvar_20.w) * tmpvar_20.xyz);
  lm_25 = tmpvar_26;
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((8.0 * tmpvar_21.w) * tmpvar_21.xyz);
  scalePerBasisVector_24 = tmpvar_27;
  lm_25 = (lm_25 * dot (clamp ((tmpvar_22 * normal_23), 0.0, 1.0), scalePerBasisVector_24));
  mediump vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.xyz = lm_25;
  mediump vec4 tmpvar_29;
  tmpvar_29 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_28);
  light_3 = tmpvar_29;
  lowp vec4 c_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_16.xyz * tmpvar_29.xyz);
  c_30.xyz = tmpvar_31;
  c_30.w = tmpvar_16.w;
  c_2 = c_30;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D _LightBuffer;
#line 447
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 451
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 91
highp vec3 ObjSpaceViewDir( in highp vec4 v ) {
    highp vec3 objSpaceCameraPos = ((_World2Object * vec4( _WorldSpaceCameraPos.xyz, 1.0)).xyz * unity_Scale.w);
    return (objSpaceCameraPos - v.xyz);
}
#line 433
v2f_surf vert_surf( in appdata_full v ) {
    #line 435
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.pack0.xy = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    o.pack0.zw = ((v.texcoord.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
    #line 439
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 binormal = (cross( v.normal, v.tangent.xyz) * v.tangent.w);
    highp mat3 rotation = xll_transpose_mf3x3(mat3( v.tangent.xyz, binormal, v.normal));
    #line 443
    o.viewDir = (rotation * ObjSpaceViewDir( v.vertex));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.pack0);
    xlv_TEXCOORD1 = vec3(xl_retval.viewDir);
    xlv_TEXCOORD2 = vec4(xl_retval.screen);
    xlv_TEXCOORD3 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 400
struct Input {
    highp vec2 uv_MainTex;
    highp vec2 uv_BumpMap;
    highp vec3 viewDir;
};
#line 421
struct v2f_surf {
    highp vec4 pos;
    highp vec4 pack0;
    highp vec3 viewDir;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
#line 393
uniform highp vec4 _PanMT;
uniform highp vec4 _RotMT;
uniform sampler2D _ParallaxMap;
uniform highp vec4 _PanPM;
#line 397
uniform highp vec4 _RotPM;
uniform lowp vec4 _Color;
uniform highp float _Parallax;
#line 407
#line 430
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BumpMap_ST;
uniform sampler2D _LightBuffer;
#line 447
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 451
#line 177
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 179
    return (2.0 * color.xyz);
}
#line 325
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 329
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 334
    return lm;
}
#line 353
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 355
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 346
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 350
    c.w = s.Alpha;
    return c;
}
#line 166
highp vec2 ParallaxOffset( in mediump float h, in mediump float height, in mediump vec3 viewDir ) {
    h = ((h * height) - (height / 2.0));
    highp vec3 v = normalize(viewDir);
    #line 170
    v.z += 0.42;
    return (h * (v.xy / v.z));
}
#line 272
lowp vec3 UnpackNormal( in lowp vec4 packednormal ) {
    #line 274
    return ((packednormal.xyz * 2.0) - 1.0);
}
#line 407
void surf( in Input IN, inout SurfaceOutput o ) {
    highp vec2 UV_PanPM = vec2( ((_RotPM.x - (((IN.uv_BumpMap.x - _RotPM.x) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotPM.y) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.x * _Time.y)), ((_RotPM.y - (((IN.uv_BumpMap.x - _RotPM.x) * sin(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotPM.y) * cos(((_RotPM.z * _Time.y) + (3.14159 * (1.0 + (_RotPM.w / 180.0)))))))) + (_PanPM.y * _Time.y)));
    mediump float h = texture( _ParallaxMap, UV_PanPM).w;
    #line 411
    highp vec2 offset = ParallaxOffset( h, _Parallax, IN.viewDir);
    IN.uv_MainTex += offset;
    IN.uv_BumpMap += offset;
    highp vec2 UV_PanMT = vec2( ((_RotMT.x - (((IN.uv_MainTex.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_MainTex.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_MainTex.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_MainTex.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 415
    lowp vec4 c = (texture( _MainTex, UV_PanMT) * _Color);
    o.Albedo = c.xyz;
    o.Alpha = c.w;
    highp vec2 UV_PanBM = vec2( ((_RotMT.x - (((IN.uv_BumpMap.x - _RotMT.x) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) - ((IN.uv_BumpMap.y - _RotMT.y) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.x * _Time.y)), ((_RotMT.y - (((IN.uv_BumpMap.x - _RotMT.x) * sin(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))) + ((IN.uv_BumpMap.y - _RotMT.y) * cos(((_RotMT.z * _Time.y) + (3.14159 * (1.0 + (_RotMT.w / 180.0)))))))) + (_PanMT.y * _Time.y)));
    #line 419
    o.Normal = UnpackNormal( texture( _BumpMap, UV_PanBM));
}
#line 451
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    surfIN.uv_MainTex = IN.pack0.xy;
    #line 455
    surfIN.uv_BumpMap = IN.pack0.zw;
    surfIN.viewDir = IN.viewDir;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    #line 459
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    #line 463
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    #line 467
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec4 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, true);
    light += lm;
    mediump vec4 c = LightingLambert_PrePass( o, light);
    #line 471
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.pack0 = vec4(xlv_TEXCOORD0);
    xlt_IN.viewDir = vec3(xlv_TEXCOORD1);
    xlt_IN.screen = vec4(xlv_TEXCOORD2);
    xlt_IN.lmap = vec2(xlv_TEXCOORD3);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 50 to 82, TEX: 3 to 6
//   d3d9 - ALU: 70 to 100, TEX: 3 to 6
//   d3d11 - ALU: 33 to 47, TEX: 3 to 6, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_LightBuffer] 2D
"3.0-!!ARBfp1.0
# 53 ALU, 3 TEX
PARAM c[9] = { program.local[0..6],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999 } };
TEMP R0;
TEMP R1;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[7], c[7].y;
MOV R1.x, c[0].y;
MUL R0.x, R0, c[7].z;
MAD R0.y, R1.x, c[4].z, R0.x;
COS R0.x, R0.y;
SIN R0.z, R0.y;
ADD R0.y, fragment.texcoord[0].w, -c[4];
MUL R0.w, R0.y, R0.z;
MUL R1.y, R0.x, R0;
ADD R0.y, fragment.texcoord[0].z, -c[4].x;
MAD R0.x, R0.y, R0, -R0.w;
MAD R0.z, R0.y, R0, R1.y;
ADD R0.y, -R0.z, c[4];
ADD R0.x, -R0, c[4];
MAD R0.y, R1.x, c[3], R0;
MAD R0.x, R1, c[3], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[6];
MUL R1.y, R0.x, c[7].w;
MAD R0.w, R0, c[6].x, -R1.y;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[8].x;
RCP R0.z, R0.z;
MUL R0.xy, R0, R0.z;
MAD R0.xy, R0.w, R0, fragment.texcoord[0];
MOV R1.y, c[2].w;
MAD R1.y, R1, c[7].x, c[7];
MUL R0.z, R1.y, c[7];
MAD R0.z, R1.x, c[2], R0;
ADD R1.y, R0, -c[2];
SIN R0.y, R0.z;
COS R0.w, R0.z;
MUL R0.z, R0.w, R1.y;
MUL R1.y, R1, R0;
ADD R0.x, R0, -c[2];
MAD R0.y, R0.x, R0, R0.z;
MAD R0.w, R0.x, R0, -R1.y;
ADD R0.x, -R0.w, c[2];
ADD R0.y, -R0, c[2];
MAD R0.x, R1, c[1], R0;
MAD R0.y, R1.x, c[1], R0;
TXP R1.xyz, fragment.texcoord[2], texture[3], 2D;
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[5];
LG2 R1.x, R1.x;
LG2 R1.z, R1.z;
LG2 R1.y, R1.y;
ADD R1.xyz, -R1, fragment.texcoord[3];
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 53 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_LightBuffer] 2D
"ps_3_0
; 73 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c7, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c8, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c9, 0.41999999, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3.xyz
mov r0.x, c4.w
mad r0.x, r0, c7, c7.y
mul r0.y, r0.x, c7.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c8, c8.y
frc r0.x, r0
mad r1.x, r0, c8.z, c8.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c7.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
mov r0.y, c2.w
dp3_pp r0.x, v1, v1
mad_pp r1.z, r0.w, c6.x, -r0
mad r0.y, r0, c7.x, c7
mul r0.z, r0.y, c7
mov r0.y, c2.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c8.x, c8.y
frc r0.w, r0
add r0.z, r0, c9.x
rcp r0.z, r0.z
mul r1.xy, r0, r0.z
mad r1.w, r0, c8.z, c8
sincos r0.xy, r1.w
mad r0.zw, r1.z, r1.xyxy, v0.xyxy
add r0.w, r0, -c2.y
mul r1.x, r0.w, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c2.x
mad r0.y, r0.z, r0, r0.w
mad r0.z, r0, r0.x, -r1.x
texldp r1.xyz, v2, s3
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r0, r0, s1
mul r0, r0, c5
log_pp r1.x, r1.x
log_pp r1.z, r1.z
log_pp r1.y, r1.y
add_pp r1.xyz, -r1, v3
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 192 // 132 used size, 12 vars
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 1
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
// 41 instructions, 3 temp regs, 0 temp arrays:
// ALU 34 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhbcnoiiflfkfmhkibepbobolcekclekmabaaaaaacaahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcbiagaaaaeaaaaaaaigabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
abeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaa
agaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaa
aaaaaaaabcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaa
pgbobaaaabaaaaaafgiecaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaa
aaaaaaaaagaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaa
agaaaaaadcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaa
abaaaaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaa
aaaaaaaaafaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadp
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
akaabaiaebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
mcaabaaaaaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaa
aaaaaaaackbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaah
gcaabaaaaaaaaaaapgaobaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajdcaabaaa
aaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaabgbfbaaaabaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegaabaaaaaaaaaaabgifcaiaebaaaaaaaaaaaaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdl
abeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
nlapejeadcaaaaalecaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaa
abaaaaaaaaaaaaaackaabaaaaaaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaa
acaaaaaackaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaaagaebaaaaaaaaaaa
agaabaaaabaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaadcaaaaalccaabaaa
abaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaajbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaa
aaaaaaaaaeaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaadaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegbcbaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
Vector 7 [unity_LightmapFade]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 64 ALU, 5 TEX
PARAM c[10] = { program.local[0..7],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[8], c[8].y;
MUL R0.y, R0.x, c[8].z;
MOV R0.x, c[0].y;
MAD R0.y, R0.x, c[4].z, R0;
TEX R2, fragment.texcoord[3], texture[5], 2D;
MUL R2.xyz, R2.w, R2;
COS R0.z, R0.y;
SIN R0.w, R0.y;
ADD R0.y, fragment.texcoord[0].w, -c[4];
MUL R1.x, R0.y, R0.w;
MUL R1.y, R0.z, R0;
ADD R0.y, fragment.texcoord[0].z, -c[4].x;
MAD R0.w, R0.y, R0, R1.y;
MAD R0.y, R0, R0.z, -R1.x;
ADD R0.z, -R0.w, c[4].y;
MAD R0.w, R0.x, c[3].y, R0.z;
ADD R0.y, -R0, c[4].x;
MAD R0.z, R0.x, c[3].x, R0.y;
TEX R0.w, R0.zwzw, texture[0], 2D;
DP3 R0.z, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.z, R0.z;
MUL R1.xyz, R0.z, fragment.texcoord[1];
ADD R0.z, R1, c[9].x;
MOV R0.y, c[6].x;
MUL R0.y, R0, c[8].w;
MAD R0.y, R0.w, c[6].x, -R0;
MOV R0.w, c[2];
MAD R1.z, R0.w, c[8].x, c[8].y;
RCP R0.z, R0.z;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0.y, R0, fragment.texcoord[0].xyxy;
MUL R1.x, R1.z, c[8].z;
MAD R0.y, R0.x, c[2].z, R1.x;
ADD R1.x, R0.w, -c[2].y;
SIN R1.y, R0.y;
COS R0.w, R0.y;
MUL R1.z, R1.x, R1.y;
MUL R1.x, R0.w, R1;
ADD R0.y, R0.z, -c[2].x;
MAD R0.z, R0.y, R1.y, R1.x;
MAD R0.y, R0, R0.w, -R1.z;
ADD R0.w, -R0.z, c[2].y;
ADD R0.z, -R0.y, c[2].x;
MAD R0.y, R0.x, c[1], R0.w;
TEX R1, fragment.texcoord[3], texture[4], 2D;
MUL R1.xyz, R1.w, R1;
MUL R2.xyz, R2, c[9].y;
MAD R3.xyz, R1, c[9].y, -R2;
TXP R1.xyz, fragment.texcoord[2], texture[3], 2D;
MAD R0.x, R0, c[1], R0.z;
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[5];
DP4 R1.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.w, R1.w;
RCP R1.w, R1.w;
MAD_SAT R1.w, R1, c[7].z, c[7];
MAD R2.xyz, R1.w, R3, R2;
LG2 R1.x, R1.x;
LG2 R1.y, R1.y;
LG2 R1.z, R1.z;
ADD R1.xyz, -R1, R2;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 64 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
Vector 7 [unity_LightmapFade]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 82 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c9, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c10, 0.41999999, 8.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
mov r0.x, c4.w
mad r0.x, r0, c8, c8.y
mul r0.y, r0.x, c8.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c9, c9.y
frc r0.x, r0
mad r1.x, r0, c9.z, c9.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
texld r2, v3, s5
mul_pp r2.xyz, r2.w, r2
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c8.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
mov r0.y, c2.w
dp3_pp r0.x, v1, v1
mad_pp r1.x, r0.w, c6, -r0.z
mad r0.y, r0, c8.x, c8
mul r0.z, r0.y, c8
mov r0.y, c2.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c9.x, c9.y
frc r0.w, r0
add r0.z, r0, c10.x
rcp r0.z, r0.z
mad r1.y, r0.w, c9.z, c9.w
mul r1.zw, r0.xyxy, r0.z
sincos r0.xy, r1.y
mad r0.zw, r1.x, r1, v0.xyxy
add r0.w, r0, -c2.y
mul r1.x, r0.w, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c2.x
mad r0.y, r0.z, r0, r0.w
mad r0.z, r0, r0.x, -r1.x
texld r1, v3, s4
mul_pp r1.xyz, r1.w, r1
mul_pp r2.xyz, r2, c10.y
mad_pp r3.xyz, r1, c10.y, -r2
texldp r1.xyz, v2, s3
dp4 r1.w, v4, v4
rsq r1.w, r1.w
rcp r1.w, r1.w
mad_sat r1.w, r1, c7.z, c7
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r0, r0, s1
mul r0, r0, c5
mad_pp r2.xyz, r1.w, r3, r2
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
add_pp r1.xyz, -r1, r2
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 224 // 208 used size, 14 vars
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
Vector 192 [unity_LightmapFade] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 1
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
// 51 instructions, 3 temp regs, 0 temp arrays:
// ALU 42 float, 0 int, 0 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedebekpfaepafafohefnkebdbagigleecdabaaaaaamaaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaahaaaa
eaaaaaaaoiabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaa
gballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaa
abaaaaaafgiecaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaaaaaaaaaa
agaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaa
dcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaabaaaaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaa
afaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadpdcaaaaal
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaakaabaia
ebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaa
ckbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahgcaabaaa
aaaaaaaapgaobaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaabgbfbaaaabaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegaabaaaaaaaaaaabgifcaiaebaaaaaaaaaaaaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejea
dcaaaaalecaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaaabaaaaaa
aaaaaaaackaabaaaaaaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaa
ckaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaaagaebaaaaaaaaaaaagaabaaa
abaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
ckaabaiaebaaaaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaadcaaaaalccaabaaaabaaaaaa
bkiacaaaaaaaaaaaadaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
aeaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaabbaaaaahbcaabaaaabaaaaaa
egbobaaaafaaaaaaegbobaaaafaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadccaaaalbcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaa
amaaaaaadkiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaa
acaaaaaafgafbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaacaaaaaajgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaa
acaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaa
acaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 82 ALU, 6 TEX
PARAM c[12] = { program.local[0..6],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 2, 8 },
		{ -0.40824828, -0.70710677, 0.57735026 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[7], c[7].y;
MOV R1.w, c[0].y;
MUL R0.x, R0, c[7].z;
MAD R0.x, R1.w, c[4].z, R0;
COS R0.y, R0.x;
SIN R0.z, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[4].y;
MUL R0.w, R0.x, R0.z;
MUL R1.x, R0.y, R0;
ADD R0.x, fragment.texcoord[0].z, -c[4];
MAD R0.z, R0.x, R0, R1.x;
MAD R0.x, R0, R0.y, -R0.w;
ADD R0.y, -R0.z, c[4];
ADD R0.x, -R0, c[4];
MAD R0.y, R1.w, c[3], R0;
MAD R0.x, R1.w, c[3], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[6];
MUL R1.x, R0, c[7].w;
MAD R3.w, R0, c[6].x, -R1.x;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[8].x;
RCP R0.z, R0.z;
MUL R3.xy, R0, R0.z;
MAD R0.xy, R3.w, R3, fragment.texcoord[0].zwzw;
MOV R0.w, c[2];
MAD R0.w, R0, c[7].x, c[7].y;
MUL R0.z, R0.w, c[7];
MAD R0.z, R1.w, c[2], R0;
SIN R3.z, R0.z;
COS R2.w, R0.z;
ADD R0.y, R0, -c[2];
MUL R0.z, R2.w, R0.y;
ADD R0.x, R0, -c[2];
MUL R0.y, R3.z, R0;
MAD R0.y, R2.w, R0.x, -R0;
MAD R0.z, R3, R0.x, R0;
ADD R0.x, -R0.y, c[2];
ADD R0.y, -R0.z, c[2];
MAD R0.x, R1.w, c[1], R0;
MAD R0.y, R1.w, c[1], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R0.z, c[7].y;
MAD R2.xy, R0.wyzw, c[8].y, -R0.z;
MUL R0.xy, R2, R2;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[7].y;
RSQ R0.x, R0.x;
RCP R2.z, R0.x;
TEX R0, fragment.texcoord[3], texture[5], 2D;
DP3_SAT R1.z, R2, c[9];
DP3_SAT R1.y, R2, c[10];
DP3_SAT R1.x, R2, c[11];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
DP3 R1.z, R0, c[8].z;
MAD R1.xy, R3.w, R3, fragment.texcoord[0];
TEX R0, fragment.texcoord[3], texture[4], 2D;
MUL R0.xyz, R0.w, R0;
MUL R2.xyz, R0, R1.z;
ADD R1.y, R1, -c[2];
ADD R0.x, R1, -c[2];
MUL R0.z, R2.w, R1.y;
MUL R0.y, R1, R3.z;
TXP R1.xyz, fragment.texcoord[2], texture[3], 2D;
MAD R0.y, R0.x, R2.w, -R0;
MAD R0.z, R0.x, R3, R0;
ADD R0.x, -R0.y, c[2];
ADD R0.y, -R0.z, c[2];
MAD R0.x, R1.w, c[1], R0;
MAD R0.y, R1.w, c[1], R0;
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[5];
LG2 R1.x, R1.x;
LG2 R1.z, R1.z;
LG2 R1.y, R1.y;
MAD R1.xyz, R2, c[8].z, -R1;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 82 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 100 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c7, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c8, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c9, 0.41999999, 2.00000000, -1.00000000, 8.00000000
def c10, -0.40824828, -0.70710677, 0.57735026, 0
def c11, -0.40824831, 0.70710677, 0.57735026, 0
def c12, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3.xy
mov r0.x, c4.w
mad r0.x, r0, c7, c7.y
mul r0.y, r0.x, c7.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c8, c8.y
frc r0.x, r0
mad r1.x, r0, c8.z, c8.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c7.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
dp3_pp r0.x, v1, v1
mad_pp r1.w, r0, c6.x, -r0.z
mov r0.y, c2.w
mad r0.w, r0.y, c7.x, c7.y
mul r1.x, r0.w, c7.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mov r0.w, c2.z
mad r0.w, c0.y, r0, r1.x
add r0.z, r0, c9.x
rcp r0.z, r0.z
mul r4.xy, r0, r0.z
mad r0.xy, r1.w, r4, v0.zwzw
mad r0.w, r0, c8.x, c8.y
frc r0.w, r0
mad r0.z, r0.w, c8, c8.w
sincos r3.xy, r0.z
add r0.y, r0, -c2
mul r0.z, r3.y, r0.y
add r0.x, r0, -c2
mad r0.z, r3.x, r0.x, -r0
mul r0.y, r3.x, r0
mad r0.y, r3, r0.x, r0
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r0.yw, r0, s2
mad_pp r2.xy, r0.wyzw, c9.y, c9.z
mul_pp r0.xy, r2, r2
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c7.y
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
texld r0, v3, s5
dp3_pp_sat r1.z, r2, c10
dp3_pp_sat r1.y, r2, c11
dp3_pp_sat r1.x, r2, c12
texldp r2.xyz, v2, s3
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mad r1.xy, r1.w, r4, v0
dp3_pp r1.z, r0, c9.w
texld r0, v3, s4
mul_pp r0.xyz, r0.w, r0
add r0.w, r1.x, -c2.x
mul_pp r0.xyz, r0, r1.z
add r1.y, r1, -c2
mul r1.z, r1.y, r3.x
mul r1.y, r1, r3
mad r1.x, r0.w, r3, -r1.y
mad r1.y, r0.w, r3, r1.z
mov r0.w, c1.x
add r1.x, -r1, c2
mad r1.x, c0.y, r0.w, r1
add r1.y, -r1, c2
mov r0.w, c1.y
mad r1.y, c0, r0.w, r1
texld r1, r1, s1
mul r1, r1, c5
log_pp r2.x, r2.x
log_pp r2.z, r2.z
log_pp r2.y, r2.y
mad_pp r0.xyz, r0, c9.w, -r2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 224 // 132 used size, 14 vars
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_BumpMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
// 57 instructions, 3 temp regs, 0 temp arrays:
// ALU 47 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedoklllcadcieckkemjjfnhpphbfeaneloabaaaaaajeajaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcimaiaaaaeaaaaaaacdacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadcaaaaak
bcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaanlapejea
dcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaabkiacaaaabaaaaaa
aaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaaabaaaaaafgiecaia
ebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaaaaaaaaaaagaabaaaaaaaaaaa
fgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaadcaaaaalccaabaaa
abaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaabaaaaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaibcaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadpdcaaaaalbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaafgafbaaa
aaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaackbabaaaacaaaaaa
bkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahpcaabaaaabaaaaaalgalbaaa
aaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaajpcaabaaaaaaaaaaaegaobaaa
aaaaaaaabgibcaiaebaaaaaaaaaaaaaaaeaaaaaadcaaaaakbcaabaaaabaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeadcaaaaalbcaabaaa
abaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaa
abaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaadcaaaaak
kcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaaagaibaiaebaaaaaa
abaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaaaaaaaaaaagaabaaaacaaaaaa
fgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaaagacbaiaebaaaaaaaaaaaaaa
fgifcaaaaaaaaaaaaeaaaaaadcaaaaalmcaabaaaabaaaaaafgifcaaaaaaaaaaa
adaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaaaaaaaaaaaeaaaaaadcaaaaal
dcaabaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaafgifcaaaabaaaaaaaaaaaaaa
egaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaangafbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaaapcaaaakbcaabaaa
acaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaaaaaaaaa
bacaaaakccaabaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
egacbaaaaaaaaaaabacaaaakecaabaaaacaaaaaaaceaaaaaolafnblopdaedflp
dkmnbddpaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
aeaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaaoaaaaahgcaabaaaaaaaaaaaagbbbaaaadaaaaaapgbpbaaa
adaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaaaaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaacpaaaaafocaabaaaaaaaaaaaagajbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaacaaaaaaagaabaaaaaaaaaaajgahbaiaebaaaaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_LightBuffer] 2D
"3.0-!!ARBfp1.0
# 50 ALU, 3 TEX
PARAM c[9] = { program.local[0..6],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999 } };
TEMP R0;
TEMP R1;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[7], c[7].y;
MOV R1.x, c[0].y;
MUL R0.x, R0, c[7].z;
MAD R0.y, R1.x, c[4].z, R0.x;
COS R0.x, R0.y;
SIN R0.z, R0.y;
ADD R0.y, fragment.texcoord[0].w, -c[4];
MUL R0.w, R0.y, R0.z;
MUL R1.y, R0.x, R0;
ADD R0.y, fragment.texcoord[0].z, -c[4].x;
MAD R0.x, R0.y, R0, -R0.w;
MAD R0.z, R0.y, R0, R1.y;
ADD R0.y, -R0.z, c[4];
ADD R0.x, -R0, c[4];
MAD R0.y, R1.x, c[3], R0;
MAD R0.x, R1, c[3], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[6];
MUL R1.y, R0.x, c[7].w;
MAD R0.w, R0, c[6].x, -R1.y;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[8].x;
RCP R0.z, R0.z;
MUL R0.xy, R0, R0.z;
MAD R0.xy, R0.w, R0, fragment.texcoord[0];
MOV R1.y, c[2].w;
MAD R1.y, R1, c[7].x, c[7];
MUL R0.z, R1.y, c[7];
MAD R0.z, R1.x, c[2], R0;
ADD R1.y, R0, -c[2];
SIN R0.y, R0.z;
MUL R0.w, R1.y, R0.y;
COS R0.z, R0.z;
MUL R1.y, R0.z, R1;
ADD R0.x, R0, -c[2];
MAD R0.y, R0.x, R0, R1;
MAD R0.x, R0, R0.z, -R0.w;
ADD R0.y, -R0, c[2];
ADD R0.x, -R0, c[2];
MAD R0.y, R1.x, c[1], R0;
MAD R0.x, R1, c[1], R0;
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[5];
TXP R1.xyz, fragment.texcoord[2], texture[3], 2D;
ADD R1.xyz, R1, fragment.texcoord[3];
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 50 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_LightBuffer] 2D
"ps_3_0
; 70 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c7, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c8, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c9, 0.41999999, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3.xyz
mov r0.x, c4.w
mad r0.x, r0, c7, c7.y
mul r0.y, r0.x, c7.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c8, c8.y
frc r0.x, r0
mad r1.x, r0, c8.z, c8.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c7.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
mov r0.y, c2.w
dp3_pp r0.x, v1, v1
mad_pp r1.z, r0.w, c6.x, -r0
mad r0.y, r0, c7.x, c7
mul r0.z, r0.y, c7
mov r0.y, c2.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c8.x, c8.y
frc r0.w, r0
add r0.z, r0, c9.x
rcp r0.z, r0.z
mul r1.xy, r0, r0.z
mad r1.w, r0, c8.z, c8
sincos r0.xy, r1.w
mad r0.zw, r1.z, r1.xyxy, v0.xyxy
add r0.w, r0, -c2.y
mul r1.x, r0.w, r0.y
mul r0.w, r0, r0.x
add r0.z, r0, -c2.x
mad r0.y, r0.z, r0, r0.w
mad r0.z, r0, r0.x, -r1.x
texldp r1.xyz, v2, s3
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r0, r0, s1
mul r0, r0, c5
add_pp r1.xyz, r1, v3
mov_pp oC0.w, r0
mul_pp oC0.xyz, r0, r1
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 192 // 132 used size, 12 vars
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 1
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
// 40 instructions, 3 temp regs, 0 temp arrays:
// ALU 33 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedogaeeofkemngceelgambhodbihihigppabaaaaaaaiahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcaaagaaaaeaaaaaaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
abeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaa
agaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaa
aaaaaaaabcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaa
pgbobaaaabaaaaaafgiecaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaa
aaaaaaaaagaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaa
agaaaaaadcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaa
abaaaaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaa
aaaaaaaaafaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadp
dcaaaaalbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
akaabaiaebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
mcaabaaaaaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaa
aaaaaaaackbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaah
gcaabaaaaaaaaaaapgaobaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajdcaabaaa
aaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaabgbfbaaaabaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegaabaaaaaaaaaaabgifcaiaebaaaaaaaaaaaaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdl
abeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
nlapejeadcaaaaalecaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaa
abaaaaaaaaaaaaaackaabaaaaaaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaa
acaaaaaackaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaaagaebaaaaaaaaaaa
agaabaaaabaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaadcaaaaalccaabaaa
abaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaajbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaa
aaaaaaaaaeaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaadaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
Vector 7 [unity_LightmapFade]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 61 ALU, 5 TEX
PARAM c[10] = { program.local[0..7],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[8], c[8].y;
MUL R0.y, R0.x, c[8].z;
MOV R0.x, c[0].y;
MAD R0.y, R0.x, c[4].z, R0;
COS R0.z, R0.y;
SIN R0.w, R0.y;
ADD R0.y, fragment.texcoord[0].w, -c[4];
MUL R1.x, R0.y, R0.w;
MUL R1.y, R0.z, R0;
ADD R0.y, fragment.texcoord[0].z, -c[4].x;
MAD R0.w, R0.y, R0, R1.y;
MAD R0.y, R0, R0.z, -R1.x;
ADD R0.z, -R0.w, c[4].y;
MAD R0.w, R0.x, c[3].y, R0.z;
ADD R0.y, -R0, c[4].x;
MAD R0.z, R0.x, c[3].x, R0.y;
TEX R0.w, R0.zwzw, texture[0], 2D;
DP3 R0.z, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.z, R0.z;
MUL R1.xyz, R0.z, fragment.texcoord[1];
ADD R0.z, R1, c[9].x;
MOV R0.y, c[6].x;
MUL R0.y, R0, c[8].w;
MAD R0.y, R0.w, c[6].x, -R0;
MOV R0.w, c[2];
MAD R1.z, R0.w, c[8].x, c[8].y;
RCP R0.z, R0.z;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0.y, R0, fragment.texcoord[0].xyxy;
MUL R1.x, R1.z, c[8].z;
MAD R0.y, R0.x, c[2].z, R1.x;
ADD R1.x, R0.w, -c[2].y;
COS R0.w, R0.y;
SIN R1.y, R0.y;
MUL R1.z, R0.w, R1.x;
ADD R0.y, R0.z, -c[2].x;
MUL R1.x, R1, R1.y;
MAD R0.z, R0.y, R0.w, -R1.x;
MAD R0.w, R0.y, R1.y, R1.z;
ADD R0.y, -R0.z, c[2].x;
TEX R1, fragment.texcoord[3], texture[4], 2D;
MUL R2.xyz, R1.w, R1;
TEX R1, fragment.texcoord[3], texture[5], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[9].y;
ADD R0.w, -R0, c[2].y;
DP4 R2.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.w, R2.w;
RCP R1.w, R1.w;
MAD R2.xyz, R2, c[9].y, -R1;
MAD_SAT R1.w, R1, c[7].z, c[7];
MAD R2.xyz, R1.w, R2, R1;
TXP R1.xyz, fragment.texcoord[2], texture[3], 2D;
MAD R0.z, R0.x, c[1].x, R0.y;
MAD R0.w, R0.x, c[1].y, R0;
TEX R0, R0.zwzw, texture[1], 2D;
MUL R0, R0, c[5];
ADD R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 61 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
Vector 7 [unity_LightmapFade]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 79 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c9, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c10, 0.41999999, 8.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
mov r0.x, c4.w
mad r0.x, r0, c8, c8.y
mul r0.y, r0.x, c8.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c9, c9.y
frc r0.x, r0
mad r1.x, r0, c9.z, c9.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c8.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
mov r0.y, c2.w
dp3_pp r0.x, v1, v1
mad_pp r1.x, r0.w, c6, -r0.z
mad r0.y, r0, c8.x, c8
mul r0.z, r0.y, c8
mov r0.y, c2.z
mad r0.w, c0.y, r0.y, r0.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mad r0.w, r0, c9.x, c9.y
frc r0.w, r0
add r0.z, r0, c10.x
rcp r0.z, r0.z
mad r1.y, r0.w, c9.z, c9.w
mul r1.zw, r0.xyxy, r0.z
sincos r0.xy, r1.y
mad r0.zw, r1.x, r1, v0.xyxy
add r0.w, r0, -c2.y
mul r1.x, r0.w, r0
mul r0.w, r0, r0.y
add r0.z, r0, -c2.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c2.x
texld r1, v3, s4
mul_pp r2.xyz, r1.w, r1
texld r1, v3, s5
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c10.y
mov r0.x, c1
mad r0.x, c0.y, r0, r0.y
dp4 r2.w, v4, v4
rsq r1.w, r2.w
rcp r1.w, r1.w
mad_pp r2.xyz, r2, c10.y, -r1
mad_sat r1.w, r1, c7.z, c7
mad_pp r2.xyz, r1.w, r2, r1
texldp r1.xyz, v2, s3
add r0.z, -r0, c2.y
mov r0.y, c1
mad r0.y, c0, r0, r0.z
texld r0, r0, s1
mul r0, r0, c5
add_pp r1.xyz, r1, r2
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 224 // 208 used size, 14 vars
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
Vector 192 [unity_LightmapFade] 4
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 1
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
// 50 instructions, 3 temp regs, 0 temp arrays:
// ALU 41 float, 0 int, 0 uint
// TEX 5 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcflmjmgjllcfgaojhdbgfganfcfkodobabaaaaaakiaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciiahaaaa
eaaaaaaaocabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaadcaaaaakbcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaa
gballgdlabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaanlapejeadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaa
bkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaa
bcaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaa
abaaaaaafgiecaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaaaaaaaaaa
agaabaaaaaaaaaaafgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaaj
dcaabaaaaaaaaaaaegaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaa
dcaaaaalccaabaaaabaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaabaaaaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaa
afaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadpdcaaaaal
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaakaabaia
ebaaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaa
ckbabaaaacaaaaaabkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahgcaabaaa
aaaaaaaapgaobaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgafbaaaaaaaaaaabgbfbaaaabaaaaaaaaaaaaajdcaabaaa
aaaaaaaaegaabaaaaaaaaaaabgifcaiaebaaaaaaaaaaaaaaaeaaaaaadcaaaaak
ecaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanlapejea
dcaaaaalecaabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaaabaaaaaa
aaaaaaaackaabaaaaaaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaa
ckaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaaagaebaaaaaaaaaaaagaabaaa
abaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaa
ckaabaiaebaaaaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaadcaaaaalccaabaaaabaaaaaa
bkiacaaaaaaaaaaaadaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
aeaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaabbaaaaahbcaabaaaabaaaaaa
egbobaaaafaaaaaaegbobaaaafaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadccaaaalbcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaa
amaaaaaadkiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
aeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaa
acaaaaaafgafbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaa
egacbaaaacaaaaaajgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaa
acaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"3.0-!!ARBfp1.0
# 79 ALU, 6 TEX
PARAM c[12] = { program.local[0..6],
		{ 0.0055555557, 1, 3.1415927, 0.5 },
		{ 0.41999999, 2, 8 },
		{ -0.40824828, -0.70710677, 0.57735026 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4].w;
MAD R0.x, R0, c[7], c[7].y;
MOV R1.w, c[0].y;
MUL R0.x, R0, c[7].z;
MAD R0.x, R1.w, c[4].z, R0;
COS R0.y, R0.x;
SIN R0.z, R0.x;
ADD R0.x, fragment.texcoord[0].w, -c[4].y;
MUL R0.w, R0.x, R0.z;
MUL R1.x, R0.y, R0;
ADD R0.x, fragment.texcoord[0].z, -c[4];
MAD R0.z, R0.x, R0, R1.x;
MAD R0.x, R0, R0.y, -R0.w;
ADD R0.y, -R0.z, c[4];
ADD R0.x, -R0, c[4];
MAD R0.y, R1.w, c[3], R0;
MAD R0.x, R1.w, c[3], R0;
TEX R0.w, R0, texture[0], 2D;
MOV R0.x, c[6];
MUL R1.x, R0, c[7].w;
MAD R3.w, R0, c[6].x, -R1.x;
DP3 R0.y, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, fragment.texcoord[1];
ADD R0.z, R0, c[8].x;
RCP R0.z, R0.z;
MUL R3.xy, R0, R0.z;
MAD R0.xy, R3.w, R3, fragment.texcoord[0].zwzw;
MOV R0.w, c[2];
MAD R0.w, R0, c[7].x, c[7].y;
MUL R0.z, R0.w, c[7];
MAD R0.z, R1.w, c[2], R0;
SIN R3.z, R0.z;
COS R2.w, R0.z;
ADD R0.y, R0, -c[2];
MUL R0.z, R2.w, R0.y;
ADD R0.x, R0, -c[2];
MUL R0.y, R3.z, R0;
MAD R0.y, R2.w, R0.x, -R0;
MAD R0.z, R3, R0.x, R0;
ADD R0.x, -R0.y, c[2];
ADD R0.y, -R0.z, c[2];
MAD R0.x, R1.w, c[1], R0;
MAD R0.y, R1.w, c[1], R0;
TEX R0.yw, R0, texture[2], 2D;
MOV R0.z, c[7].y;
MAD R2.xy, R0.wyzw, c[8].y, -R0.z;
MUL R0.xy, R2, R2;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[7].y;
RSQ R0.x, R0.x;
RCP R2.z, R0.x;
TEX R0, fragment.texcoord[3], texture[5], 2D;
DP3_SAT R1.z, R2, c[9];
DP3_SAT R1.y, R2, c[10];
DP3_SAT R1.x, R2, c[11];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
DP3 R1.z, R0, c[8].z;
MAD R1.xy, R3.w, R3, fragment.texcoord[0];
TEX R0, fragment.texcoord[3], texture[4], 2D;
MUL R0.xyz, R0.w, R0;
MUL R2.xyz, R0, R1.z;
ADD R1.y, R1, -c[2];
ADD R0.x, R1, -c[2];
MUL R0.z, R2.w, R1.y;
MUL R0.y, R1, R3.z;
TXP R1.xyz, fragment.texcoord[2], texture[3], 2D;
MAD R0.y, R0.x, R2.w, -R0;
MAD R0.z, R0.x, R3, R0;
ADD R0.x, -R0.y, c[2];
ADD R0.y, -R0.z, c[2];
MAD R0.x, R1.w, c[1], R0;
MAD R0.y, R1.w, c[1], R0;
TEX R0, R0, texture[1], 2D;
MUL R0, R0, c[5];
MAD R1.xyz, R2, c[8].z, R1;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 79 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_PanMT]
Vector 2 [_RotMT]
Vector 3 [_PanPM]
Vector 4 [_RotPM]
Vector 5 [_Color]
Float 6 [_Parallax]
SetTexture 0 [_ParallaxMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_BumpMap] 2D
SetTexture 3 [_LightBuffer] 2D
SetTexture 4 [unity_Lightmap] 2D
SetTexture 5 [unity_LightmapInd] 2D
"ps_3_0
; 97 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c7, 0.00555556, 1.00000000, 3.14159274, 0.50000000
def c8, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c9, 0.41999999, 2.00000000, -1.00000000, 8.00000000
def c10, -0.40824828, -0.70710677, 0.57735026, 0
def c11, -0.40824831, 0.70710677, 0.57735026, 0
def c12, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3.xy
mov r0.x, c4.w
mad r0.x, r0, c7, c7.y
mul r0.y, r0.x, c7.z
mov r0.x, c4.z
mad r0.x, c0.y, r0, r0.y
mad r0.x, r0, c8, c8.y
frc r0.x, r0
mad r1.x, r0, c8.z, c8.w
sincos r0.xy, r1.x
add r0.z, v0.w, -c4.y
mul r1.x, r0.z, r0
mul r0.w, r0.z, r0.y
add r0.z, v0, -c4.x
mad r0.x, r0.z, r0, -r0.w
mad r0.z, r0, r0.y, r1.x
add r0.y, -r0.x, c4.x
add r0.w, -r0.z, c4.y
mov r0.x, c3
mad r0.x, c0.y, r0, r0.y
mov_pp r0.z, c7.w
mov r0.y, c3
mad r0.y, c0, r0, r0.w
texld r0.w, r0, s0
mul_pp r0.z, c6.x, r0
dp3_pp r0.x, v1, v1
mad_pp r1.w, r0, c6.x, -r0.z
mov r0.y, c2.w
mad r0.w, r0.y, c7.x, c7.y
mul r1.x, r0.w, c7.z
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v1
mov r0.w, c2.z
mad r0.w, c0.y, r0, r1.x
add r0.z, r0, c9.x
rcp r0.z, r0.z
mul r4.xy, r0, r0.z
mad r0.xy, r1.w, r4, v0.zwzw
mad r0.w, r0, c8.x, c8.y
frc r0.w, r0
mad r0.z, r0.w, c8, c8.w
sincos r3.xy, r0.z
add r0.y, r0, -c2
mul r0.z, r3.y, r0.y
add r0.x, r0, -c2
mad r0.z, r3.x, r0.x, -r0
mul r0.y, r3.x, r0
mad r0.y, r3, r0.x, r0
mov r0.x, c1.y
add r0.y, -r0, c2
mad r0.y, c0, r0.x, r0
add r0.z, -r0, c2.x
mov r0.x, c1
mad r0.x, c0.y, r0, r0.z
texld r0.yw, r0, s2
mad_pp r2.xy, r0.wyzw, c9.y, c9.z
mul_pp r0.xy, r2, r2
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c7.y
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
texld r0, v3, s5
dp3_pp_sat r1.z, r2, c10
dp3_pp_sat r1.y, r2, c11
dp3_pp_sat r1.x, r2, c12
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mad r1.xy, r1.w, r4, v0
dp3_pp r1.z, r0, c9.w
texld r0, v3, s4
mul_pp r0.xyz, r0.w, r0
add r0.w, r1.x, -c2.x
mul_pp r0.xyz, r0, r1.z
add r1.y, r1, -c2
mul r1.z, r1.y, r3.x
mul r1.y, r1, r3
mad r1.x, r0.w, r3, -r1.y
mad r1.y, r0.w, r3, r1.z
texldp r2.xyz, v2, s3
mov r0.w, c1.x
add r1.x, -r1, c2
mad r1.x, c0.y, r0.w, r1
add r1.y, -r1, c2
mov r0.w, c1.y
mad r1.y, c0, r0.w, r1
texld r1, r1, s1
mul r1, r1, c5
mad_pp r0.xyz, r0, c9.w, r2
mul_pp oC0.xyz, r1, r0
mov_pp oC0.w, r1
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 224 // 132 used size, 14 vars
Vector 48 [_PanMT] 4
Vector 64 [_RotMT] 4
Vector 80 [_PanPM] 4
Vector 96 [_RotPM] 4
Vector 112 [_Color] 4
Float 128 [_Parallax]
ConstBuffer "UnityPerCamera" 128 // 16 used size, 8 vars
Vector 0 [_Time] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
SetTexture 0 [_ParallaxMap] 2D 2
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_BumpMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
// 56 instructions, 3 temp regs, 0 temp arrays:
// ALU 46 float, 0 int, 0 uint
// TEX 6 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedlmpikhcpngiedlggpncngbhaimiicimpabaaaaaahmajaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcheaiaaaaeaaaaaaabnacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadcaaaaak
bcaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaagballgdlabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaanlapejea
dcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaabkiacaaaabaaaaaa
aaaaaaaaakaabaaaaaaaaaaaenaaaaahbcaabaaaaaaaaaaabcaabaaaabaaaaaa
akaabaaaaaaaaaaaaaaaaaajgcaabaaaaaaaaaaapgbobaaaabaaaaaafgiecaia
ebaaaaaaaaaaaaaaagaaaaaadiaaaaahjcaabaaaaaaaaaaaagaabaaaaaaaaaaa
fgajbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaajdcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaaegiacaaaaaaaaaaaagaaaaaadcaaaaalccaabaaa
abaaaaaabkiacaaaaaaaaaaaafaaaaaabkiacaaaabaaaaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaafaaaaaabkiacaaa
abaaaaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaibcaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaadpdcaaaaalbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaakaabaiaebaaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahmcaabaaaaaaaaaaafgafbaaa
aaaaaaaaagbebaaaacaaaaaadcaaaaajccaabaaaaaaaaaaackbabaaaacaaaaaa
bkaabaaaaaaaaaaaabeaaaaadnaknhdoaoaaaaahpcaabaaaabaaaaaalgalbaaa
aaaaaaaafgafbaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaabgblbaaaabaaaaaaaaaaaaajpcaabaaaaaaaaaaaegaobaaa
aaaaaaaabgibcaiaebaaaaaaaaaaaaaaaeaaaaaadcaaaaakbcaabaaaabaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaabeaaaaagballgdlabeaaaaaaaaaiadpdiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaanlapejeadcaaaaalbcaabaaa
abaaaaaackiacaaaaaaaaaaaaeaaaaaabkiacaaaabaaaaaaaaaaaaaaakaabaaa
abaaaaaaenaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaadcaaaaak
kcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaaacaaaaaaagaibaiaebaaaaaa
abaaaaaadcaaaaajfcaabaaaaaaaaaaaagacbaaaaaaaaaaaagaabaaaacaaaaaa
fgahbaaaabaaaaaaaaaaaaajfcaabaaaaaaaaaaaagacbaiaebaaaaaaaaaaaaaa
fgifcaaaaaaaaaaaaeaaaaaadcaaaaalmcaabaaaabaaaaaafgifcaaaaaaaaaaa
adaaaaaafgifcaaaabaaaaaaaaaaaaaaagaibaaaaaaaaaaaaaaaaaajdcaabaaa
aaaaaaaangafbaiaebaaaaaaaaaaaaaaagiacaaaaaaaaaaaaeaaaaaadcaaaaal
dcaabaaaabaaaaaaagiacaaaaaaaaaaaadaaaaaafgifcaaaabaaaaaaaaaaaaaa
egaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaangafbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaaapcaaaakbcaabaaa
acaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaaaaaaaaa
bacaaaakccaabaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
egacbaaaaaaaaaaabacaaaakecaabaaaacaaaaaaaceaaaaaolafnblopdaedflp
dkmnbddpaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
aeaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaa
aaaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

}
	}

#LINE 52
 
}

FallBack "Animated/Built-in/Bumped Diffuse"
}
