Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48+WToOXLzD+PTwDbeFoOtNw6czO5OtwiY+A/m00xb4IOKj88yffc3JzPMuw+r91JP2k7Bj
ARC-Seal: i=1; a=rsa-sha256; t=1522692554; cv=none;
        d=google.com; s=arc-20160816;
        b=fy9dNgNP/+hPqzoP/1Z5H8Nlj5iQtNY3nSB6FlRX69nEO6w21/wwHAATAvUOH0ezxv
         Q1UKiLxjbROfaVbHESO+9rt23MkJJqO3T5O/WyAVZ9FZr0asISnrNMi6Lsg/A90wzrCJ
         vkT5bUn9b/koytm/zDWZiBIboJYejnr11g4PvQT5KTdyndRvIICF0xXzq8O+rz9M9yuR
         EaZJIfU7lGGlYIjASeB1ptCttUCz5VZhf4xXJBAkRIJYWQags/SqcFVvs/e0SnTBcv2n
         v8sKsfLatVrXbpFEKQx65vbI+zrPNYiXPM2DwLRuFR63lX++Z5AoSG62+pOoRSmfrxQG
         Hg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:arc-authentication-results;
        bh=wbdi5R0ChKDxJWx0OM+i0u2vM8Q8tbnCXFApt7PnBz8=;
        b=PClF9iA3xpa2vxcRzI9uunvq4HpDjIgpKl0oZPwLo1FHOgkA3nC7H1BPuLVnThO0U/
         oLvULYdh2l+Aa2IJs71EsWOgmA0f4KefPWbyonAKBRqDLxbUJEdbzWfRaOaTqRqtHzkM
         U24SwjBdSNsvDSPr+rmdumJMkXJHcxlvHoAaE3ix6CJw120PSHtXxhMw1sRWL1y7Cuj8
         aGEqcMhnixPbAvabhPrZoxMh5oLaCteqHYp7/I5HDKOsMgjEd5BxTY6//X3qcwKZHx75
         AkokFr/7S5uCk/l7k6XIM2bL9FABlxEJbG2B9thL16hCB8NYnF7a+psbq9JDN6gIkmxI
         ykeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
MIME-Version: 1.0
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org> <1522478173.2210.53.camel@perches.com>
 <20180331084150.e6uottdsdagtywbp@mwanda> <1522505573.11653.1.camel@perches.com>
 <20180402114538.slvlts3djle4mqev@mwanda> <1522681020.11653.25.camel@perches.com>
In-Reply-To: <1522681020.11653.25.camel@perches.com>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Mon, 02 Apr 2018 18:09:01 +0000
X-Gmail-Original-Message-ID: <CAFLvi21bCaWd2bpfqDJkgLwjnRb=HwWU7jd8+bounwqCq+GFgQ@mail.gmail.com>
Message-ID: <CAFLvi21bCaWd2bpfqDJkgLwjnRb=HwWU7jd8+bounwqCq+GFgQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/75] staging: ks7010: Use the ARRAY_SIZE() macro to
 calculate array sizes.
To: Joe Perches <joe@perches.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, devel@driverdev.osuosl.org, wsa@the-dreams.de,
	gregkh@linuxfoundation.org, driverdev-devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="f403045cde6ca8b5920568e17cde"
X-Provags-ID: V03:K0:uiiAQ7TXtRliIv/J6xhJKIRUzE2ZApntEiza/GpZyEYmQ8oXeqq
 3Pd+gKxu3eFwhI9kI5Vrt0ZLeZiugY/0u8kQJhoG6fdqlJ85oQislR8Zr+192sekqghYIZm
 OsYSkthPJQ+4/dLSxlAhHlA5jIVCCHuO0Fa0kGPG3AvbC82UyPXt9As9H9EAXT4ym6Fzdzs
 c4Wvi9Ii7vhk4s5VCwfHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yaSkm8B9AJQ=:XGHq3RLyX4sgozh6ylDMcp
 r9cZl630MwhFWxqpsKLAUYVGkITT4kGi9gAfIQ/1JHujDybKnWggLSSKyt9b9w/DkqotqjWuO
 u0CDAPsVtnaVtM2KXN2esvBXJsLSqnJV/xyhs27mUEVUqwwlpw+X1JvJn5bslrnpnuoXAtyq7
 fNX4f6hhV3zipZyb9Fk07LbVyCXNhWhfCg29g5pqtofMxle/SEL7LL3NOLm+X9fMk9rAN/lJH
 WxZPJdFw5HcVS5obVu7nzoS8XptPy0BS4oNAXP/k7lQDUJYDywcOVdojb3r6YM2lAZO9luIzY
 7mo1t/1ZAuIhhSc8FFmCTr1utmxShHqtVBKs1pBugCKcyoIyK8DXeJNeivUkQSN9+e84lZab2
 a7GRrQ1Mwu1rDfkOqbRGQCfyhN3Lq1mqi4Ua90SitIApTrtjromtZdmellnlkEr31oklDUoTo
 guw2xz/7tMGaFd7yXBTyYqhlcL0UBSulQ1Nc1WojYhxGWyZNsflETPPKW7FTGRw7WgF32ktfl
 4WiJgQCc38WpBytolDw9thCDFgLSqVn01M0Rw/1/awRoaJgJI9KD/5gmjTNzOuq1UkNTwZ3v9
 m8QtxnO6ZaDoW02yeR1WBVXZDfxx0YL49ojUrjKWHw87P1wIdxgllNZovfkyuAC58IjOioiV0
 lQDWOiIMbSNWTgiXtJSYl15mcAobW45Cfp2c6m0ITCGTcrLlTJ9++HXWD1ENOq9gncLHUj0em
 98YKcXWVXXoDuLJjBB7hbIdT6hgzNqzv/U+tJPjhAJs7rhz7Qrn5XwqAjvw=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432385681826765?=
