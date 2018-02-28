Return-Path: <arvindprasanna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519847947; cv=none;
        d=google.com; s=arc-20160816;
        b=VmsFPZGx1ic0UU1IN1zJZ1EuY7n1euLxju376d0N6a1KY7xahojkgKLQyetIOIMd4p
         6kVapccdh5eQTtKKnPH7iS04xFElvmuSVlKktucZTBWkfF5x2ZLfFyu9lOO3Wr0eXb4P
         hG3Idl8eBPE6S2UDf6fqU3V/7S7Sf51gltgtcejEX2JACTlG47XVAf/6sCDcg559BND3
         74w2UrHesChUNZUykKGFLU/gYkLYU1IZZQJMi7YKNGvSRJO9OWZhShcHwJqOq3OCZZbH
         h0myPpfXv8iFLnUG/94/P+irGCorx40nTsDhuKvhi6ZGVho6VvXe6g3YKkEu9vZq5Fhi
         onuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mTBWc5z8bjLpGmSAVGZD+RRtnbtL6AndifAeGLcBPKY=;
        b=H1EsOYgBfDUwMY7at/cssUmzY250nxx0uX+0dQoZYTA+GqU3p+HAz9/neqfHp1tRb4
         bV0G3c9PAjKcBGPsM/dtPJ0KBxDgxQAOAnZys+H0pjQsniPaP7WFDZVNw6EhZ/4dpwp+
         Fa1Ln+oLiUB9hOl9o0bAp+Haa/vfukCB/NLnp6YpS2dDNvHBb4VO+CB4S5sihhIFKQZI
         C9d3HZ2VfVF4WKPlwyyYaWxQ2VbfmSswGn6I4Z3uHfYuMlLe5NVn+2bxCL0Z0WTMGyeh
         4GKtxX1/pilloIs2Y2fMsgSfJe+LDTU1uKfMxHj1KCvsgEoAt/ajcn6N+kaarsLSFdSw
         UniA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oPR40jgu;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oPR40jgu;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtwSpchR4BrCcDEDvl3AA/Uii5QG+R1wI9yic7XEUVMOUv77CqSny84KhedHws0lOOySwaOpDpCBd3t1pyPD7w=
MIME-Version: 1.0
In-Reply-To: <e484c42f-4fe6-10f5-dab8-cfd749911486@infradead.org>
References: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
 <43a91eb4-646a-b4d8-5b3d-b0bfde0019d9@infradead.org> <CAK-=9LoNfYP_-tm+W2GvUWjWgs=BZ-VRFmVNzTCadzQWaee9yg@mail.gmail.com>
 <e484c42f-4fe6-10f5-dab8-cfd749911486@infradead.org>
From: Arvind Prasanna <arvindprasanna@gmail.com>
Date: Wed, 28 Feb 2018 14:59:06 -0500
Message-ID: <CAK-=9Lph+GXzEsRf+2L2T1W4fJx-wo0HahPxfi6vPKSSxKxmqQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Update ncurses package names for menuconfig
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c1ce072fd7aa305664b2c55"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593676081204053098?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c1ce072fd7aa305664b2c55
Content-Type: text/plain; charset="UTF-8"

If a Linux distribution is RPM based, the package name is libncurses-dev
and if it is Debian based, it is ncurses-devel. Here are some examples:

# cat /etc/os-release | grep "PRETTY_NAME"
PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
# apt-cache search libncurses-dev
libncurses5-dev - developer's libraries for ncurses

# cat /etc/os-release | grep "PRETTY_NAME"
PRETTY_NAME="Ubuntu 16.04.3 LTS"
# apt-cache search libncurses-dev
libncurses5-dev - developer's libraries for ncurses


# cat /etc/os-release | grep "PRETTY_NAME"
PRETTY_NAME="CentOS Linux 7 (Core)"
# yum search ncurses-devel
====================================================================== N/S
matched: ncurses-devel
=======================================================================
ncurses-devel.i686 : Development files for the ncurses library
ncurses-devel.x86_64 : Development files for the ncurses library

