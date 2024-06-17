1 - Alterar o arquivo  .env.example para .env

2 - altere as configurações para acesso a base de dados mysql
   
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=sail
DB_PASSWORD=password

3 - rodar este comando docker a baixo para atualizar as dependencias do laravel 

docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v "$(pwd):/var/www/html" \
    -w /var/www/html \
    laravelsail/php82-composer:latest \
    composer install --ignore-platform-reqs

4 - Gere a chave da aplicação
./vendor/bin/sail php artisan key:generate    
	
5 - Executem este comando para criar seu banco de dados 

./vendor/bin/sail php artisan migrate	


************************************************************************************

Para finalizar o arquivo de Atualização 

1 - alterar a rota update passando o parametro do ID 
Route::put('/suporte/update/{suporte}',[SuporteController::class,'update'])->name('suporte.update');

2 - editar Alterar.blade.php
    {{-- Linha alterada no formulario para passar os dados do formulario utilizando o ID correto--}}
    <form action="{{route('suporte.update',['suporte' => $item->id])}}" method="POST">

3 - alterar o listar.blade.php
alterar listar para mostrar status do atendimento	no botão
	<td><a href="{{route('suporte.atendimento',['suporte'=>$item->id])}}" class="btn btn-primary" role="button">{{$item->atendimento}}</a></td>   

4 - Alterar o SuporteController

   public function update(Request $request, Suporte $suporte)
   {
    //dd($request);
    $suporte->update([
        'nome' =>$request->nome,
        'email' =>$request->email,
        'atendimento' =>$request->atendimento,
        'solucao' =>$request->solucao]);
    return redirect()->route('suporte.listar');
   }



************************************************************************************

Para fazer o medoto de delete:

1 - incluir no botão de delete no listar.blade.php
<td><a href="{{route('suporte.delete',['suporte'=>$item->id])}}" class="btn btn-danger" role="button">Deletar</a></td>  

2 - criar a rota do delete 
Route::get('/suporte/delete/{suporte}',[SuporteController::class,'delete'])->name('suporte.delete');

3 - criar o metodo de delete no SuporteController

   public function delete(Suporte $suporte)
   {
    $suporte->delete();
    return redirect()->route('suporte.listar');
   }

   