X-GMAIL-MSGID: =?utf-8?q?1596658867344026957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--f403045cde6ca8b5920568e17cde
Content-Type: text/plain; charset="UTF-8"

Thank you for the suggestions and support, both of you.  I realize that 75
patches is a lot, but the majority of them are all a part of one change
set: fixing the structures in the driver as suggested by Greg KH in
response to other patches I sent in.  He asked me to do them all
separately, so that's why there's so many.  Dan, I see you've found some
small issues with some of the patches that I missed; I will ammend those
when I get the chance and send a v3 series with a cover letter.  However, I
am about to get on a 8hrs of flights so I'm not sure when that will be.

Thank you,
Quytelda Kahja

On Mon, Apr 2, 2018, 07:57 Joe Perches <joe@perches.com> wrote:

> On Mon, 2018-04-02 at 14:45 +0300, Dan Carpenter wrote:
> > On Sat, Mar 31, 2018 at 07:12:53AM -0700, Joe Perches wrote:
> > > On Sat, 2018-03-31 at 11:41 +0300, Dan Carpenter wrote:
> > > > On Fri, Mar 30, 2018 at 11:36:13PM -0700, Joe Perches wrote:
> > > > > On Fri, 2018-03-30 at 23:07 -0700, Quytelda Kahja wrote:
> > > > > > This macro, provided in 'linux/kernel.h', will calculate the size
> > > > > > more succinctly than a division operation.
> > > > >
> > > > > It's nice that you send patches, but please try to send a
> > > > > cover letter with your patch series.
> > > > >
> > > >
> > > > There are obviously times when a cover letter is required but what's
> the
> > > > point of that for this particular series?
> > >
> > > practice
> > >
> > It really pisses me off to see patch submitters get assign busy work
> > for no reason.  This is not school and these are not your students.
>
> Please take a chill pill Dan.
> I think cover letters are best practice.
>
>

--f403045cde6ca8b5920568e17cde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"font-family:sans-serif">Thank you for the =
suggestions and support, both of you.=C2=A0 I realize that 75 patches is a =
lot, but the majority of them are all a part of one change set: fixing the =
structures in the driver as suggested by Greg KH in response to other patch=
es I sent in.=C2=A0 He asked me to do them all separately, so that&#39;s wh=
y there&#39;s so many.=C2=A0 Dan, I see you&#39;ve found some small issues =
with some of the patches that I missed; I will ammend those when I get the =
chance and send a v3 series with a cover letter.=C2=A0 However, I am about =
to get on a 8hrs of flights so I&#39;m not sure when that will be.</span><d=
iv dir=3D"auto" style=3D"font-family:sans-serif"><br></div><div dir=3D"auto=
" style=3D"font-family:sans-serif">Thank you,</div><div dir=3D"auto" style=
=3D"font-family:sans-serif">Quytelda Kahja</div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr">On Mon, Apr 2, 2018, 07:57 Joe Perches &lt;<a hr=
ef=3D"mailto:joe@perches.com" target=3D"_blank" rel=3D"noreferrer">joe@perc=
hes.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, 2018=
-04-02 at 14:45 +0300, Dan Carpenter wrote:<br>
&gt; On Sat, Mar 31, 2018 at 07:12:53AM -0700, Joe Perches wrote:<br>
&gt; &gt; On Sat, 2018-03-31 at 11:41 +0300, Dan Carpenter wrote:<br>
&gt; &gt; &gt; On Fri, Mar 30, 2018 at 11:36:13PM -0700, Joe Perches wrote:=
<br>
&gt; &gt; &gt; &gt; On Fri, 2018-03-30 at 23:07 -0700, Quytelda Kahja wrote=
:<br>
&gt; &gt; &gt; &gt; &gt; This macro, provided in &#39;linux/kernel.h&#39;, =
will calculate the size<br>
&gt; &gt; &gt; &gt; &gt; more succinctly than a division operation.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; It&#39;s nice that you send patches, but please try to =
send a<br>
&gt; &gt; &gt; &gt; cover letter with your patch series.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There are obviously times when a cover letter is required bu=
t what&#39;s the<br>
&gt; &gt; &gt; point of that for this particular series?<br>
&gt; &gt;<br>
&gt; &gt; practice<br>
&gt; &gt;<br>
&gt; It really pisses me off to see patch submitters get assign busy work<b=
r>
&gt; for no reason.=C2=A0 This is not school and these are not your student=
s.<br>
<br>
Please take a chill pill Dan.<br>
I think cover letters are best practice.<br>
<br>
</blockquote></div>

--f403045cde6ca8b5920568e17cde--
