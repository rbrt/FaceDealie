Shader "Custom/ShowVertices"
{
	Properties
	{
		_Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Tags
		{
			"Queue"="Geometry"
			"RenderType"="Opaque"
		}

		Pass
		{
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				float2 texcoord2: TEXCOORD1;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				half2 point : TEXCOORD1;
			};

			fixed4 _Color;
			fixed4 _BaseColor;

			v2f vert(appdata_t IN)
			{
				v2f OUT;
				float4 hey = IN.vertex;
				OUT.vertex = mul(UNITY_MATRIX_MVP, hey);
				OUT.texcoord = IN.texcoord;

				half2 temp = OUT.vertex;

				OUT.point = temp;

				OUT.color = IN.color * _Color;

				return OUT;
			}

			sampler2D _MainTex;
			fixed4 frag(v2f IN) : COLOR
			{

				if (_Color.a == 0){
					if (fmod(_Time.y, 2.5) > 1.25 && fmod(_Time.y, 2.5) < 2.4){
						discard;
					}
					else {
						if (IN.point.x < 0 && IN.point.x > sin(IN.point.y) * .2 * abs(sin(IN.point.y) * 75)){
							return fixed4(0,1,0,1);
						}
						else if (IN.point.x > 0){
							return fixed4(0,1,0,1);
						}
						else{
							discard;
						}
					}
				}
				else{
					if (fmod(_Time.y, 2.5) > 1.25 && fmod(_Time.y, 2.5) < 2.4){

			  		}
			  		else{
			  			if (IN.point.x < 0){	
				  			return tex2D(_MainTex, IN.texcoord);
				  		}
				  		else{
				  			discard;
				  		}
			  		}
			  	}


			}
		ENDCG
		}
	}
}
