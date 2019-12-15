// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
		Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" "DisableBatching" = "True" }

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata input)
            {
                v2f o;

				float4 pos = input.vertex;
				float4 pos_M = mul(UNITY_MATRIX_M, pos);
				float4 pos_V = mul(UNITY_MATRIX_V, pos) + float4(pos.x, pos.z, 0, 0);
				float4 pos_P = mul(UNITY_MATRIX_P, pos_V);

				/*float4 originInViewSpace = mul(UNITY_MATRIX_MV, float4(0, 0, 0, 1));
				float4 vertInViewSpace = originInViewSpace + float4(pos.x, pos.z, 0, 0);
				pos = mul(UNITY_MATRIX_P, originInViewSpace);*/

				//float3 vpos = mul((float3x3)unity_ObjectToWorld, input.vertex.xyz);
				//float4 worldCoord = float4(unity_ObjectToWorld._m03, unity_ObjectToWorld._m13, unity_ObjectToWorld._m23, 1);
				//float4 viewPos = mul(UNITY_MATRIX_V, worldCoord) + float4(vpos, 0);
				//float4 outPos = mul(UNITY_MATRIX_P, viewPos);
				 
				float3 vpos = mul((float3x3)unity_ObjectToWorld, input.vertex);
				float4 worldCoord = float4(unity_ObjectToWorld._m03, unity_ObjectToWorld._m13, unity_ObjectToWorld._m23, 1);
				float4 viewPos = mul(UNITY_MATRIX_V, worldCoord) + float4(vpos, 0);
				float4 outPos = mul(UNITY_MATRIX_P, viewPos);

				o.vertex = outPos;
				
				//o.vertex = UnityObjectToClipPos(input.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4(1,1,1,1);
            }
            ENDCG
        }
    }
}
