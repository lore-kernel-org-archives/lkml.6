Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBK6NQLKQKGQEQYULWUA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520477868; cv=pass;
        d=google.com; s=arc-20160816;
        b=lXJdPClagpz8oxbLDQy4IOf7vGpp0rXOrc4QG8co3QTJpKd4VTBF+Jg81dgumNgTKn
         4vksZFZ5nIk1U56XD4/0zhv+IjfQTRe3NLPRseVkJuuJ5vxQS+f053gYHL3ox9vmzfcV
         eRxe3xlGynNReVYup25CX13ilR6MmYRRLX/CEDK3sNtydzPoSzwp517zNmJTxp//jksU
         RIT9348Yn9cY3uVgQUttbZgHFfP7/0pm52xZBgH406ooFeClV+HdFxnRgV1+f0ARpZsL
         Rb33uV7Vkxhs6lA9pGbghiURmHfsYCXZ1sGdSa1VBrKlw7H1Ld1etkwTzaZ0KxG+yDx0
         s3Cw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=jgc7HlAMLRdSwmXOHA6qdSgUvxaLzRPDKFYGHRZ3Dv4=;
        b=bgI7w/kEcXcBuN84jIpiuh6m6E/u09fCV4y9B6tNc99hvkfuCuajPkIw7QGTt24FHT
         vqKdCDuoLT8Fs55WVz6Bx6f4KCiOXMlKP9GkfKtym7dMxPtMRgP+ddybHIKg4tudERvj
         1mGyeqlPe4GGYsnBTU4PctOpOCqHtqqXmaNG88UsCnIgV03x1MYISwq3LkdXT9KH1hs9
         qdFWIcA78mAOtOO+oNi2woexy4OWDtsJJYHZJHynIrKiWUoYDPoU4LcGLwPdeq/KHFhv
         pzWpogKcc8LyWzaXvd3Q35y2mfeb1L6hJFRbvouUVlFe2/05LMNJi6/KVw2/U7oLcpmH
         LYFg==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=HHjjyBER;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EwUPma9s;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbk6nqlkqkgqeqyulwua@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBK6NQLKQKGQEQYULWUA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=HHjjyBER;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EwUPma9s;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbk6nqlkqkgqeqyulwua@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBK6NQLKQKGQEQYULWUA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1520477868; cv=pass;
        d=google.com; s=arc-20160816;
        b=1EuamsCA0rr3ok1ktpGqz+vraoPqi7bdQNp4mGgx64ixoKY3oQbcEkKR0F7xfu1YWB
         CxrwYY4j51Wz6put1K182O6pI7Z8CQkIzPVEvu0OgmOAT1uT/V6UCDs9aFwiX5svY4K+
         dv0Wk+8H9r4sMpSB6PsvfPm01wpuJJF7k8JFfy5Z43h16GqKJw6I2gqhJaNQQBySGZ0Q
         8weNpA1or311K8o60/RNaY4YlNyprvtmEerWp9wJwqYqL6bZ5VNqx/H4g3cbkdDJuI/X
         jYdOM/XCwTHK7rJaIWHvCB7oSiDQLuZW1tLgdQXW4i2NNZ1BND+xXVUA+v8cav1Z5yQJ
         5fVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=jgc7HlAMLRdSwmXOHA6qdSgUvxaLzRPDKFYGHRZ3Dv4=;
        b=mjiVp/QkuRBI7aFV+sSsQaJAEEGGMJ4bRzJf5fIlHEwcJdslrVSgowmBXem62D9Y8N
         BYEjxFmzJq8B1kwVZgyyXcIRO9cM/Zg1Udb8s2TW39hW2INPXyfNBCbqfsd4ISoAB7fF
         vQ6DREB3ZrabdWWHEoJvdjj8q0smUEoHN85gKsJmiNOmMFzbhvH6uPjVLrARShx6Iv2y
         mc/Ehsu5q/KiujBuIVIJ+Prx3ViW0Slyh0Jkf1Z/BcE2qKuiSikVFu1JfPA99BXmEJD0
         yJWOMG2rDYnDbE3C1e6teupFrmGNBP3AnTaYYlFp+kPibTfhskorr27DfvJ3ArFLnVAa
         5Dsg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OLyIxYx+;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::230 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELurs5s0rtI+1llgTjEz8GOtXxctnrDTzmFtRlG8XfwT/zLf85/zVkLUoQyOFclYkSqv5NYQHQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520477867; cv=none;
        d=google.com; s=arc-20160816;
        b=ta7SShqQ3o4v3J67u5ll7L8ScTCvJLG0nw98QzvnqFY+kP0GmlqfyQmytQHNQkn+or
         W1Ho5JlZjzlT4PqkoiLvlVd1Gxnqj2bBT1YN8UGGiTh+WdEhMYxuklf0uXaF5cybwmnL
         u8kyexq5qZBwyTkk1uZjl/TAEZ0HXftQypslD8MqEV+S6VmNlXRAZySfTHnZxu95sanb
         jXpnWQq3QgBnO0jRlXvH7hnlkmcqKPP+pwePWhOITMAfrp/+7pUb0TkYsGNzdRSOU0Mu
         H8NxJAr8uauIFfM5OJIAbCy8GQNRcCdwLpFAcFatNC9ELfpSJscZNqYnxAfNKnN4yfBW
         lg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=vOqTgXsgHrJnaA4nOeDx/mKjaysmdzPvtnWjd2oQzng=;
        b=oA4OdaZ2y+TTiEDtVP+1W+wmXGb6zgIZO/B5rQ6lOEYQXowIxI3wQRRhbsHTqJ9Lev
         UWXqLXjyeB+QZ3l5wGQQpf3O51ZUrfNRJrtdlidsYkXeC7ePWriy2sHNb33umKiTp7cQ
         0bZc4o3AMR0O/SfMoZ8gSlagouvyjmk32f1SzqZbGZjVFP0tgrWZitBlw4b7LiWlqiHn
         /qv6z4hifvX/zMpoTHp93ttfyqMf/+QRjnVJQ1XX+bfO2Y+HznDGIn8DJO0Cx4+sAxgd
         EnvXY5h7suykMmOpiofjP8lYb0szqzQrkubNJ6buE+Y6KqbLnYpI0Yws3P4pHque58wy
         CQkg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OLyIxYx+;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::230 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803072039260.2814@hadrien>
