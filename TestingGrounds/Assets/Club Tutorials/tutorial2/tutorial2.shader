//useful links
//http://wiki.unity3d.com/index.php?title=Shader_Code
//https://docs.unity3d.com/Manual/SL-ShaderPrograms.html
//https://docs.unity3d.com/Manual/SL-DataTypesAndPrecision.html

//notes: a data-type{number} usually implies that its some kind of tuple or arrray of that size of those elements
//  floats are 32 bit 
// fixed are 11
// half is a 16 bt

shader "Tutorial2/example" // this line does 2 things, declares that everything below is a shader, and where the shader will be, 
{                          // when choosing a shader for the material this will appear in the folder tutorial2 with the name example

    Properties  //This is the block where everything we want to input from the editor will go, 
    {
        _MainTex ("main texture" , 2D ) = "white"{} // This means we will have a spot for a 2D texture, the default color
                                                           // if none is white

        _Tint ("color tint" , color ) = ( 0, 0, 0, 0) // this will be the color we tint the texture by

    }
    Subshader // if we needed to have multiple versions of a shader to switch to depending on hardware, we need to detail
    {         // multiple versions of it ahead of time, for  this exercise its pretty basic so a single one is fine

        pass  // a single draw on a layer essentially, if we need to draw the same image or some derivative multiple times this 
        {     // would come into play as we would define another pass
            
            CGPROGRAM // this declares that we want this to be a cg snippet, essentially yelling that this is the actual code
            

            // the pragma preprocessor essentially tells the compiler before it actually looks at the code, these tell the renderer
            // that there will be a vertex function called vert, and a fragment function called frag. This is something built into 
            // unity at a base level, so as long we don't really do much we are fine here.
            #pragma vertex vert 
            #pragma fragment frag

            // "UnityCG.cginc" is the unity cg include file. There are a lot of helpful functions I will note when we use them, 
            // though they mostly are just time savers. you can view them on your computer at this directory
            //<program_files>/Unity/Editor/Data/CGIncludes/
            #include "UnityCG.cginc"

            // This is the appdata given directly from renderer. UnityCG.cginc has predefined appdata structs we can use, but
            // for now we can and will define our own
            struct appdata
            {
                float4 vertex : POSITION; //where the model is in model space usually given via float3 or float4
                float2 uv : TEXCOORD0; // the first uv coordinate
            };


            //This is the struct that gets passed to the fragment function from the vertex function, It doesn't really look
            // any different then appdata, but if we want conditional graphics effects or to modify where the object really is.
            //v2f means vertex to fragment (at least thats how I see it)
            struct v2f
            {
                float2 uv: TEXCOORD0; // pretty much the same thing as above 
                float4 vertex: SV_POSITION; // the position of the object after altered to projection space
            };


            // we need to bring in the variables from properties, with the same name we declared
            
            sampler2D _MainTex; // sampler2D = texture

            float4 _MainTex_ST , _Tint;
            // _Tint is a float 4 for color RGBA (A is transparency, and we don't really use it now)
            // _MainTex_ST is for texture Scale and texture Translation  (S for scale, T for translation)

            v2f vert(appdata v) //the vertex function, this essential transforms our rendering of the object from world to clip (I will update this when I have a better understanding)
            {
                // instatiating our v
                v2f o; 

                // this takes our position and moves it into clip position, this function is a part of UnityCG.
                o.vertex=UnityObjectToClipPos(v.vertex);
                // Transforms 2D UV by scale/bias property, bend the texture to be correct for the model
                o.uv=TRANSFORM_TEX(v.uv,_MainTex);
                return o;

            };

            // This is the function that returns the color for the objects
            float4 frag(v2f o): SV_Target
            {
                float4 col=tex2D(_MainTex,o.uv); // this captures the colors of the texture and how it wraps around the object, we store it into a float4 which whill be our color
                col+=_Tint; // we then add our tint
                return col; // and finally return the color which will be applied to the position with the colors we have dictated
            }

            ENDCG //end the computer graphics snippey
        }

    }
    FallBack "diffuse" // in case all our subshaders fail, we default to this. There are multiple different types of fallbacks, but for now we will just use diffuse.
}