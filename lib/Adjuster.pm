package Adjuster;
use strict;
use warnings;
use Dancer;
use Text::Aspell;
use File::Basename;
#use LWP::Simple qw( getprint );
use Image::Magick;
set serializer => 'XML';
#set serializer => 'Dumper'; #un-comment this for json format responses

get '/' => sub{
    return {message => "First rest Web Service with Perl and Dancer"};
};

get '/adjust-image/:height/:width' => sub {
    my $url = params->{url};
    my $height = params->{height};
    my $width = params->{width};
    my $image = Image::Magick->new();
    my $x = $image->Read($url);
    $image->Resize(height => $height, width => $width);
    my $name = basename($url);
    $x = $image->Write("/vagrant/Adjuster/public/images/$name");
      warn "$x" if "$x";
#    return $x->Display();
   # print $image->Get('format');
    redirect "/images/" . $name;
};

get '/spellcheck/:word' => sub {
    my $word = params->{word};
        my $speller = Text::Aspell->new;
    $speller->set_option('sug-mode','fast');
  if ($speller->check( $word )) {
    {  { SpellingCorrect => "true" ,
	 Word => $word, }
    };
  } else {
    my @suggestions = $speller->suggest( $word );
    { SpellingCorrect => 'false',
      Suggestions => { Suggestion => \@suggestions }
    };
  }

};

dance;
