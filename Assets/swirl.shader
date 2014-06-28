Shader "Custom/Swirl"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
	}

	SubShader
	{
		Tags
		{ 
			"Queue"="Transparent" 
			"IgnoreProjector"="True" 
			"RenderType"="Transparent" 
			"PreviewType"="Plane"
			"CanUseSpriteAtlas"="True"
		}

		Cull Off
		Lighting Off
		ZWrite Off
		Fog { Mode Off }
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile DUMMY PIXELSNAP_ON
			#include "UnityCG.cginc"
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
			};
			
			fixed4 _Color;
			fixed4 _BaseColor;

			v2f vert(appdata_t IN)
			{
				v2f OUT;
				float4 hey = IN.vertex;
				OUT.vertex = mul(UNITY_MATRIX_MVP, hey);
				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				
				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}

			sampler2D _MainTex;

			fixed4 frag(v2f IN) : COLOR
			{	
				
					// Rotate that stuff
					fixed2 newPoint;
					fixed2 newPoint2;
					fixed2 newPoint3;

					float theta = _Time.x * pow((IN.texcoord.x * 2 - 1),2.0);
					newPoint = ((cos(theta) * (IN.texcoord.x * 2 - 1) + sin(theta) * (IN.texcoord.y * 2 - 1) + 1)/2,
			  				     (-sin(theta) * (IN.texcoord.x * 2 - 1) + cos(theta) * (IN.texcoord.y * 2 - 1) + 1)/2);
			  		if (newPoint.x > .2 && newPoint.x < .4){
			  			newPoint.x += .7;
			  		}
			  		else if (newPoint.x > .6 && newPoint.x < .8){
			  			newPoint.x -= .2;
			  		}

			  		theta = _Time.x * pow((IN.texcoord.x * 2 - 1),2.0);
					newPoint2 = ((cos(theta) * (IN.texcoord.x * 2 - 1) + sin(theta) * (IN.texcoord.y * 2 - 1) + 1)/2,
			  				     (-sin(theta) * (IN.texcoord.x * 2 - 1) + cos(theta) * (IN.texcoord.y * 2 - 1) + 1)/2);
			  		if (sin(newPoint2.x) < .2){
			  			newPoint2 = dot(newPoint, IN.texcoord);
			  		}
			  		else {
			  			newPoint2.x = dot(newPoint.x, IN.texcoord.y);
			  			newPoint2.y = -dot(newPoint.y, IN.texcoord.x);
			  		}

			  		theta = _Time.x * pow((IN.texcoord.x * 2 - 1),2.0);
					newPoint3 = ((cos(theta) * (IN.texcoord.x * 1.5 - 1) + sin(theta) * (IN.texcoord.y * 1.5 - 1) + 1)/2,
			  				     (-sin(theta) * (IN.texcoord.x * 1.5 - 1) + cos(theta) * (IN.texcoord.y * 1.5 - 1) + 1)/2);


				  	return tex2D(_MainTex, lerp(IN.texcoord,newPoint,_Time.x)) + 
				  	tex2D(_MainTex, lerp(IN.texcoord,newPoint2,_Time.x)) -
				  	tex2D(_MainTex, lerp(IN.texcoord,newPoint3,_Time.x));

					
				
			
				
			}
		ENDCG
		}
	}
}