Shader "Custom/Diffuse" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
}

SubShader {
	Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
	LOD 200

CGPROGRAM
#pragma surface surf Lambert alpha

sampler2D _MainTex;
fixed4 _Color;

struct Input {
	float2 uv_MainTex;
	float4 screenPos;
};

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
	o.Albedo = c.rgb;
	int pivot = 300;
	
	if (_Color.a != 0){
		if (IN.screenPos.z < pivot){
			o.Alpha = c.a;
		}
		else{
			o.Alpha = 0;
		}
		o.Alpha = c.a;
	}
	else{
		if (IN.screenPos.z > pivot){
			o.Albedo = fixed3(0,255,0);
			o.Alpha = 1;
		}
		else{
			o.Alpha = 0;
		}
	}
}
ENDCG
}

Fallback "Transparent/VertexLit"
}