References: <20180303161456.GA20194@seema-Inspiron-15-3567>
 <20180307.103901.1771176275743006915.davem@davemloft.net> <CA+XqjF8_axeTnahPmokxmDnm4NmWo8QWSEmLejN4fO1nAiDaBA@mail.gmail.com>
 <alpine.DEB.2.20.1803072039260.2814@hadrien>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Thu, 8 Mar 2018 08:27:46 +0530
Message-ID: <CA+XqjF_9sMh2G6wX4SW75iXbUw=Bt6J0AE4_rjqrNB_UAKcZtA@mail.gmail.com>
Subject: Re: [Outreachy kernel] Re: [PATCH v2] net: ethernet: Drop unnecessary continue
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: David Miller <davem@davemloft.net>, jdmason@kudzu.us,
	Jakub Kicinski <jakub.kicinski@netronome.com>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	oss-drivers@netronome.com, outreachy-kernel@googlegroups.com
Content-Type: multipart/alternative; boundary="f4f5e805a8b426f0b30566ddd767"
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=OLyIxYx+;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2a00:1450:4010:c07::230 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593933797410411478?=
X-GMAIL-MSGID: =?utf-8?q?1594336601585054721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--f4f5e805a8b426f0b30566ddd767
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 8, 2018 at 1:11 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Wed, 7 Mar 2018, Arushi Singhal wrote:
>
> >
> >
> > On Wed, Mar 7, 2018 at 9:09 PM, David Miller <davem@davemloft.net>
> wrote:
> >       From: Arushi Singhal <arushisinghal19971997@gmail.com>
> >       Date: Sat, 3 Mar 2018 21:44:56 +0530
> >
> >       > Continue at the bottom of a loop are removed.
> >       > Issue found using drop_continue.cocci Coccinelle script.
> >       >
> >       > Signed-off-by: Arushi Singhal
> >       <arushisinghal19971997@gmail.com>
> >       > ---
> >       > Changes in v2:
> >       > - Braces is dropped from if with single statement.
> >
> >       Sorry there is no way I am applying this.
> >
> >       Just blindly removing continue statements that some static
> >       checker
> >       or compiler warning mentions is completely unacceptable.
> >
> >       Actually _LOOK_ at this code:
> >
> >       >               if(cards[i].vendor_id) {
> >       >                       for(j=0;j<3;j++)
> >       > -
> >        if(inb(ioaddr+cards[i].addr_offset+j) != cards[i].vendor_id[j])
> >       {
> >       > +
> >        if(inb(ioaddr+cards[i].addr_offset+j) != cards[i].vendor_id[j])
> >       >                                       release_region(ioaddr,
> >       cards[i].total_size);
> >       > -                                     continue;
> >       > -                       }
> >       >               }
> >
> >       The extraneous continue statement is the _least_ of the problems
> >       here.
> >
> >
> > Hello David
> >
> > Yes you are correct.
> >
> >
> >       This code, if the if() statement triggers, will release the
> >       ioaddr
> >       region and then _CONTINUE_ the for(j) loop, and try to access
> >       the
> >       registers using the same 'ioaddr' again.
> >
> >       That's actually a _REAL_ bug, and you're making it seem like
> >       the behavior is intentional by editing it like this.
> >
> >       And the bug probably exists because this entire sequence has
> >       misaligned closing curly braces.  It makes it look like
> >       the continue is for the outer loop, which would be fine.
> >
> >       But it's not.  It's for the inner loop, and this causes the "use
> >       ioaddr after releasing it" bug.
> >
> >
> > Yes I know it's for the inner loop.
> > But I am not able to find, where I am wrong here
>
> Arushi,
>
> You are preserving the current behavior and David is telling you that the
> current behavior is incorrect.  He doesn't want a patch that changes the
> code but preesrves the current (wrong) behavior, because that somehow
> contributes to the illusion that the incorrect code is correct.
>

