Return-Path: <adurbin@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521047400; cv=none;
        d=google.com; s=arc-20160816;
        b=Q++pA3XkYWUSVae7SgAX9BSjTbnDfoc65EyWSbiiLIAOS0TJpuvL7NjqoTajfa7p5B
         0zd2Up5euEcrpZlk3Vj/OVAJjhwbvFQ+WJHrjKlhmEEDt7L/GpQz1rYo6NIdas/lQW4G
         5iCtWsT5rQKB6ofjBKO3+58TQaFaaXRI/8AEzuV1Vtws/oiI17TVQgIGLnpLfnUxC1ff
         EoWr6/Hrc9nZ+31pqb0r5WFAM2NiNoObodZptqI8YxAXqUEDrjoxfjL6LNzW/AA0BcmH
         YlLgKndZZBI8QIUgaB7rwlOm0Rf8OrO1UGvLtVkXcqp48NkcFlmS2Qz8tb6zatVlZ607
         SB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=SDsvRoiMFfNzHvp0i1qUvbronxi/WZb4l3zimw0D7n0=;
        b=IaqptYvXnE1cbnM2xKA0E2zeLfKSGxswAUdWOLRTYA1skUtFqoWYFoobNoOAHikEmo
         fiOTJHLztH/IT8BeMH6OzmFvWCic5LucR9rpD6RF6CsVOWPz4ouOZ+kLN7cjBnpxiTWD
         Rfw+5iR1N7h+04TWNiL4h+bZQGzZ98nIvnJTOp4IlMiCAt311J6Yhj+W11CBWG2AgXqq
         Ft0pB3ev9ovzR57YJT1elAO22EuWaMrK42QKwYajfGeHEuwZVNanwFpl5B5YiIYcMfz2
         R4wB/8YIOsJCBfGlIJIGJuyFF+YMZg8a/rAK44XCI9jLp8FLaOKQSr1NNrnLI6b8IdMt
         kInQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=P3yhnMW/;
       dkim=pass header.i=@chromium.org header.s=google header.b=D5w14CS0;
       spf=pass (google.com: domain of adurbin@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=adurbin@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=P3yhnMW/;
       dkim=pass header.i=@chromium.org header.s=google header.b=D5w14CS0;
       spf=pass (google.com: domain of adurbin@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=adurbin@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtdzLZRXZUfDyfi40JDIFL9uTBxQIWc4Tb8/SMsAkQxcdTbJG9hj0+gQy9G76aH2QPmdYgRl3V7QXdmltY2OqU=
MIME-Version: 1.0
Sender: adurbin@google.com
In-Reply-To: <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
 <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com> <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
From: Aaron Durbin <adurbin@chromium.org>
Date: Wed, 14 Mar 2018 11:09:58 -0600
X-Google-Sender-Auth: IOVymhNT-9YDEK1QKwWOVnAeOGE
Message-ID: <CAE2855u0NhRNkwuro74HvNZdhLD+Fh+C8DkNXWMc88AK7UNu1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Aaron Durbin <adurbin@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Doug Anderson <dianders@chromium.org>,
	Matt Redfearn <matt.redfearn@mips.com>, Jeffy <jeffy.chen@rock-chips.com>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="001a114c8966ef505e056762717f"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594871326006513106?=
X-GMAIL-MSGID: =?utf-8?q?1594933798823337963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114c8966ef505e056762717f
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 14, 2018 at 10:38 AM, Andy Shevchenko <andy.shevchenko@gmail.com
> wrote:

> On Wed, Mar 14, 2018 at 6:29 PM, Daniel Kurtz <djkurtz@chromium.org>
> wrote:
> > On Wed, Mar 14, 2018 at 4:54 AM Ricardo Ribalda Delgado <
> > ricardo.ribalda@gmail.com> wrote:
> >> On Wed, Mar 14, 2018 at 1:36 AM, Daniel Kurtz <djkurtz@chromium.org>
> > wrote:
>
> > In fact, the recommended way is to have firmware specify an ACPI SPCR
> table
> > with OEMID="AMDCZ " (see https://patchwork.kernel.org/patch/10281307/)
> to
> > configure proper access and address.
>
> Hmm... I was thinking it's already there. And thus, this is just a
> quirk for *existing* firmware that doesn't correctly configured
> hardware.
> (Yes, I'm aware about one nuance in SPCR specification I'm trying to
> address via official ways)
>

What is "it's" in your first sentence? The access method? Baud rate can't
be configured ever in the kernel w/o knowing the input clock to the uart
block. That's already been brought up, and it is inherently a requirement
to know that to recalculate the divisor. These patches are doing early OOB
binding to set the proper input clock because: 1. SPCR doesn't have that
information 2. you nak'd the generic way of specifying the input clock on
the command line. Sadly, this situation is not unique to this hardware.
There is hardware all over that does not meet the current assumptions being
made in the early uart drivers within the kernel.

--001a114c8966ef505e056762717f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Mar 14, 2018 at 10:38 AM, Andy Shevchenko <span dir=3D"ltr">&lt=
;<a href=3D"mailto:andy.shevchenko@gmail.com" target=3D"_blank">andy.shevch=
enko@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><spa=
n class=3D"">On Wed, Mar 14, 2018 at 6:29 PM, Daniel Kurtz &lt;<a href=3D"m=
ailto:djkurtz@chromium.org">djkurtz@chromium.org</a>&gt; wrote:<br>
&gt; On Wed, Mar 14, 2018 at 4:54 AM Ricardo Ribalda Delgado &lt;<br>
&gt; <a href=3D"mailto:ricardo.ribalda@gmail.com">ricardo.ribalda@gmail.com=
</a>&gt; wrote:<br>
</span><span class=3D"">&gt;&gt; On Wed, Mar 14, 2018 at 1:36 AM, Daniel Ku=
rtz &lt;<a href=3D"mailto:djkurtz@chromium.org">djkurtz@chromium.org</a>&gt=
;<br>
&gt; wrote:<br>
<br>
</span><span class=3D"">&gt; In fact, the recommended way is to have firmwa=
re specify an ACPI SPCR table<br>
&gt; with OEMID=3D&quot;AMDCZ &quot; (see <a href=3D"https://patchwork.kern=
el.org/patch/10281307/" rel=3D"noreferrer" target=3D"_blank">https://patchw=
ork.kernel.org/<wbr>patch/10281307/</a>) to<br>
&gt; configure proper access and address.<br>
<br>
</span>Hmm... I was thinking it&#39;s already there. And thus, this is just=
 a<br>
quirk for *existing* firmware that doesn&#39;t correctly configured<br>
hardware.<br>
(Yes, I&#39;m aware about one nuance in SPCR specification I&#39;m trying t=
o<br>
address via official ways)<br></blockquote><div><br></div><div>What is &quo=
t;it&#39;s&quot; in your first sentence? The access method? Baud rate can&#=
39;t be configured ever in the kernel w/o knowing the input clock to the ua=
rt block. That&#39;s already been brought up, and it is inherently a requir=
ement to know that to recalculate the divisor. These patches are doing earl=
y OOB binding to set the proper input clock because: 1. SPCR doesn&#39;t ha=
ve that information 2. you nak&#39;d the generic way of specifying the inpu=
t clock on the command line. Sadly, this situation is not unique to this ha=
rdware. There is hardware all over that does not meet the current assumptio=
ns being made in the early uart drivers within the kernel.</div></div><br><=
/div></div>

--001a114c8966ef505e056762717f--
