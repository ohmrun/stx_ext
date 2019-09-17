package stx.core.pack;

import stx.core.head.data.Embed as TEmbed;
import stx.core.body.Embeds;

@:forward abstract Embed<T>(TEmbed<T>) from TEmbed<T>{
  public function new(){
    this = Embeds.embed();
  }
}
