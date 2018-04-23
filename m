Return-Path: <kstewart@linuxfoundation.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524507868; cv=none;
        d=google.com; s=arc-20160816;
        b=ydJ6bPHlLc3c+8ZdqJkjqG6olzd65PhiPUEsNS80gIj8mWVdzB0zjoh7jrTTAgbKiT
         7jbotEATjlHja8ky+t/KcrVPSLUutv+FGCet2LIPK6B85MjFoxOUEEqP/GoVZJUeirbl
         VPmShko8ESNUHZ2/c1VAtglapr6tFgtcbBqvsqJZRRneuSJrDFPKbsPeAxahuku5SqtR
         DpXcMYwRtD8jLXn4Fcn50CDJMFLPqrph7K4R9yanTEGG/BCMaJC3e/0cT+TXxFL3Addj
         g17XWMyQMwExKpkYygTFYnWB6LCTkXHEOxVTKskIMeD13P/etnvsaMIee0WXvL1FGhBV
         TSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7rIft0ORR6OOOaa+ft5CqDxCcS79vc2wC2mXCFOA/20=;
        b=UTv08JD73u2La5Aa1Xo8rTRfIVu+c+NC53znNITuJFTjNHGNUnCG7EPRuM6vJnzwRb
         vjsLslMtPTfQbmh9GMMUrkVBaFOFQfwIRnZ2xt2/i65ps6K+piWddsLSFJQx4PkqXoAp
         zkeN/NWzUSYBz0K0opWdn/BqBYWDvwHD+rNqf7PcONhNiW2rPOrp+btV/cqRpvAB9sZD
         A695z2qttMkX/QmgFJ7bOuof1BIpctjK5fxE4wMXa6a7bk8jEUlmkNcRqapYykO47/Qn
         lbA3v3m1JYUZM3F4vXdf14zMF2Sx6m0tkp5DXkhaABHQYGm7SXCFLoHz92SWRGU5dXTl
         /L1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OWlowKzN;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OWlowKzN;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
X-Google-Smtp-Source: AB8JxZqqRPLNjeTtktVaJiTqKucFcEoCCBsJ/gisPII0WIWZHVjSKW2IKIkyS5S0tMdOTDNQAB0bf6KXDGJftfj0YbM=
MIME-Version: 1.0
In-Reply-To: <20180422220833.078058446@linutronix.de>
References: <20180422220208.772527041@linutronix.de> <20180422220833.078058446@linutronix.de>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Mon, 23 Apr 2018 13:24:27 -0500
Message-ID: <CAG_66ZR+17vLOE+EfmTMktjG4uQragZYqOeNR0t2OkzWoLZoUg@mail.gmail.com>
Subject: Re: [patch 4/9] LICENSES/GPL2.0: Add GPL-2.0-only/or-later as valid identifiers
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Content-Type: multipart/alternative; boundary="000000000000f2ee01056a882566"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486097354490733?=
X-GMAIL-MSGID: =?utf-8?q?1598562363101290991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000f2ee01056a882566
Content-Type: text/plain; charset="UTF-8"

On Sun, Apr 22, 2018 at 5:02 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Quite some files have been flagged with the new GPL-2.0-only and
> GPL-2.0-or-later identifiers which replace the original GPL-2.0 and
> GPL-2.0+ identifiers in the SPDX license identifier specification, but the
> identifiers are not mentioned as valid in the GPL-2.0 license file.
>
> Add them to make everything consistent again.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Feel free to add my:

 Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>

Thanks, Kate

--000000000000f2ee01056a882566
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Sun, Apr 22, 2018 at 5:02 PM, Thomas Gleixner &lt;<a hr=
ef=3D"mailto:tglx@linutronix.de">tglx@linutronix.de</a>&gt; wrote:<br>&gt;<=
br>&gt; Quite some files have been flagged with the new GPL-2.0-only and<br=
>&gt; GPL-2.0-or-later identifiers which replace the original GPL-2.0 and<b=
r>&gt; GPL-2.0+ identifiers in the SPDX license identifier specification, b=
ut the<br>&gt; identifiers are not mentioned as valid in the GPL-2.0 licens=
e file.<br>&gt;<br>&gt; Add them to make everything consistent again.<br>&g=
t;<br>&gt; Signed-off-by: Thomas Gleixner &lt;<a href=3D"mailto:tglx@linutr=
onix.de">tglx@linutronix.de</a>&gt;<br>&gt; Cc: Hans Verkuil &lt;<a href=3D=
"mailto:hans.verkuil@cisco.com">hans.verkuil@cisco.com</a>&gt;<br>&gt; Cc: =
Mauro Carvalho Chehab &lt;<a href=3D"mailto:mchehab@s-opensource.com">mcheh=
ab@s-opensource.com</a>&gt;<br><br>Feel free to add my:<div><br>=C2=A0Revie=
wed-by: Kate Stewart &lt;<a href=3D"mailto:kstewart@linuxfoundation.org">ks=
tewart@linuxfoundation.org</a>&gt;</div><div><br></div><div>Thanks, Kate</d=
iv></div>

--000000000000f2ee01056a882566--
