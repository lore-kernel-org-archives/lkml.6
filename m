Return-Path: <arvindprasanna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519839561; cv=none;
        d=google.com; s=arc-20160816;
        b=IOTFZeaNH0xycaToYYkmYWbpjSUHItILxAMiWsZsE6sJYkPqk2IMewtFz+7mLCn93e
         rDR6INZBM8uXZDuGmjVafZrZO6l3UHnaRrSsGM17hKlD4+xIlf3Ev/JG5/3XLYaI8uHc
         W8/+cvKMP+pA2p9aX8vAX38tNr/8JMkBZgKtJweFtWV9WwI1A7dIY7VKUDT8ySxiEItW
         z5Umb6w5V+ytdiR0ONjXiN8AWaW2nHQhLu3W+Si3mf65L1hd2//Zs11bm2MSqOVyHYBG
         CMXd2ay5vE5akJjUv2WT7O9ZXYrrmaxW/Lm97/qyE4G+KZPLzB/yhi+CJm5lBD7ai/DH
         M2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=rfPcZeS6O6l+2Fc51E3qR4WJ4vzvLsax8LYDPOW2l5Y=;
        b=yfnXsGakWCXI3l8EGumZb/zkgoRdgSggSzZEmEKmsdKziY0CT1Po6KDQX7eRCb2b8P
         t/3iC5MGoOmkOHUJwNjlmr/+l+xSgU2r51VseT+QgowIlU+iRNuUN03wFjGyfiMBpiEI
         ngVTdOddZUbFEQkRZN1ilr3F/03OADxI82HHi+bepFaMamjeVP8blkAuL+RnJf3+OJnO
         pKtfoQR+fRCsW3k/iEl21cJbJWw0L7tBpMpKg5zOvzuu11sk33ulxXsGRVXMd3NbonPB
         e/7tY5Qa7kJEte67XMzoMxng41Ys4ZRWGkPX0T3J0uk1zxMTvzLPp7zum/qFzsrWDhfz
         0oNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iDLtgYkW;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iDLtgYkW;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuDtHY3Zf675dyl6HkPzx5FuSP982mkVBmSBH/TjgAf2VgED9h4/Y1kN6TZWNu+tutHDTS2xNrIwtA6oBMS6sA=
MIME-Version: 1.0
In-Reply-To: <43a91eb4-646a-b4d8-5b3d-b0bfde0019d9@infradead.org>
References: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com> <43a91eb4-646a-b4d8-5b3d-b0bfde0019d9@infradead.org>
From: Arvind Prasanna <arvindprasanna@gmail.com>
Date: Wed, 28 Feb 2018 12:39:20 -0500
Message-ID: <CAK-=9LoNfYP_-tm+W2GvUWjWgs=BZ-VRFmVNzTCadzQWaee9yg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Update ncurses package names for menuconfig
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c1a68cc2968d80566493919"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593667287837674678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c1a68cc2968d80566493919
Content-Type: text/plain; charset="UTF-8"

Hi Randy:

On 02/27/2018 10:59 PM, Arvind Prasanna wrote:
> The package name is ncurses-devel for Redhat based distros
> and libncurses-devel for Debian based distros.

The above lines are part of the commit message and the patch says to
install either ncurses-devel or libncurses-dev based on the user's Linux
distribution. Would you prefer I add my commit message lines to the patch
as well?

Thanks,

Arvind.


On Wed, Feb 28, 2018 at 12:31 PM, Randy Dunlap <rdunlap@infradead.org>
wrote:

> On 02/27/2018 10:59 PM, Arvind Prasanna wrote:
> > The package name is ncurses-devel for Redhat based distros
> > and libncurses-devel for Debian based distros.
>
>       ^^^^^^^^^^^^^^^^ That's not what the patch says. Please clarify.
>
> >
> > Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>
> > ---
> >  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh
> b/scripts/kconfig/lxdialog/check-lxdialog.sh
> > index a10bd9d..4353e40 100755
> > --- a/scripts/kconfig/lxdialog/check-lxdialog.sh
> > +++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
> > @@ -55,7 +55,8 @@ EOF
> >           echo " *** required header files."
> 1>&2
> >           echo " *** 'make menuconfig' requires the ncurses libraries."
> 1>&2
> >           echo " *** "
> 1>&2
> > -         echo " *** Install ncurses (ncurses-devel) and try again."
> 1>&2
> > +         echo " *** Install ncurses (ncurses-devel or libncurses-dev
>  1>&2
> > +                *** depending on your distribution) and try again."
> 1>&2
> >           echo " *** "
> 1>&2
> >           exit 1
> >       fi
> >
>
> thanks,
> --
> ~Randy
>

--94eb2c1a68cc2968d80566493919
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Randy:<div><br></div><div><div>On 02/27/2018 10:59 PM, =
Arvind Prasanna wrote:</div><div>&gt; The package name is ncurses-devel for=
 Redhat based distros</div><div>&gt; and libncurses-devel for Debian based =
distros.</div></div><div><br></div><div>The above lines are part of the com=
mit message and the patch says to install either ncurses-devel or libncurse=
s-dev based on the user&#39;s Linux distribution. Would you prefer I add my=
 commit message lines to the patch as well?</div><div><br></div><div>Thanks=
,</div><div><br>Arvind.</div><div><br></div></div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On Wed, Feb 28, 2018 at 12:31 PM, Randy Du=
nlap <span dir=3D"ltr">&lt;<a href=3D"mailto:rdunlap@infradead.org" target=
=3D"_blank">rdunlap@infradead.org</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><span class=3D"">On 02/27/2018 10:59 PM, Arvind Prasanna wro=
te:<br>
&gt; The package name is ncurses-devel for Redhat based distros<br>
&gt; and libncurses-devel for Debian based distros.<br>
<br>
</span>=C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^ That&#39;s not what the patch =
says. Please clarify.<br>
<span class=3D""><br>
&gt;<br>
&gt; Signed-off-by: Arvind Prasanna &lt;<a href=3D"mailto:arvindprasanna@gm=
ail.com">arvindprasanna@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh b/scripts=
/kconfig/lxdialog/<wbr>check-lxdialog.sh<br>
&gt; index a10bd9d..4353e40 100755<br>
&gt; --- a/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh<br>
&gt; +++ b/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh<br>
&gt; @@ -55,7 +55,8 @@ EOF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** required heade=
r files.&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** &#39;make menu=
config&#39; requires the ncurses libraries.&quot; 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** &quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** Install ncurses (nc=
urses-devel) and try again.&quot;=C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** Install ncurses (nc=
urses-devel or libncurses-dev=C2=A0 =C2=A01&gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *** depending=
 on your distribution) and try again.&quot;=C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** &quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt;<br>
<br>
</span>thanks,<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
~Randy<br>
</font></span></blockquote></div><br></div>

--94eb2c1a68cc2968d80566493919--
