# contains numerous variables for common ascii emojis

function emote () {
    declare -A emoteList=(
        [confused]='¯\_(⊙︿⊙)_/¯'
        [crying]='ಥ_ಥ'
        [cute_bear]='ʕ•ᴥ•ʔ'
        [cute_face]='(｡◕‿◕｡)'
        [excited]='☜(⌒▽⌒)☞'
        [fisticuffs]='ლ(｀ー´ლ)'
        [tableflip]='(╯°□°）╯︵ ┻━┻'
        [personflip]='(╯°Д°）╯︵/(.□ . \)\'
        [table_personflip]='ノ┬─┬ノ ︵ ( \o°o)\'
        [tableunflip]='┬──┬◡ﾉ(° -°ﾉ)'
        [flipalltables]='┻━┻︵ヽ(`Д´)ﾉ︵ ┻━┻'
        [happy]='ヽ(´▽`)/'
        [innocent]='ʘ‿ʘ'
        [kirby]='⊂(◉‿◉)つ'
        [lennyface]='( ͡° ͜ʖ ͡°)'
        [lion]='°‿‿°'
        [flexing]='ᕙ(⇀‸↼‶)ᕗ'
        [perky]='(`・ω・´)'
        [piggy]='( ́・ω・`)'
        [shrug]='¯\_(ツ)_/¯'
        [shrugwtf]='¯\(°_o)/¯'
        [point_right]='(☞ﾟヮﾟ)☞'
        [point_left]='☜(ﾟヮﾟ☜)'
        [magic]='╰(•̀ 3 •́)━☆ﾟ.*･｡ﾟ'
        [shades]='(•_•)
( •_•)>⌐■-■
(⌐■_■)'
        [disapprove]='ಠ_ಠ'
        [lookofdisapproval]='ಠ_ಠ'
        [lod]='ಠ_ಠ'
        [wink]='ಠ‿↼'
        [facepalm]='(－‸ლ)'
        [haters_gonna_hate]='ᕕ( ᐛ )ᕗ'
        [salute]='(￣^￣)ゞ'
        [devious]='ಠ‿ಠ'
        [wat]='O_o'
        [why]='щ（ﾟДﾟщ）'
        [deargodwhy]='щ（ﾟДﾟщ）'
        [dead]='x_x'
        [bandaid]='(::[ ]::)'
        [yay]='\o/'
        [bear]='ʕ •ᴥ•ʔ'
        [argh]='ヽ(`Д´)ﾉ'
        [idunno]="┐('～\`；)┌"
        [amazed]='( ﾟдﾟ)'
    );
    
    if [[ "$emoteList[$1]" ]]; then
        echo $emoteList[$1];
    else
        echo "Unknown Emote. You can use one of the following:";
        for key val in "${(@kv)emoteList}"; do
            echo -n "$key, ";
        done;
        echo ""
    fi
}
