Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBP5RQDKQKGQEBO7OFJY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520441535; cv=pass;
        d=google.com; s=arc-20160816;
        b=DOa+kC+EHQiLFoz0jtgBTsPYgR1SRfrggkECn16Q894fTCtppjtyOeF/OoHBpMQwOz
         4zMOv1FN48Zj5Lo5lpN/PWXL1cSqeH+g6BybZPXNaVr9ZAxS3SqhUFt6iSUispY4a5Lg
         AN6qgMYGPDZGPLXo6gFuh+RYL6tn8zw13oiQYMDwecCthezS9PRIdaQjiAfp9dZSC4RF
         b6uwoxWb2bF+WKYQmTb0LAjeSPLA0u+vzUwLrQe6UTrO5msz5aS+xekhKY1FSs1oECl5
         dh8MjZt6w2c2Xo2etX6CAFg48tyucHSoySte0LWVrvQ46xzdhZhhqZNEPexYv3cx5BTG
         lugQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=V/ha9EuFUZgnUcO+Cl54TPZEcDurA8Vo5NuBq3Cjvs8=;
        b=QK/oNEvu/2RInXABLhDjWbryj+114b56R7AG0fwwyOSRRUTw2i1sgVicruWaAIK1rr
         7YIAzme5kMxshemdq9bhSN0qblp2Wa06qgVspH2nh0Hb+7FwVJ5APzlzMHJuWqPbqgz5
         Ex7TLgOB/u9xcauUhb9GzbTAVAUTCjHrxG5Lwo2rZ9X2uQBLE+tG2+Tqgnkl34bB9Qj5
         g6y5DofUD5X3SoPrTrReKdLC2qbLR5fEV2t0PzklnO1md1VQiQnN7iLADGNEf6IDvrgn
         HiSiGbVSCgcagnJgk3vHQzX51jf21MwiHdyeXDoJA1U7B1J9Q+72i/DVRQ34Rhi552G/
         FXlw==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Mtiu2/qK;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qy0S3pXR;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbp5rqdkqkgqebo7ofjy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBP5RQDKQKGQEBO7OFJY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Mtiu2/qK;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qy0S3pXR;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbp5rqdkqkgqebo7ofjy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBP5RQDKQKGQEBO7OFJY@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1520441535; cv=pass;
        d=google.com; s=arc-20160816;
        b=otnPCVLg8Y44rNu9p10OJRQe+zFeug4/WJ+G4pQJ9kYQRJXhJ+LfjrKl1Ue/JrQBmx
         d4BhrsL9eOYUmcVGBWJeiiVl5Xphj8Y4/1N6Ftx4tORD8Hz87ih1Rpv0y65u/JVPDu6r
         r9p9+2avhaqvagfH0RaC6rTRwuKXztPjKfVZfSQc7avaYZqcKKKx/+zMhzWxNlz4lKVo
         1ZcB4wtkefOWIqZJN+dq1NL1DwJ9v26m4vAmlly4VpzxPbRkTc8TpLtBlxUHLLw1z9/e
         KZNjqfIM8aw5P0Ta/sJz1v43gW/kkCnFJZuxRDOUg0C9FTAcHeIDAbqVxWCtQqfSZNhs
         95tg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=V/ha9EuFUZgnUcO+Cl54TPZEcDurA8Vo5NuBq3Cjvs8=;
        b=0ZZpmZ1TnOE/LblCTJL2OE1oWeIbYzCv28lJkQetgcXhPsqACNNXej6CMmxRAaLtkq
         IAsyNvLeCVOWLJ202g7PPKUdjZ9Q3c1JZ27COErEMx6ubgY8EL6zBIzn3zLGFkRj2f2o
         +fKclsN39v83m4nwpANewrAZOd8r18B33heKMoBiQFj1Ug00Ig+L/tqb+aNCtT+R76S7
         gkbTfm+FRk6sBV8yNQbzbYLeSZyMv4PYqUFB7jGJofCSdIDkgP5rckZbY9BNEEZIoQUp
         4MHi71cQ8+s6MwfjQd22hla90kzhIYAfAvbHB3bTnhW738sO5uElW9WhG+pnHwNwwjDa
         1Oww==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TFlm1D0G;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::234 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELv22QyA/ZSqdvgOxeY3sELGD5rupvUKeWJUO1Z74ELjA74U9ujmXmgZltstQpCBybllMsmCMA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520441534; cv=none;
        d=google.com; s=arc-20160816;
        b=VSWQO/XsGkICtFGmdtImarnNbUfocp4uAb5DxgWVAUbi5GLgMS+6DtwkuCWtwHUneK
         thhyJIU5BI6Pqh3enrjMx21xFdWUmqkUSXbVUXSuAMzz8q0GVPCyOXQf72ut2trJwUbq
         G8mVHcfD3T7NnGOHmn/bDCP2gAgAoIlEeAaRCd6XXcbxR1iB+2zOZ2mwmjVkgq5902GO
         o2bfHWeuwV782W4e0JDKhAdQDyQKTkBdHNavi20nA963+y9aeb1zgptFAlPk5ngdm6pm
         pMSITvucWhmJcLBMbzLHpokvTxwJDMKM48F799elNWkB3IERq/Wc4qjewMKRFQwbtRUb
         SY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Ni+Oi/a+SZPiGK72NcvsKqbLJTBl8lJauCSJdW1BDvE=;
        b=wVXGJL+FFjCR4+Wu9/itVaiAjbmwoG77rJT6ltll7cV23kr9e+mUoEj4sijLxbwtBV
         kPHao9qPoSwvfYcQQj8r9B+5oLEFgBo1AiSL24Fw1BNVFH7Nzp4rmizJS4JRYe5f4RT6
         AiZmXJU9UEHlvgqWXaCE7jCknm6oV79BcrRF00AbDaqRBKW6WvS+fIdtTd5Ph1np2mm0
         v/FYOQJNE+9c9BdfRF09TUcwjBJbr66wXeKi0FuRDYtmcAF+kzuZd/ao9ouTnhmczyQH
         nJWEV8J8FvBvzJUTrRC35i0i4qC+MRea8wjcWCzSE7bzR5viDanSV0wGeSm/ggmATItf
         RCOA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TFlm1D0G;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2a00:1450:4010:c07::234 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
