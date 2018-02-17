Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AH8x224B9JoggFaTFcmzRm08aZ5kOvuZZoK6SdLmNd91X3GYbCwGkAi5tr5D8rHDGqmagzxDi53K
ARC-Seal: i=1; a=rsa-sha256; t=1518901378; cv=none;
        d=google.com; s=arc-20160816;
        b=HNKS1Bb6MbhQGnMxowmVvuHmQIHtBjniTryDmOGh6qLoUYQ6dNWSsEnP8vt4Fc2PoO
         U2CtPTHfMdsb+LbC/XGLof55Wy+jAdqmeMxHMXBDpxe9okd8cNOPTZHDm7RDW39NzLc8
         ZxadKMc5pXZRNLYZ7VNBvje5f5gT5Mn5bMmckPbE5H71Cs/KnjCsfFcY+n5Iv38GBvMe
         +n6Iu3J05Aqw/qdDvaMl/TCggikmoo0rkSBAE5h4+6TZ+kj4ZxwPxhJLi8Iu7p8PqXsI
         dJZfh+5aUaR0TV5xSTlyoBk2nUuStFkhVJgXDEC2XlLRuCbhK90ijM9LuZpAu5wKVlwg
         5BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=GLwMjEL2BG6tt8befg+VbHTBe8jxOaW6gDcyqFo9Lmg=;
        b=F7Eozfd/NSvatpT96D8KTut/QxyahtuXmnvidgzAn2v9XpSZZctcFpvrnL6z8EZ8FI
         TlupsqXS/jsfR+qWSon1dQiF2u8UrHe9NbaznW4jWY1fm3C5WaYloRrUd0n9Q1HHuQTY
         2yvbZJ71ayQ2AVafcKS/aCnz4625yCYpkm7cDjwNqr4jLUl7IMwJ5cPVKted2GrMp4PP
         o2rFkk7FzW/EZ8os21daovEseKzQ6ewxvG9FWr5Kr5Ya1Q6O3IQWEooJxLYE6cjEy5wh
         X91Pyz95m4RkyDzYkYEDkQ97NuCXUN44MUezV0RRfEx+j9Z4X0h/xbhZev0TppeGb3TQ
         WS1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
MIME-Version: 1.0
In-Reply-To: <20180217121741.GC10940@kroah.com>
References: <20180216222655.23919-1-quytelda@tamalin.org> <20180217121741.GC10940@kroah.com>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Sat, 17 Feb 2018 13:02:55 -0800
X-Gmail-Original-Message-ID: <CAFLvi22jZ8eKaJaPohLtkt=fXYETVuUGngpaHK7u3gqbaR0Ktg@mail.gmail.com>
Message-ID: <CAFLvi22jZ8eKaJaPohLtkt=fXYETVuUGngpaHK7u3gqbaR0Ktg@mail.gmail.com>
Subject: Re: [PATCH] Staging: gdm724x: tty: Fix macro argument reuse that
 could cause side-effects.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: gs051095@gmail.com, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000fd16f605656ec8c8"
X-Provags-ID: V03:K0:DhTaEIsYTlrdx9p2K4vpIOr9SJDq2o+lO45c+4AFmFmCIG2WHmJ
 W3x2OY0jjFOpC8oo4lXNfD4RBWT3dhpJqRwZVPEXnRA43UO+TTAGy2B3q4/AdQ0G6bZJSKy
 veBw6RVdnz8FN8sFcamBbz+XjZwhUzP0ZHl0v9UfUScNuz8HPdFjPSk2OQ+IG5/xKouqAZj
 hHcEVsrNoppX3A8cNlpyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:glcxPj9tpCs=:7bZ8GM050cwpcP8kMY7msJ
 JwkhMHB8apea316U4XZjpanyIIPAa0Br2A/xa5EySO38+3+ZP06D8oLj/mKE/KrEhqKsyyTp0
 k2qYyzEf2Bcq9ucQuNUNxhllHPsjG+n2Lbj+BIOWhslp5Rhk781OJvbxnKJ3Ch8kCvHH0ux4g
 Q0jrKHBbUDFulFYAfEhomsl7lkpCK5VdxMW2FeW712gFCsEptt6D7GNcIYXzo6aYgsoAhzK3L
 bLSYOI9UGDX96g0cmzMW2pGtgeFU4qHLjynBIYWb4SuGYk2ENipkp7A8l00mpLrLuCuv4aX+h
 uqY8LYSIyRv7dZQKgY7C5Jx9GplScpbuwMlWbWs+61PKDGTjhq4I3keVtkhkfyMu9iYibZnk+
 ympnsUbDgAxSh/RaJhZLDzSTSo4+1SqaP2fmNmbn+Xv6MPnS5BNOyQIejoDqnTpTR+kTPevvK
 Ta+zpnm1MCShlOJP9BQr0aWd29wlWUg6PbD/Qj5nE/t202zV5okF9dLxXO40pPl0uGn9HNsUC
 WPo3Pv73EHB8eakDAd/lsPZPXHRYOV8VoMnHL1YquRfMApr5iOoC+zFgt3bKgviZwVhlIk56p
 2rg9uX8+yTmPaN2oIxvmBGFtTIdT2Ci749ETJsqyqhtrDlKugKYau0o7ruvlimtI+9cTUCBvf
 O+p1ZRH/UPx6k4MOsVfoHttvJYZSR1fRcurVl50HIeS7528yci0vhs+R7OTmUVV8Y0opKSpFe
 aFhI8+GMdEWnX6fm807BzwnXSMCsjflb5jJDYWBhA7K4yII+QA1FtZml2qU=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592598228085944882?=
