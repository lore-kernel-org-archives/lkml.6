Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524475026; cv=none;
        d=google.com; s=arc-20160816;
        b=upy2p/8XF9gYhUiKaGl9AS5gLe6XhGhvISeMxNR2u5DfjUOJPWVS9yWmmY834Afbhp
         QhSB+v8hENfxaGYRIFSCsFtzXcGSvkT6f1dRNuVv7daFEi1/OJtl0Lj1BDXd5tW31iFT
         8mZKzGOwMSwN0zwa44yWDlNHitdth6jQEZ/u0Ck61+JbScgBhtvF+3uYj7keijZ4ZdiW
         zxzjBoLT+tbAWklsR8eHd20ap0MHeTRHablsqe/rwHJ2YIq5IkLZW3SZfhQfSeMbdf4U
         kQwmyc8JsD02OW+caHX8TJ3Jbi2DYoysRHDLMxUawywG1a1FL6yUbgHe9UOicf3/XVLW
         mjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Dj6G4sWQIOdTUv456Hg32fFGf95o21f+PGBIDi6aBMs=;
        b=xclM5cClB0ekpEICrMIYoTUtOWUsY0f7HSKlzSTk4VWG+/rMNXoVwNfCKsfwJPTAB1
         dAUrWXmKPnXIIQUYrqIYsH5A0nu4/qRYXyxX9+MFhT/knbs4O7dCDIaD8GtZJkwZeWy2
         zfgEZfG/UZcefSxhjCpyZCmjEF1mgRFBeBgHnkZxIsOzaujAM5MgnlF+/6CousXfIO97
         VC5nxVfzXh45Q9C0baDHpD35uMFSwGF/P6Bd43mjZqRtPaYm7YcjNL8bWXuCr9l6pTws
         TN0sX3MB4R8XL6Vqq+N41AdoczDaey5rjFXbH1TaWG8YLz2XLZMfy9opoN5Fb++ananx
         5TrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r4vop+Lw;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r4vop+Lw;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx49lLHSQK9iSG4HIE8dHGGZrmeTKOgYQEwjtMGvMaXa4C2SIchzzihF1H19eiUmfeWPpDqwXGK+ZHFH4ZGcu2HI=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180422220832.899282023@linutronix.de>
References: <20180422220208.772527041@linutronix.de> <20180422220832.899282023@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 11:17:05 +0200
X-Google-Sender-Auth: Br5MjuCHg4-8LLiQm6dcqoTleJE
Message-ID: <CAMuHMdVgcjOenYvD8iPTyHa-z4oqqDiMpijdDePgN=qPvp-3Dg@mail.gmail.com>
Subject: Re: [patch 2/9] pinctrl: sh-pfc: r8a77965: Fixup incorrect SPDX identifier
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>, Rob Herring <robh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486094497167491?=
X-GMAIL-MSGID: =?utf-8?q?1598527925579180325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 12:02 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> GPL-2. is not a valid SPDX identifier. Make it GPL-2.0
>
> Fixes: 490e687eb8b2 ("pinctrl: sh-pfc: Initial R-Car M3-N support")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in sh-pfc-for-v4.18.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
