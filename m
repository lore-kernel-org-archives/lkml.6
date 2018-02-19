Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AH8x227EoB2Bu24C5L4H91hKOvGi2YvDpEOhhPtR9x9vt/GHmSWo6XXB3+acyn9z6+YI7hyFsa+7
ARC-Seal: i=1; a=rsa-sha256; t=1519050748; cv=none;
        d=google.com; s=arc-20160816;
        b=SnXHRTvwBt78elAIS7bXUuDbOgmnZ6vxeU2vaNVYUBzHXK62HBdGIwFW47zs9eq9UX
         OrifZyxjCXUj4vTGlbgFmAzsmy9xZq9RNOUKyFFB1crFkSUrDcNBhZtThVuXU42t8sLM
         Ev6EMR5jlgjCV0I0oc+moyIbKVGw0iukHZozB75mrbLYR0eGiDGHIcZ/sL4b8iasnfmV
         /MCLmqLe8g/cbsfewgMVpnTUUjgtiWVPL8ewxxW14T0rj0yHsRIOB0WqvI2S3v0O7vvC
         dyzx1Fvag0+8OKzMHA6lD9L+ZT0F4m+GCbqCEA2eHIj03hmYOJ4pdyZNWCeI7S4wTPIx
         QQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0CIAANiQtw+LeH4NihEJ2AkVyeDSTOix6nQCq4G6rmU=;
        b=EqFDNvHNj0Wo5Myd5DjDcsHvFzWumEBWym+hFUix/tFPxqOYzgTCpdMQP+hIU1d5ZE
         9eMbrl6Xjkd2rEo5eVDosNEkwKjFLBSGE5Ah/4Qa01r9kPG3AX3O55tjTgpWzBuDZIkt
         Z+zeOocK7+AtpqFKLrvZDLZlfUs2edlavOUQ3b7fbfnN4KWCg/azDC6FW9q9JYldoCrU
         +67Qp9Wa9fa+aUkEKdcW9AGeYv7YIyEU+mxAi+VxdIiivSiOMmt9O4HQpK9AKGFZ4mos
         fhwUPJhohSFAI2RlpOIIC5ueTZXLSEtcAO2KAdt8mB040ID1iKCPmDb3Pzc3o3UqAUFb
         AG+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GggVIs3M;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GggVIs3M;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Mon, 19 Feb 2018 06:32:26 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Masanari Iida <standby24x7@gmail.com>
Cc: sdharia@codeaurora.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] linux-next: SLIMbus: doc: Fix a warning "Title underline
 too short"
Message-ID: <20180219143226.GA24352@bombadil.infradead.org>
References: <20180219135550.28627-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219135550.28627-1-standby24x7@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592837884320180932?=
X-GMAIL-MSGID: =?utf-8?q?1592840157204511291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 10:55:50PM +0900, Masanari Iida wrote:
>  Driver and Controller APIs:
> ---------------------------
> +---------------------------
>  .. kernel-doc:: include/linux/slimbus.h

Is this the right fix?  Shouldn't we rather delete the : instead?
We don't normally have a colon at the end of subsection titles.