MIME-Version: 1.0
In-Reply-To: <20180307.103901.1771176275743006915.davem@davemloft.net>
References: <20180303161456.GA20194@seema-Inspiron-15-3567> <20180307.103901.1771176275743006915.davem@davemloft.net>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Wed, 7 Mar 2018 22:22:13 +0530
Message-ID: <CA+XqjF8_axeTnahPmokxmDnm4NmWo8QWSEmLejN4fO1nAiDaBA@mail.gmail.com>
Subject: [Outreachy kernel] Re: [PATCH v2] net: ethernet: Drop unnecessary continue
To: David Miller <davem@davemloft.net>
Cc: jdmason@kudzu.us, Jakub Kicinski <jakub.kicinski@netronome.com>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	oss-drivers@netronome.com, outreachy-kernel@googlegroups.com
Content-Type: multipart/alternative; boundary="001a113a80da91f1c20566d5611c"
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=TFlm1D0G;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2a00:1450:4010:c07::234 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
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
X-GMAIL-MSGID: =?utf-8?q?1594298503648204626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a113a80da91f1c20566d5611c
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 7, 2018 at 9:09 PM, David Miller <davem@davemloft.net> wrote:

> From: Arushi Singhal <arushisinghal19971997@gmail.com>
> Date: Sat, 3 Mar 2018 21:44:56 +0530
>
> > Continue at the bottom of a loop are removed.
> > Issue found using drop_continue.cocci Coccinelle script.
> >
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> > Changes in v2:
> > - Braces is dropped from if with single statement.
>
> Sorry there is no way I am applying this.
>
> Just blindly removing continue statements that some static checker
> or compiler warning mentions is completely unacceptable.
>
> Actually _LOOK_ at this code:
>
> >               if(cards[i].vendor_id) {
> >                       for(j=0;j<3;j++)
> > -                             if(inb(ioaddr+cards[i].addr_offset+j) !=
> cards[i].vendor_id[j]) {
> > +                             if(inb(ioaddr+cards[i].addr_offset+j) !=
> cards[i].vendor_id[j])
> >                                       release_region(ioaddr,
> cards[i].total_size);
> > -                                     continue;
> > -                       }
> >               }
>
> The extraneous continue statement is the _least_ of the problems here.
>

Hello David

Yes you are correct.


>
> This code, if the if() statement triggers, will release the ioaddr
> region and then _CONTINUE_ the for(j) loop, and try to access the
> registers using the same 'ioaddr' again.
>
> That's actually a _REAL_ bug, and you're making it seem like
> the behavior is intentional by editing it like this.
>
> And the bug probably exists because this entire sequence has
> misaligned closing curly braces.  It makes it look like
> the continue is for the outer loop, which would be fine.
>
> But it's not.  It's for the inner loop, and this causes the "use
> ioaddr after releasing it" bug.
>

Yes I know it's for the inner loop.
But I am not able to find, where I am wrong here

For example
*BEFORE:-*
for(i=1;i<10;i++)
       if (expr1)
          {
             statement;
             continue;
          }

*After My Patch*
for(i=1;i<10;i++)
    if (expr1)
       statement;

I am not understanding where I am getting wrong in understanding this.
For me both are equivalent.

