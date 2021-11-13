workspace "MIMO"

    configurations
    {
        "Debug32",
        "Release32",
        "Dist32",
        "Debug64",
        "Release64",
        "Dist64"
    }

    filter "configurations:*32"
        architecture "x86"

    filter "configurations:*64"
        architecture "x86_64"
    
    startproject "Sandbox"

    

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}

project "Lib"
    location "Lib"
    kind "StaticLib"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.hpp",
        "%{prj.name}/src/**.inl",
        "%{prj.name}/src/**.cpp",
        "%{prj.name}/src/**.glsl",
        "%{prj.name}/src/**.hlsl"
    }

    includedirs
    {
    }

    links
    {
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "on"
        systemversion "latest"

        defines
        {
            "MM_PLATFORM_MSDOS"
        }

        links
        {
        }
    
    filter "configurations:Debug*"
        defines "MM_DEBUG"
        symbols "on"
    
    filter "configurations:Release*"
        defines "MM_RELEASE"
        optimize "on"    
    
    filter "configurations:Dist*"
        defines "MM_DIST"
        optimize "on"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.hpp",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "MIMO/src",
        "MIMO/vendor"
    }

    links
    {
        "MIMO"
    }
    
    filter "system:windows"
        systemversion "latest"

        defines
        {
            "MM_PLATFORM_WINDOWS"
        }
    
    filter "configurations:Debug*"
        defines "MM_DEBUG"
        symbols "on"
    
    filter "configurations:Release*"
        defines "MM_RELEASE"
        optimize "on"    
    
    filter "configurations:Dist*"
        defines "MM_DIST"
        optimize "on"