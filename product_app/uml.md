 UML: Diagrama de Classes
O diagrama de classes ´e um dos principais elementos da UML (Unified Modeling Language)
e tem como objetivo representar a estrutura est´atica de um sistema.
Ele descreve:
• Classes: Moldes para os objetos.
• Atributos: Caracter´ısticas ou dados.
• M´etodos: Comportamentos ou fun¸c˜oes.
• Relacionamentos: Como as classes interagem entre si.
Esse tipo de diagrama ´e fundamental no projeto de software orientado a objetos, pois permite
visualizar a organiza¸c˜ao do sistema antes mesmo da implementa¸c˜ao.
O diagrama de classes representa a estrutura do sistema, mostrando como os elementos
est˜ao organizados e se relacionam.
1.1 Elementos Fundamentais
Um diagrama de classes ´e composto por trˆes componentes essenciais dentro de sua representa¸c˜ao
gr´afica.
Classe
Uma classe ´e representada visualmente por um retˆangulo dividido em trˆes compartimentos:
1. Superior: Nome da classe.
2. Central: Atributos (estado).
3. Inferior: M´etodos (comportamento).
Atributos
Os atributos representam as propriedades da classe. Em Dart, a tipagem ´e colocada ap´os o
nome (ou inferida).
Exemplo em UML:
- nome: String
- preco: double
M´etodos
Os m´etodos representam as a¸c˜oes que a classe pode executar.
Exemplo em UML:
+ calcularPreco(): double
Desenvolvimento para Dispositivos M´oveis II
UML - Aula 1 Jefferson Rodrigo Speck
1.2 Modificadores de Acesso (Visibilidade)
Na UML, os modificadores definem o n´ıvel de acesso. No Dart, a visibilidade ´e tratada de forma
simplificada (P´ublico ou Privado de Biblioteca):
• + (P´ublico): Atributos e m´etodos acess´ıveis de qualquer lugar. (Padr˜ao no Dart).
• - (Privado): No Dart, representado pelo prefixo (ex: preco). Indica que o membro ´e
privado `a biblioteca/arquivo.
• # (Protegido): Membros acess´ıveis pela pr´opria classe e suas subclasses.
1.3 Exemplo de Implementa¸c˜ao em Dart
Abaixo, veja como os elementos do diagrama se traduzem diretamente para o c´odigo:
1 class Produto {
2 String nome; // Atributo Publico (+)
3 double _preco; // Atributo Privado (-)
4
5 Produto(this.nome, this._preco);
6
7 // Metodo Publico (+)
8 double calcularPreco() {
9 return _preco;
10 }
11 }
1.4 Classes Abstratas
Uma classe abstrata ´e um molde que n˜ao pode ser instanciado diretamente. Sua fun¸c˜ao
principal ´e servir como base (superclasse) para outras classes, definindo comportamentos comuns.
Ela pode conter:
• M´etodos Abstratos: Apenas a assinatura, sem corpo (implementa¸c˜ao obrigat´oria nas
subclasses).
• M´etodos Concretos: M´etodos com implementa¸c˜ao l´ogica j´a definida.
Classes abstratas definem um contrato t´ecnico: elas garantem que todas as subclasses
possuam determinados m´etodos, mesmo que cada uma os execute de forma diferente.
Exemplo em Dart
No Dart, n˜ao usamos a palavra abstract antes do m´etodo; apenas definimos a assinatura
terminando com ponto e v´ırgula.
1 abstract class Produto {
2 String titulo;
3 double preco;
4
5 Produto(this.titulo, this.preco);
6
7 // Metodo abstrato (sem corpo)
8 double calcularDesconto();
9
10 // Metodo concreto
11 double get precoFinal => preco;
12 }
Desenvolvimento para Dispositivos M´oveis II
UML - Aula 1 Jefferson Rodrigo Speck
13
14 class Eletronico extends Produto {
15 Eletronico(String titulo, double preco) : super(titulo, preco);
16
17 @override
18 double calcularDesconto() {
19 return preco * 0.9; // 10% de desconto
20 }
21 }
1.5 Relacionamentos entre Classes
Os relacionamentos s˜ao as linhas que conectam as classes no diagrama, indicando como os objetos
interagem e dependem uns dos outros.
Associac¸˜ao
Representa uma rela¸c˜ao estrutural simples onde uma classe ”usa”ou ”conhece”a outra. ´E a
forma mais comum de conex˜ao.
Agregac¸˜ao (Relac¸˜ao ”Tem-um”)
Indica que uma classe ´e composta por outras, mas as partes podem existir de forma independente.
Exemplo: Um Carrinho possui Produtos, mas o Produto existe sem o Carrinho.
Composic¸˜ao (Dependˆencia Forte)
´E uma varia¸c˜ao da agrega¸c˜ao onde a existˆencia da ”parte”depende estritamente do ”todo”. Se
a classe principal for destru´ıda, as associadas tamb´em ser˜ao. Exemplo: Uma P´agina n˜ao existe
sem um Livro.
Heranc¸a / Generalizac¸˜ao (Relac¸˜ao ”´E-um”)
Permite que uma classe (subclasse) herde todos os atributos e m´etodos de outra (superclasse),
promovendo o reuso de c´odigo.
Dica de Ouro: A Heranc¸a representa uma rela¸c˜ao de identidade (Um Carro ´e um
Ve´ıculo), enquanto a Associac¸˜ao representa uma rela¸c˜ao de posse ou uso (Um Carro
usa um Motor).
1.6 Exemplo de Diagrama de Classes
A seguir, um exemplo utilizando uma estrutura simples de produtos:
• Product (abstrata)
• Electronics
• Category
Desenvolvimento para Dispositivos M´oveis II
UML - Aula 1 Jefferson Rodrigo Speck
Figura 1: Diagrama de Classe.
Descric¸˜ao do Modelo
Neste cen´ario de modelagem:
• Product (Produto) funciona como uma classe abstrata, definindo a interface comum.
• Electronics (Eletrˆonico) ´e uma especializac¸˜ao que herda e implementa a l´ogica de
Product.
• Product mant´em uma associac¸˜ao com Category (Categoria), indicando que todo produto
pertence a uma classifica¸c˜ao no sistema.
1.7 Fluxo Conceitual
O processo de modelagem e implementa¸c˜ao segue esta progress˜ao l´ogica:
1. Abstrac¸˜ao: O sistema define uma base gen´erica (classe abstrata) para garantir padro-
niza¸c˜ao.
2. Especializac¸˜ao: Subclasses espec´ıficas detalham comportamentos particulares (sobres-
crita de m´etodos).
3. Instanciac¸˜ao: Objetos concretos s˜ao criados a partir das subclasses para uso real na
mem´oria.
4. Conectividade: Os relacionamentos estabelecem como essas partes colaboram para exe-
cutar as regras de neg´ocio.
1.8 Boas Pr´aticas de Modelagem
Para garantir que o diagrama reflita um software de alta qualidade (seguindo princ´ıpios como
SOLID):
• Coes˜ao: Evite ”Classes Deus”(God Objects) que acumulam responsabilidades excessivas.
• DRY (Don’t Repeat Yourself): Utilize a abstra¸c˜ao e heran¸ca para evitar duplica¸c˜ao
de l´ogica.
Desenvolvimento para Dispositivos M´oveis II
UML - Aula 1 Jefferson Rodrigo Speck
• Baixo Acoplamento: Minimize as dependˆencias diretas para que altera¸c˜oes em uma
classe n˜ao quebrem o sistema inteiro.
• Semˆantica de Relacionamento: Use corretamente as setas (heran¸ca vs. associa¸c˜ao)
para n˜ao confundir a arquitetura.
1.9 S´ıntese Conceitual
Em resumo, os pilares do Diagrama de Classes s˜ao:
• Estrutura: Representa o esqueleto est´atico do sistema.
• Componentes: Classes encapsulam atributos (dados) e m´etodos (comportamento).
• Contratos: Classes abstratas for¸cam a padroniza¸c˜ao das subclasses.
• Reuso: A heran¸ca permite estender funcionalidades de forma organizada.
• Interac¸˜ao: Os relacionamentos definem a hierarquia e a posse entre os objetos.
Com essa fundamenta¸c˜ao, o desenvolvedor torna-se capaz de projetar sistemas robustos em
linguagens como Dart, antecipando problemas de l´ogica e facilitando a manuten¸c˜ao futura do
c´odigo.
1.9.1 Relacionamentos e Setas
As conex˜oes entre classes definem o acoplamento do sistema:
S´ımbolo Nome Significado em Dart
−→ Associa¸c˜ao Uma classe possui uma instˆancia de
outra (final VM vm;).
−− Realiza¸c˜ao Implementa¸c˜ao de um contrato ou
classe abstrata (implements).
←− Heran¸ca Extens˜ao de funcionalidades de uma
superclasse (extends).
♢−→ Agrega¸c˜ao Rela¸c˜ao ”tem um”onde o objeto fi-
lho existe sem o pai.
−→ Composi¸c˜ao Rela¸c˜ao de dependˆencia vital; o filho
morre com o pai.
1.10 Camadas do Modelo MVVM
1.10.1 A Camada View (Widget)
Representa os componentes visuais. Em UML, usamos o estere´otipo <<Widget>>. Ela observa
a ViewModel e reage a mudan¸cas de estado.
1.10.2 A Camada ViewModel (State Management)
´E o c´erebro da aplica¸c˜ao. Ela converte dados brutos do Model em informa¸c˜oes prontas para
exibi¸c˜ao.
• Estado: Mantido em vari´aveis privadas (-).
• Ac¸˜oes: M´etodos p´ublicos (+) que a View dispara.
Desenvolvimento para Dispositivos M´oveis II
UML - Aula 1 Jefferson Rodrigo Speck
1.10.3 A Camada Model (Data & Business)
Composta por Reposit´orios e Entidades. ´E aqui que o Polimorfismo brilha atrav´es do uso de
interfaces.
1.11 Exemplo Pr´atico: Reposit´orio Abstrato
Abaixo, a implementa¸c˜ao de um contrato de dados usando abstra¸c˜ao para garantir baixo aco-
plamento:
1 // Contrato (Interface) - Linha tracejada no UML
2 abstract class IUserRepository {
3 Future<String> getName(int id);
4 }
5
6 // Implementao Concreta - Seta tracejada (Realizao)
7 class UserRepositoryImpl implements IUserRepository {
8 @override
9 Future<String> getName(int id) async {
10 return "Usurio Dart";
11 }
12 }
13
14 // ViewModel - Agregao (Possui um repositrio via construtor)
15 class UserViewModel {
16 final IUserRepository _repo; // - repo
17
18 UserViewModel(this._repo);
19
20 void carregar() => _repo.getName(1);
21 }
1.12 S´ıntese Conceitual
• Classes Abstratas: Definem o contrato (o ”quˆe”o sistema faz).
• Interfaces (Implements): Permitem trocar a fonte de dados (API vs Mock) sem mudar
a UI.
• Encapsulamento: Protege o estado da tela contra altera¸c˜oes externas indevidas.
Desenvolvimento para Dispositivos M´oveis II
UML - Aula 1 Jefferson Rodrigo Speck
Figura 2: Exemplo de UML MVVM
Sobre este material
Este material foi desenvolvido por:
Jefferson Rodrigo Speck
Professor e pesquisador na ´area de Computa¸c˜ao.
O conte´udo foi produzido com finalidade educacional e pode ser utilizado como material de
apoio em disciplinas relacionadas `a ´area.
Vers˜ao compilada em 15 de abril de 2026