# cat /etc/os-release | grep "PRETTY_NAME"
PRETTY_NAME="Fedora 27 (Twenty Seven)"
# yum search ncurses-devel
Last metadata expiration check: 0:05:07 ago on Wed Feb 28 19:20:24 2018.
================================================================== Name
Exactly Matched: ncurses-devel
==================================================================
ncurses-devel.i686 : Development files for the ncurses library
ncurses-devel.x86_64 : Development files for the ncurses library


I have tried RPM based and Debian based linux distros as they are
extensively used and widely distributed. For other (independent) Linux
distributions, it is possible they have their own names for the ncurses
development package.

Thanks,

- Arvind.

On Wed, Feb 28, 2018 at 1:59 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

> On 02/28/2018 09:39 AM, Arvind Prasanna wrote:
> > Hi Randy:
> >
> > On 02/27/2018 10:59 PM, Arvind Prasanna wrote:
> >> The package name is ncurses-devel for Redhat based distros
> >> and libncurses-devel for Debian based distros.
> >
> > The above lines are part of the commit message and the patch says to
> install either ncurses-devel or libncurses-dev based on the user's Linux
> distribution. Would you prefer I add my commit message lines to the patch
> as well?
> >
> > Thanks,
> >
> > Arvind.
> >
> >
> > On Wed, Feb 28, 2018 at 12:31 PM, Randy Dunlap <rdunlap@infradead.org
> <mailto:rdunlap@infradead.org>> wrote:
> >
> >     On 02/27/2018 10:59 PM, Arvind Prasanna wrote:
> >     > The package name is ncurses-devel for Redhat based distros
> >     > and libncurses-devel for Debian based distros.
> >
> >           ^^^^^^^^^^^^^^^^ That's not what the patch says. Please
> clarify.
>
> For Debian-based distros, is it libncurses-devel (above) or is it
> libncurses-dev (as below)?  [latter is without the ending "el"]
>
>
> And what about the other few hundred distros?  (rhetorical)
>
>
> >     >
> >     > Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com <mailto:
> arvindprasanna@gmail.com>>
> >     > ---
> >     >  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
> >     >  1 file changed, 2 insertions(+), 1 deletion(-)
> >     >
> >     > diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh
> b/scripts/kconfig/lxdialog/check-lxdialog.sh
> >     > index a10bd9d..4353e40 100755
> >     > --- a/scripts/kconfig/lxdialog/check-lxdialog.sh
> >     > +++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
> >     > @@ -55,7 +55,8 @@ EOF
> >     >           echo " *** required header files."
>       1>&2
> >     >           echo " *** 'make menuconfig' requires the ncurses
> libraries." 1>&2
> >     >           echo " *** "
>       1>&2
> >     > -         echo " *** Install ncurses (ncurses-devel) and try
> again."    1>&2
> >     > +         echo " *** Install ncurses (ncurses-devel or
> libncurses-dev   1>&2
> >     > +                *** depending on your distribution) and try
> again."    1>&2
> >     >           echo " *** "
>       1>&2
> >     >           exit 1
> >     >       fi
>
>
> --
> ~Randy
>

--94eb2c1ce072fd7aa305664b2c55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>If a Linux distribution is RPM based, the package nam=
e is libncurses-dev and if it is Debian based, it is ncurses-devel. Here ar=
e some examples:</div><div><br></div><div># cat /etc/os-release | grep &quo=
t;PRETTY_NAME&quot;</div><div>PRETTY_NAME=3D&quot;Debian GNU/Linux 9 (stret=
ch)&quot;</div><div># apt-cache search libncurses-dev</div><div>libncurses5=
-dev - developer&#39;s libraries for ncurses</div><div><br></div><div># cat=
 /etc/os-release | grep &quot;PRETTY_NAME&quot;<br></div><div>PRETTY_NAME=
=3D&quot;Ubuntu 16.04.3 LTS&quot;</div><div># apt-cache search libncurses-d=
ev</div><div>libncurses5-dev - developer&#39;s libraries for ncurses</div><=
div><br></div><div><br></div><div># cat /etc/os-release | grep &quot;PRETTY=
_NAME&quot;<br></div><div>PRETTY_NAME=3D&quot;CentOS Linux 7 (Core)&quot;</=
div><div># yum search ncurses-devel=C2=A0</div><div>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D N/S matched: ncurses-devel =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>ncurses=
-devel.i686 : Development files for the ncurses library</div><div>ncurses-d=
evel.x86_64 : Development files for the ncurses library</div><div><br></div=
><div># cat /etc/os-release | grep &quot;PRETTY_NAME&quot;<br></div><div>PR=
ETTY_NAME=3D&quot;Fedora 27 (Twenty Seven)&quot;</div><div># yum search ncu=
rses-devel</div><div>Last metadata expiration check: 0:05:07 ago on Wed Feb=
 28 19:20:24 2018.</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Name Exactly Matched: ncurses-devel =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</div><div>ncurses-devel.i686 : Development files for the nc=