X-GMAIL-MSGID: =?utf-8?q?1592683532195352611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000fd16f605656ec8c8
Content-Type: text/plain; charset="UTF-8"

Greg,

Do you mean that the code should make the tty_dev calls explicitly where
these macros are currently used, or maybe replacing them with "real"
functions?

Thanks,
Quytelda Kahja

On Sat, Feb 17, 2018 at 4:17 AM, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Feb 16, 2018 at 02:26:55PM -0800, Quytelda Kahja wrote:
> > Fix a coding style warning from checkpatch.pl.  Use GNU extensions to
> create
> > references to the results of problem macro arguments when they are
> evaluated so
> > that they can be used safely multiple times.
> >
> > Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> > ---
> >  drivers/staging/gdm724x/gdm_tty.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/staging/gdm724x/gdm_tty.c
> b/drivers/staging/gdm724x/gdm_tty.c
> > index fc7682c18f20..73d39fa86d10 100644
> > --- a/drivers/staging/gdm724x/gdm_tty.c
> > +++ b/drivers/staging/gdm724x/gdm_tty.c
> > @@ -37,14 +37,22 @@
> >
> >  #define MUX_TX_MAX_SIZE 2048
> >
> > -#define gdm_tty_send(n, d, l, i, c, b) (\
> > -     n->tty_dev->send_func(n->tty_dev->priv_dev, d, l, i, c, b))
> > -#define gdm_tty_recv(n, c) (\
> > -     n->tty_dev->recv_func(n->tty_dev->priv_dev, c))
> > -#define gdm_tty_send_control(n, r, v, d, l) (\
> > -     n->tty_dev->send_control(n->tty_dev->priv_dev, r, v, d, l))
> > -
> > -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> > +#define gdm_tty_send(n, d, l, i, c, b)
>      \
> > +     ({ typeof(n) n_ = (n);                                          \
> > +             void *priv_dev = n_->tty_dev->priv_dev;                 \
> > +             n_->tty_dev->send_func(priv_dev, d, l, i, c, b); })
> > +#define gdm_tty_recv(n, c)                                   \
> > +     ({ typeof(n) n_ = (n);                                  \
> > +             void *priv_dev = n_->tty_dev->priv_dev;         \
> > +             n_->tty_dev->recv_func(priv_dev, c); })
> > +#define gdm_tty_send_control(n, r, v, d, l)                          \
> > +     ({ typeof(n) n_ = (n);                                          \
> > +             void *priv_dev = n_->tty_dev->priv_dev;                 \
> > +             n_->tty_dev->send_control(priv_dev, r, v, d, l); })
> > +
> > +#define GDM_TTY_READY(gdm)                                           \
> > +     ({ typeof(gdm) gdm_ = gdm;                                      \
> > +             gdm_ && gdm_->tty_dev && gdm_->port.count; })
>
> Ugh, that's a mess.  How about just replacing the use of these odd
> macros with the "real" call instead?  The fact that they are messing
> around with the tty_dev call directly is really strange and should be
> made a lot more obvious, as that probably needs to be fixed up.
>
> thanks,
>
> greg k-h
>