Thanks Julia :) for explaining it further.
Arushi

>
> julia
>
> >
> > For example
> > BEFORE:-
> > for(i=1;i<10;i++)
> >        if (expr1)
> >           {
> >              statement;
> >              continue;
> >           }
> >
> > After My Patch
> > for(i=1;i<10;i++)
> >     if (expr1)
> >        statement;
> >
> > I am not understanding where I am getting wrong in understanding this.
> > For me both are equivalent.
> >
> > I Agree with Jakub reply:-
> > "This is an error handling path so the continue makes sense here to
> > indicate the processing can't ever fall through if more statements are
> > ever added to the loop.  But OK."
> >
> > Thanks
> > Arushi
> >
> >
> >       Please do not submit patches like this one, it makes for a lot
> >       of
> >       wasted auditing and review for people.  The onus is on you to
> >       read
> >       and understand the code you are editing before submitting your
> >       changes.
> >
> >       Thank you.
> >
> >
> > --
> > You received this message because you are subscribed to the Google Groups
> > "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an
> > email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visithttps://groups.google.
> com/d/msgid/outreachy-kernel/CA%2BXqjF8_axeTnahPmokxm
> > Dnm4NmWo8QWSEmLejN4fO1nAiDaBA%40mail.gmail.com.
> > For more options, visit https://groups.google.com/d/optout.
> >
> >

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF_9sMh2G6wX4SW75iXbUw%3DBt6J0AE4_rjqrNB_UAKcZtA%40mail.gmail.com.
For more options, visit https://groups.google.com/d/optout.

--f4f5e805a8b426f0b30566ddd767
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Mar 8, 2018 at 1:11 AM, Julia Lawall <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:julia.lawall@lip6.fr">julia.lawall@lip6.fr</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h=
5"><br>
<br>
On Wed, 7 Mar 2018, Arushi Singhal wrote:<br>
<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Mar 7, 2018 at 9:09 PM, David Miller &lt;<a href=3D"mailto:dav=
em@davemloft.net">davem@davemloft.net</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0From: Arushi Singhal &lt;<a href=3D"mailto:a=
rushisinghal19971997@gmail.com">arushisinghal19971997@gmail.<wbr>com</a>&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Date: Sat, 3 Mar 2018 21:44:56 +0530<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Continue at the bottom of a loop are re=
moved.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Issue found using drop_continue.cocci C=
occinelle script.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Arushi Singhal<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:arushisinghal19971997@=
gmail.com">arushisinghal19971997@gmail.<wbr>com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Changes in v2:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; - Braces is dropped from if with single=
 statement.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Sorry there is no way I am applying this.<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Just blindly removing continue statements th=
