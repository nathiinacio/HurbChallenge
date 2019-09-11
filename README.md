# Hurb Challenge 
> Desafio Alpha - Processo Seletivo Hurb

## Sobre

### O que a aplicação faz?

Criei um app para iOS utilizando da linguagem Swift  que consome o JSON exposto pela API de busca e apresenta as informações em cards em uma UICollectionView. Cada card apresenta um hotel ou pacote com: nome, preço, cidade, estado, uma foto, três amenidades (em caso de hotel), três atributos (em caso de pacote) e também sua categoria por estrelas caso ele seja um hotel. Todos os cards possuem um botão de "favorito" para o usuário ter uma experiencia personalizada.

Na aba do feed divide-se a apresentaçao dos hotéis e pacotes através de um, para facilitar o entedimento do que está sendo listado e/ou pesquisado pelo usuário. Além disso, tem-se uma barra de busca onde é possivel fazer uma busca rápida por nomes de hotéis ou pacotes. 

![](/Users/nathaliainacio/Desktop/feefScreen.png)

Além da aba do feed, foi implementada uma aba de perfil que acessa os favoritos do usuário. Isso é possivel pois logo quando abre-se o app, a primeira interação é criar uma conta com suas informações. Portanto, tem-se o controle dos usuários e  consequentemente o que cada um "guardou" como favorito para ter acesso. O banco de dados escolhido para essa implementação foi o Firebase.

![](/Users/nathaliainacio/Desktop/profileScreen.png)

Telas de Login e Criar conta:

![](/Users/nathaliainacio/Desktop/LoginAndCreateNewAccount.png)


### O que está faltando?

Existe uma tela de filtro que é aberta quando clica-se no botão de filtro ao lado da barra de busca. Seu objetivo era filtrar os hotéis pela categoria de estrelas que o usuário gostaria de ver. Portanto, algo estava dando errado na implementação então o código está parcialmente comentado. Com isso o feed não está ordenado pelas estrelas pois o objetivo era ordena-las opcionalmente através dessa busca mais detalhada.

![](/Users/nathaliainacio/Desktop/filterScreen.png)


## UI | UX

Toda a identidade visual do app foi inspirada em apps de busca e o próprio site e app da Hurb. Utilizando portanto, uma paleta de cores inspirada para lembrar a da Hotel Urbano.

O app foi testado com usuários próximos e voluntários para testar o fluxo de telas e a clareza dos botões e outros clicaveis.


## Instalação

Para instalar o projeto deve-se abrir o terminal e degitar o seguintes comandos:

```
git clone <pasta que deseja clonar o repositório>
```
Depois, para clonar o repositório

```
git clone <url do repositório>
```

Depois, para instalar os pods referentes ao banco de dados:

```
pod install
```

E finalmente, para abrir o projeto deve-se abrir o .xcworkspace que está contido na pasta. 


## Aparelhos para Rodar a Aplicação

O app foi desenvolvido para rodar em IPhones com Deployment Target 12.4. Pode-se rodar em um simulador do Xcode ou em algum aparelho próprio. 

Além disso, o app possui Auto Layout (Constraints) para aparelhos desde do IPhone Xs Max até o IPhone 8, só não cobrindo IPhones SE e 4, já que estes, não possuem Deployment Target compatíveis.


## Utilizou-se

* [Xcode](https://developer.apple.com/xcode/) - Plataforma de desenvolvimento do app 
* [GitHub](https://github.com) - Utilizado como repositório
* [Firebase](https://firebase.google.com) - Utilizado como banco de dados 