I Agree with Jakub reply:-
"This is an error handling path so the continue makes sense here to
indicate the processing can't ever fall through if more statements are
ever added to the loop.  But OK."

Thanks
Arushi


> Please do not submit patches like this one, it makes for a lot of
> wasted auditing and review for people.  The onus is on you to read
> and understand the code you are editing before submitting your
> changes.
>
> Thank you.
>
>

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF8_axeTnahPmokxmDnm4NmWo8QWSEmLejN4fO1nAiDaBA%40mail.gmail.com.
For more options, visit https://groups.google.com/d/optout.

--001a113a80da91f1c20566d5611c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Mar 7, 2018 at 9:09 PM, David Miller <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:davem@davemloft.net" target=3D"_blank">davem@davemloft.net</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Arushi Singhal =
&lt;<a href=3D"mailto:arushisinghal19971997@gmail.com">arushisinghal1997199=
7@gmail.<wbr>com</a>&gt;<br>
Date: Sat, 3 Mar 2018 21:44:56 +0530<br>
<span class=3D""><br>
&gt; Continue at the bottom of a loop are removed.<br>
&gt; Issue found using drop_continue.cocci Coccinelle script.<br>
&gt;<br>
&gt; Signed-off-by: Arushi Singhal &lt;<a href=3D"mailto:arushisinghal19971=
997@gmail.com">arushisinghal19971997@gmail.<wbr>com</a>&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt; - Braces is dropped from if with single statement.<br>
<br>
</span>Sorry there is no way I am applying this.<br>
<br>
Just blindly removing continue statements that some static checker<br>
or compiler warning mentions is completely unacceptable.<br>
<br>
Actually _LOOK_ at this code:<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if(cards[i].vend=
or_id) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for(j=3D0;j&lt;3;j++)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if(inb(ioaddr+cards[i].addr_<wbr>offset+=
j) !=3D cards[i].vendor_id[j]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if(inb(ioaddr+cards[i].addr_<wbr>offset+=
j) !=3D cards[i].vendor_id[j])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0releas=
e_region(ioaddr, cards[i].total_size);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</span>The extraneous continue statement is the _least_ of the problems her=
e.<br></blockquote><div><br>Hello David<br></div><div><br></div><div>Yes yo=
u are correct.<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
This code, if the if() statement triggers, will release the ioaddr<br>
region and then _CONTINUE_ the for(j) loop, and try to access the<br>
registers using the same &#39;ioaddr&#39; again.<br>
<br>
That&#39;s actually a _REAL_ bug, and you&#39;re making it seem like<br>
the behavior is intentional by editing it like this.<br>
<br>
And the bug probably exists because this entire sequence has<br>
misaligned closing curly braces.=C2=A0 It makes it look like<br>
the continue is for the outer loop, which would be fine.<br>
<br>
But it&#39;s not.=C2=A0 It&#39;s for the inner loop, and this causes the &q=
uot;use<br>
ioaddr after releasing it&quot; bug.<br></blockquote><div><br></div><div>Ye=
s I know it&#39;s for the inner loop.<br></div><div>But I am not able to fi=
nd, where I am wrong here<br><br></div><div>For example<br></div><div><b>BE=
FORE:-</b><br>for(i=3D1;i&lt;10;i++)<br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (expr1)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 {<br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 statement;<br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;<br></div><div>=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br></div><div>=C2=A0<=
br></div><div><b>After My Patch</b><br><div>for(i=3D1;i&lt;10;i++)<br></div=
><div>=C2=A0=C2=A0=C2=A0 if (expr1)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 <br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 statement;<br></div><br>=
I am not understanding where I am getting wrong in understanding this.<br><=
/div><div>For me both are equivalent.<br><br>I Agree with Jakub reply:-<br>=
&quot;This is an error handling path so the continue makes sense here to<br=
>
indicate the processing can&#39;t ever fall through if more statements are<=
br>
ever added to the loop.=C2=A0 But OK.&quot;<br></div><div><br></div><div>Th=
anks<br></div><div>Arushi<br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<br>
Please do not submit patches like this one, it makes for a lot of<br>
wasted auditing and review for people.=C2=A0 The onus is on you to read<br>
and understand the code you are editing before submitting your<br>
changes.<br>
<br>
Thank you.<br>
<br>
</blockquote></div><br></div></div>

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
om/d/msgid/outreachy-kernel/CA%2BXqjF8_axeTnahPmokxmDnm4NmWo8QWSEmLejN4fO1n=
AiDaBA%40mail.gmail.com?utm_medium=3Demail&utm_source=3Dfooter">https://gro=
ups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF8_axeTnahPmokxmDnm4NmWo8QW=
SEmLejN4fO1nAiDaBA%40mail.gmail.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--001a113a80da91f1c20566d5611c--