at some static<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0checker<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0or compiler warning mentions is completely u=
nacceptable.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Actually _LOOK_ at this code:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if(cards[i].vendor_id) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for(j=3D0;j&lt;3;j++)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0if(inb(ioaddr+cards[i].addr_<wbr>offse=
t+j) !=3D cards[i].vendor_id[j])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0if(inb(ioaddr+cards[i].addr_<wbr>offse=
t+j) !=3D cards[i].vendor_id[j])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0release_region(ioaddr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cards[i].total_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0The extraneous continue statement is the _le=
ast_ of the problems<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0here.<br>
&gt;<br>
&gt;<br>
&gt; Hello David<br>
&gt;<br>
&gt; Yes you are correct.<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0This code, if the if() statement triggers, w=
ill release the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ioaddr<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0region and then _CONTINUE_ the for(j) loop, =
and try to access<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0registers using the same &#39;ioaddr&#39; ag=
ain.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0That&#39;s actually a _REAL_ bug, and you&#3=
9;re making it seem like<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the behavior is intentional by editing it li=
ke this.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0And the bug probably exists because this ent=
ire sequence has<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0misaligned closing curly braces.=C2=A0 It ma=
kes it look like<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the continue is for the outer loop, which wo=
uld be fine.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0But it&#39;s not.=C2=A0 It&#39;s for the inn=
er loop, and this causes the &quot;use<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ioaddr after releasing it&quot; bug.<br>
&gt;<br>
&gt;<br>
&gt; Yes I know it&#39;s for the inner loop.<br>
&gt; But I am not able to find, where I am wrong here<br>
<br>
</div></div>Arushi,<br>
<br>
You are preserving the current behavior and David is telling you that the<b=
r>
current behavior is incorrect.=C2=A0 He doesn&#39;t want a patch that chang=
es the<br>
code but preesrves the current (wrong) behavior, because that somehow<br>
contributes to the illusion that the incorrect code is correct.<br></blockq=
uote><div><br></div><div>Thanks Julia :) for explaining it further.<br></di=
v><div>Arushi<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
julia<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; For example<br>
&gt; BEFORE:-<br>
&gt; for(i=3D1;i&lt;10;i++)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (expr1)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 statement;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 continue;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; =C2=A0<br>
&gt; After My Patch<br>
&gt; for(i=3D1;i&lt;10;i++)<br>
&gt; =C2=A0=C2=A0=C2=A0 if (expr1)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 statement;<br>
&gt;<br>
&gt; I am not understanding where I am getting wrong in understanding this.=
<br>
&gt; For me both are equivalent.<br>
&gt;<br>
&gt; I Agree with Jakub reply:-<br>
&gt; &quot;This is an error handling path so the continue makes sense here =
to<br>
&gt; indicate the processing can&#39;t ever fall through if more statements=
 are<br>
&gt; ever added to the loop.=C2=A0 But OK.&quot;<br>
&gt;<br>
&gt; Thanks<br>
&gt; Arushi<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Please do not submit patches like this one, =
it makes for a lot<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wasted auditing and review for people.=C2=A0=
 The onus is on you to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0read<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0and understand the code you are editing befo=
re submitting your<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0changes.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Thank you.<br>
&gt;<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; You received this message because you are subscribed to the Google Gro=
ups<br>
&gt; &quot;outreachy-kernel&quot; group.<br>
&gt; To unsubscribe from this group and stop receiving emails from it, send=
 an<br>
&gt; email to <a href=3D"mailto:outreachy-kernel%2Bunsubscribe@googlegroups=
.com">outreachy-kernel+unsubscribe@<wbr>googlegroups.com</a>.<br>
&gt; To post to this group, send email to <a href=3D"mailto:outreachy-kerne=
l@googlegroups.com">outreachy-kernel@googlegroups.<wbr>com</a>.<br>
&gt; To view this discussion on the web visithttps://<a href=3D"http://grou=
ps.google.com/d/msgid/outreachy-kernel/CA%2BXqjF8_axeTnahPmokxm" rel=3D"nor=
eferrer">groups.google.<wbr>com/d/msgid/outreachy-kernel/<wbr>CA%2BXqjF8_ax=
eTnahPmokxm</a><br>
&gt; Dnm4NmWo8QWSEmLejN4fO1nAiDaBA%<a href=3D"http://40mail.gmail.com" rel=
=3D"noreferrer"><wbr>40mail.gmail.com</a>.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
 rel=3D"noreferrer">https://groups.google.com/d/<wbr>optout</a>.<br>
&gt;<br>
&gt;</font></span></blockquote></div><br></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;outreachy-kernel&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:outreachy-kernel+unsubscribe@googlegroups.com">ou=
treachy-kernel+unsubscribe@googlegroups.com</a>.<br />
To post to this group, send email to <a href=3D"mailto:outreachy-kernel@goo=
glegroups.com">outreachy-kernel@googlegroups.com</a>.<br />
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/outreachy-kernel/CA%2BXqjF_9sMh2G6wX4SW75iXbUw%3DBt6J0AE4_rjqrNB=
_UAKcZtA%40mail.gmail.com?utm_medium=3Demail&utm_source=3Dfooter">https://g=
roups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF_9sMh2G6wX4SW75iXbUw%3DB=
t6J0AE4_rjqrNB_UAKcZtA%40mail.gmail.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--f4f5e805a8b426f0b30566ddd767--
