Return-Path: <kstewart@linuxfoundation.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524151812; cv=none;
        d=google.com; s=arc-20160816;
        b=ez0U4bCF6JEm5hNPv4lbfBsFdVJ8kCYmv0FWQX982BAFJo2X1s23GQRLGMiU1RFebc
         ePDJqtbQbG9lHKn9Shokk+9Bz1AVY6MT0PnBBwOePBC1d8MUkIBl8Xm8GsA103BL3ZFy
         1FA1zMnAoZYljCd5xjkbb4V0F+UTzM7UKXNNoURAXgCA9NkF/yc9tmAEh8JomDr/2Ddr
         Z6DEXPwqr0Slmwybmn4j/H3r3Xd9N8cnhMNXzzRLk7KyWE+Y8QfdPXhGscM/AyEEtCWe
         ANr8Iegaluh1gSFFHpqGQ9MNWixIR9+UOhc7c6pPYTskaxHs6ocvvTKi5RfV51sXJIjg
         RgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=sO447qH98193U84VTwKxwXr79Elgc1xtanmJkmbIQNM=;
        b=jybYDpVsGOB5DqkJU2uvUT7vkrdC7pGRf6cDHR40TUaPe1qV85ArO/0Q8mMFboDl8I
         M6BDdS9ezFrHejcR3Vl1Nwow10+b378vJVUpoqdIVQI91qnorCeg0XmU9wONA6yZ7WT4
         tN/YPEUOdex74hZi1l3mM4MFZjr7+3++Q3WvNPwQesZJkdnZxF4L7QLnD0m+Ed5Wawzr
         I1d9/4eksPpZEHoMv6A6HS/OgVznQRywO50uBsY58k4vS6L2tz2ZfQJDQ6VwKqjqWCHM
         JHTeoDIBRCfVC14Sha3SG6Kq+jucqRE/itqA9O6fWOCeXUOkbAXPuIHkJToDhJYSZRsK
         L39A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CuiftbLA;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CuiftbLA;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
X-Google-Smtp-Source: AB8JxZpL49dV0/DmFRjXEPd+4IvotN6pGzQ+h9RVCc632rAVb+HSPHBjLrM71XoXP2JChdvbFCfDwX2IUPMVZN4LDfg=
MIME-Version: 1.0
In-Reply-To: <20180419100935.093663398@linutronix.de>
References: <20180419100441.548834519@linutronix.de> <20180419100935.093663398@linutronix.de>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Thu, 19 Apr 2018 10:30:10 -0500
Message-ID: <CAG_66ZRTUL3m4kCRm3O9g37WSrJBbiE67zYBUBAriwDAa9cKvQ@mail.gmail.com>
Subject: Re: [patch V2 4/8] rslib: Remove GPL boilerplate
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Andrew Morton <akpm@linuxfoundation.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>,
	David Woodhouse <dwmw2@infradead.org>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
	Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000005ae9ec056a353fcc"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168888356942839?=
X-GMAIL-MSGID: =?utf-8?q?1598189011065952415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--0000000000005ae9ec056a353fcc
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 19, 2018 at 5:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> Now that SPDX identifiers are in place, remove the GPL boiler plate
> text. Leave the notices which document that Phil Karn granted permission in
> place (encode/decode source code). The modified files are code written for
> the kernel by me.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Andrew Morton <akpm@linuxfoundation.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Alasdair Kergon <agk@redhat.com>
>

 Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>

--0000000000005ae9ec056a353fcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Apr 19, 2018 at 5:04 AM, Thomas Gleixner <span dir=3D"ltr">&lt;=
<a href=3D"mailto:tglx@linutronix.de" target=3D"_blank">tglx@linutronix.de<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Thomas Gleixn=
er &lt;<a href=3D"mailto:tglx@linutronix.de">tglx@linutronix.de</a>&gt;<br>
<br>
Now that SPDX identifiers are in place, remove the GPL boiler plate<br>
text. Leave the notices which document that Phil Karn granted permission in=
<br>
place (encode/decode source code). The modified files are code written for<=
br>
the kernel by me.<br>
<br>
Signed-off-by: Thomas Gleixner &lt;<a href=3D"mailto:tglx@linutronix.de">tg=
lx@linutronix.de</a>&gt;<br>
Cc: Boris Brezillon &lt;<a href=3D"mailto:boris.brezillon@free-electrons.co=
m">boris.brezillon@free-<wbr>electrons.com</a>&gt;<br>
Cc: Tony Luck &lt;<a href=3D"mailto:tony.luck@intel.com">tony.luck@intel.co=
m</a>&gt;<br>
Cc: Kees Cook &lt;<a href=3D"mailto:keescook@chromium.org">keescook@chromiu=
m.org</a>&gt;<br>
Cc: Segher Boessenkool &lt;<a href=3D"mailto:segher@kernel.crashing.org">se=
gher@kernel.crashing.org</a>&gt;<br>
Cc: Kernel Hardening &lt;<a href=3D"mailto:kernel-hardening@lists.openwall.=
com">kernel-hardening@lists.<wbr>openwall.com</a>&gt;<br>
Cc: Richard Weinberger &lt;<a href=3D"mailto:richard@nod.at">richard@nod.at=
</a>&gt;<br>
Cc: Mike Snitzer &lt;<a href=3D"mailto:snitzer@redhat.com">snitzer@redhat.c=
om</a>&gt;<br>
Cc: Anton Vorontsov &lt;<a href=3D"mailto:anton@enomsg.org">anton@enomsg.or=
g</a>&gt;<br>
Cc: Greg Kroah-Hartman &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">gr=
egkh@linuxfoundation.org</a>&gt;<br>
Cc: Colin Cross &lt;<a href=3D"mailto:ccross@android.com">ccross@android.co=
m</a>&gt;<br>
Cc: Andrew Morton &lt;<a href=3D"mailto:akpm@linuxfoundation.org">akpm@linu=
xfoundation.org</a>&gt;<br>
Cc: David Woodhouse &lt;<a href=3D"mailto:dwmw2@infradead.org">dwmw2@infrad=
ead.org</a>&gt;<br>
Cc: Alasdair Kergon &lt;<a href=3D"mailto:agk@redhat.com">agk@redhat.com</a=
>&gt;<br></blockquote><div><br></div><div>=C2=A0<span style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
Reviewed-by:=C2=A0<span style=3D"color:rgb(80,0,80);font-family:arial,sans-=
serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font=
-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;ba=
ckground-color:rgb(255,255,255);text-decoration-style:initial;text-decorati=
on-color:initial;float:none;display:inline">Kate Stewart &lt;</span><a href=
=3D"mailto:kstewart@linuxfoundation.org" style=3D"color:rgb(17,85,204);font=
-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255)">kstewart@linuxfoundatio=
n.org</a><span style=3D"color:rgb(80,0,80);font-family:arial,sans-serif;fon=
t-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;float:none;display:inline">&gt;</span></span></div></div></div></di=
v>

--0000000000005ae9ec056a353fcc--
