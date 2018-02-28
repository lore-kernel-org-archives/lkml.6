Return-Path: <arvindprasanna@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519857158; cv=none;
        d=google.com; s=arc-20160816;
        b=AiCyUo9ocWhPh1w4vzWOBIsmJ5OCc27Jbomq3IO9/RoiRXkziWBLgsQytm1yyOiUye
         WaI5HDzHW3ROasZWY09CXEzECzoyOSKx5f4Z8qolzuGIebXz8NaR+4poolxUaf3iQTpF
         SiPKfawSZQdH9pmfkFK7VErTi6hWtEHDbMp/GMzUeQ2Hi6OkY/cgQAU/9eIO9lorKovd
         H7PNkUm9x5ehu9WBTEFfWQxz+Bzv2rShyZx72owLxGGWO4eZeB4beg7tHrlmeOCjpqSo
         7LvCOHRiDkx+fNb5Iar15EXxKUiXWwL0IbE/Ziapt0nu5k6SxSrZb7TJcOgYrxOWqnRF
         cZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=NXyckP30A2/LW3fyHT18Lwso7OCLTKqCi+e31mHX7R4=;
        b=Yk2glLwujxVI6A0nvaAXcLQIKzl/iDqeFJ+uzrSFYo5KfSl86t7Bn5WiEml8eL0Hkc
         17Lbp2iUa0SQyHvaObIDT96QaDymecij8Wr9fmqjhaGl/nn25Uxe/Z5ZfXYc5/4rP9iP
         4f1SqnNUes7meiQWL75qkvZOSzYhnmQer5xLLpSIMWXnfoPivu9YUyapHlVsnkemP7gk
         S2VtOEShFn1Q1KucbWIKw/Sv6c1QpKgFNmvhNGV2Y8qz4sIiCwR1XX5gTkuw5LOo/OVE
         XdZZCzv+m8i0DH9QR3orecFr2XxPzOHNkBZh5oldW5CIf9stnmPgHJvRcCb1lB3+QjyX
         fbHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=h31TnN+L;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=h31TnN+L;
       spf=pass (google.com: domain of arvindprasanna@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvindprasanna@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225v9d/VFjM8UZbF3vcDAkyd2y9FDlH9J5b2ThjVP1gGWuq0a8knsFXb8a3+in1yNIBSGc++aLMc+Gp/QDwAeLI=
MIME-Version: 1.0
In-Reply-To: <a83b79e2-3db1-efb4-9122-46708b36b58a@infradead.org>
References: <CAK-=9LoRtOjN9_jCxtHf_fLeh3NpW6KOgYNuD09PKbDkCaCajg@mail.gmail.com>
 <1519853553-10626-1-git-send-email-arvindprasanna@gmail.com> <a83b79e2-3db1-efb4-9122-46708b36b58a@infradead.org>
From: Arvind Prasanna <arvindprasanna@gmail.com>
Date: Wed, 28 Feb 2018 17:32:37 -0500
Message-ID: <CAK-=9LoB36r+xaDve7GHvGro2mAbea6TW2Eh70CvB2mneQFQpw@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Update ncurses package names for menuconfig
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a114b8b0803a2d805664d526a"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593685739916795143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114b8b0803a2d805664d526a
Content-Type: text/plain; charset="UTF-8"

Thank you very much!

Regards,

Arvind.


On Wed, Feb 28, 2018 at 4:47 PM, Randy Dunlap <rdunlap@infradead.org> wrote:

> On 02/28/2018 01:32 PM, Arvind Prasanna wrote:
> > The package name is ncurses-devel for Redhat based distros
> > and libncurses-dev for Debian based distros.
> >
> > Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>
>
> Thanks. Looks good to me.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
>
> > ---
> >
> > Changes in v3:
> > - Fix a package name in the commit message.
> >
> > Changes in v2:
> > - Add a missing echo as pointed out by one of the reviewers.
> >
> >  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh
> b/scripts/kconfig/lxdialog/check-lxdialog.sh
> > index a10bd9d..6c0bcd9 100755
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
> > +         echo " *** Install ncurses (ncurses-devel or libncurses-dev "
> 1>&2
> > +         echo " *** depending on your distribution) and try again."
> 1>&2
> >           echo " *** "
> 1>&2
> >           exit 1
> >       fi
> >
>
>
> --
> ~Randy
>

--001a114b8b0803a2d805664d526a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you very much!<div><br></div><div>Regards,</div><div=
><br>Arvind.</div><div><br></div></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Wed, Feb 28, 2018 at 4:47 PM, Randy Dunlap <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:rdunlap@infradead.org" target=3D"_blank">r=
dunlap@infradead.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><span class=3D"">On 02/28/2018 01:32 PM, Arvind Prasanna wrote:<br>
&gt; The package name is ncurses-devel for Redhat based distros<br>
&gt; and libncurses-dev for Debian based distros.<br>
&gt;<br>
&gt; Signed-off-by: Arvind Prasanna &lt;<a href=3D"mailto:arvindprasanna@gm=
ail.com">arvindprasanna@gmail.com</a>&gt;<br>
<br>
</span>Thanks. Looks good to me.<br>
<br>
Acked-by: Randy Dunlap &lt;<a href=3D"mailto:rdunlap@infradead.org">rdunlap=
@infradead.org</a>&gt;<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt; ---<br>
&gt;<br>
&gt; Changes in v3:<br>
&gt; - Fix a package name in the commit message.<br>
&gt;<br>
&gt; Changes in v2:<br>
&gt; - Add a missing echo as pointed out by one of the reviewers.<br>
&gt;<br>
&gt;=C2=A0 scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt;=C2=A0 scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/scripts/kconfig/lxdialog/<wbr>check-lxdialog.sh b/scripts=
/kconfig/lxdialog/<wbr>check-lxdialog.sh<br>
&gt; index a10bd9d..6c0bcd9 100755<br>
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
urses-devel or libncurses-dev &quot; 1&gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** depending on your d=
istribution) and try again.&quot;=C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot; *** &quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 1&gt;&amp;2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt;<br>
<br>
<br>
--<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">~Randy<br>
</font></span></blockquote></div><br></div>

--001a114b8b0803a2d805664d526a--