--000000000000fd16f605656ec8c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Greg,<div><br></div><div>Do you mean that the code should =
make the tty_dev calls explicitly where these macros are currently used, or=
 maybe replacing them with &quot;real&quot; functions?</div><div><br></div>=
<div>Thanks,</div><div>Quytelda Kahja</div></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Sat, Feb 17, 2018 at 4:17 AM, Greg KH <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:gregkh@linuxfoundation.org" target=3D=
"_blank">gregkh@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Fri, Feb 16, 20=
18 at 02:26:55PM -0800, Quytelda Kahja wrote:<br>
&gt; Fix a coding style warning from <a href=3D"http://checkpatch.pl" rel=
=3D"noreferrer" target=3D"_blank">checkpatch.pl</a>.=C2=A0 Use GNU extensio=
ns to create<br>
&gt; references to the results of problem macro arguments when they are eva=
luated so<br>
&gt; that they can be used safely multiple times.<br>
&gt;<br>
&gt; Signed-off-by: Quytelda Kahja &lt;<a href=3D"mailto:quytelda@tamalin.o=
rg">quytelda@tamalin.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/gdm724x/gdm_<wbr>tty.c | 24 ++++++++++++++++----=
----<br>
&gt;=C2=A0 1 file changed, 16 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/staging/gdm724x/gdm_<wbr>tty.c b/drivers/staging/=
gdm724x/gdm_<wbr>tty.c<br>
&gt; index fc7682c18f20..73d39fa86d10 100644<br>
&gt; --- a/drivers/staging/gdm724x/gdm_<wbr>tty.c<br>
&gt; +++ b/drivers/staging/gdm724x/gdm_<wbr>tty.c<br>
&gt; @@ -37,14 +37,22 @@<br>
&gt;<br>
&gt;=C2=A0 #define MUX_TX_MAX_SIZE 2048<br>
&gt;<br>
&gt; -#define gdm_tty_send(n, d, l, i, c, b) (\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0n-&gt;tty_dev-&gt;send_func(n-&gt;tty_<wbr>dev-&g=
t;priv_dev, d, l, i, c, b))<br>
&gt; -#define gdm_tty_recv(n, c) (\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0n-&gt;tty_dev-&gt;recv_func(n-&gt;tty_<wbr>dev-&g=
t;priv_dev, c))<br>
&gt; -#define gdm_tty_send_control(n, r, v, d, l) (\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0n-&gt;tty_dev-&gt;send_control(n-&gt;<wbr>tty_dev=
-&gt;priv_dev, r, v, d, l))<br>
&gt; -<br>
&gt; -#define GDM_TTY_READY(gdm) (gdm &amp;&amp; gdm-&gt;tty_dev &amp;&amp;=
 gdm-&gt;port.count)<br>
&gt; +#define gdm_tty_send(n, d, l, i, c, b)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0({ typeof(n) n_ =3D (n);=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *priv_dev =3D n_=
-&gt;tty_dev-&gt;priv_dev;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n_-&gt;tty_dev-&gt;se=
nd_func(priv_<wbr>dev, d, l, i, c, b); })<br>
&gt; +#define gdm_tty_recv(n, c)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0({ typeof(n) n_ =3D (n);=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *priv_dev =3D n_=
-&gt;tty_dev-&gt;priv_dev;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n_-&gt;tty_dev-&gt;re=
cv_func(priv_<wbr>dev, c); })<br>
&gt; +#define gdm_tty_send_control(n, r, v, d, l)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0({ typeof(n) n_ =3D (n);=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *priv_dev =3D n_=
-&gt;tty_dev-&gt;priv_dev;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n_-&gt;tty_dev-&gt;se=
nd_control(<wbr>priv_dev, r, v, d, l); })<br>
&gt; +<br>
&gt; +#define GDM_TTY_READY(gdm)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0({ typeof(gdm) gdm_ =3D gdm;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdm_ &amp;&amp; gdm_-=
&gt;tty_dev &amp;&amp; gdm_-&gt;port.count; })<br>
<br>
</div></div>Ugh, that&#39;s a mess.=C2=A0 How about just replacing the use =
of these odd<br>
macros with the &quot;real&quot; call instead?=C2=A0 The fact that they are=
 messing<br>
around with the tty_dev call directly is really strange and should be<br>
made a lot more obvious, as that probably needs to be fixed up.<br>
<br>
thanks,<br>
<br>
greg k-h<br>
</blockquote></div><br></div>

--000000000000fd16f605656ec8c8--
