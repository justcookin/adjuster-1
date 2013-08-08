package MyWeb::App;
use Dancer;
use Text::Aspell;
#set serializer => 'XML';
set serializer => 'Dumper'; #un-comment this for json format responses

get '/' => sub{
    return {message => "First rest Web Service with Perl and Dancer"};
};

get '/spellcheck/:word' => sub {
    my $word = params->{word};
	my $speller = Text::Aspell->new;
    $speller->set_option('sug-mode','fast');
  if ($speller->check( $word )) {
    return {response => "$word is the correct spelling"};
  } else {
    my @suggestions = $speller->suggest( $word );
    return {response => \@suggestions };   
  }
  
};

dance;






=cut
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
#    template 'index';
	return (message => "Hey now");
};

true;
