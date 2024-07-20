import Pkg; Pkg.add("PackageCompiler"); 
Pkg.add(url="https://github.com/julia-vscode/LanguageServer.jl", rev="master"); 
Pkg.update();
using PackageCompiler; create_sysimage(:LanguageServer, sysimage_path=dirname(Pkg.Types.Context().env.project_file) * "/languageserver.so")