urses library</div><div>ncurses-devel.x86_64 : Development files for the nc=
urses library</div><div><br></div><div><br></div><div>I have tried RPM base=
d and Debian based linux distros as they are extensively used and widely di=
stributed. For other (independent) Linux distributions, it is possible they=
 have their own names for the ncurses development package.=C2=A0</div><div>=
<br></div><div>Thanks,</div><div><br></div><div>- Arvind.</div></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Feb 28, 2018 at=
 1:59 PM, Randy Dunlap <span dir=3D"ltr">&lt;<a href=3D"mailto:rdunlap@infr=
adead.org" target=3D"_blank">rdunlap@infradead.org</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><span class=3D"">On 02/28/2018 09:39 AM, Ar=
vind Prasanna wrote:<br>
&gt; Hi Randy:<br>
&gt;<br>
&gt; On 02/27/2018 10:59 PM, Arvind Prasanna wrote:<br>
&gt;&gt; The package name is ncurses-devel for Redhat based distros<br>
&gt;&gt; and libncurses-devel for Debian based distros.<br>
&gt;<br>
&gt; The above lines are part of the commit message and the patch says to i=
nstall either ncurses-devel or libncurses-dev based on the user&#39;s Linux=
 distribution. Would you prefer I add my commit message lines to the patch =
as well?<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Arvind.<br>
&gt;<br>
&gt;<br>
</span><span class=3D"">&gt; On Wed, Feb 28, 2018 at 12:31 PM, Randy Dunlap=
 &lt;<a href=3D"mailto:rdunlap@infradead.org">rdunlap@infradead.org</a> &lt=
;mailto:<a href=3D"mailto:rdunlap@infradead.org">rdunlap@infradead.org</a>&=
gt;<wbr>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 02/27/2018 10:59 PM, Arvind Prasanna wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The package name is ncurses-devel for Redhat b=
ased distros<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; and libncurses-devel for Debian based distros.=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^ That&#39;s no=
t what the patch says. Please clarify.<br>
<br>
</span>For Debian-based distros, is it libncurses-devel (above) or is it<br=
>
libncurses-dev (as below)?=C2=A0 [latter is without the ending &quot;el&quo=
t;]<br>
<br>
<br>
And what about the other few hundred distros?=C2=A0 (rhetorical)<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Arvind Prasanna &lt;<a href=3D"=
mailto:arvindprasanna@gmail.com">arvindprasanna@gmail.com</a> &lt;mailto:<a=
 href=3D"mailto:arvindprasanna@gmail.com">arvindprasanna@gmail.<wbr>com</a>=
&gt;&gt;<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 scripts/kconfig/lxdialog/<wbr>check-lxdi=
alog.sh | 3 ++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 2 insertions(+), 1 delet=
ion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/scripts/kconfig/lxdialog/<wbr>che=
ck-lxdialog.sh b/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index a10bd9d..4353e40 100755<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/scripts/kconfig/lxdialog/<wbr>check-lxdi=
alog.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/scripts/kconfig/lxdialog/<wbr>check-lxdi=
alog.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -55,7 +55,8 @@ EOF<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &=
quot; *** required header files.&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &=
quot; *** &#39;make menuconfig&#39; requires the ncurses libraries.&quot; 1=
&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &=
quot; *** &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=
 *** Install ncurses (ncurses-devel) and try again.&quot;=C2=A0 =C2=A0 1&gt=
;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;=
 *** Install ncurses (ncurses-devel or libncurses-dev=C2=A0 =C2=A01&gt;&amp=
;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *** depending on your distribution) and try again.&quot;=C2=A0 =
=C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &=
quot; *** &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
~Randy<br>
</font></span></blockquote></div><br></div>

--94eb2c1ce072fd7aa305664b2c55--
