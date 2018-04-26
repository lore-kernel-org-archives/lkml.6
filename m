Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx49v8L7PnpqtD3sW31FAj5wClofGMO9rw9mP/XLRFQ/N/ksmCM9iUKJe5bJYyJdH8YI87BKW
ARC-Seal: i=1; a=rsa-sha256; t=1524768234; cv=none;
        d=google.com; s=arc-20160816;
        b=lh4S+OvwlhgbvI8p0NLS72LkbSRWURbXz9kP2Ax7E8YAMAwUlOqZIC7WyXch55C73+
         ebbfLigC8obPl6HlrULd1uabVbk15SIKL8shDUcbt+ipz2LdXOCGIi7ehA1WY0mxHeWg
         FxY2UwM0zv3TJ6P+3nQR7WXUUVlyu7VI0naq7b//whvLrgA1JoixNlyFd/HlkSqd9+yR
         bBN1IC4CSn1x6qj6sP8Y2wbHAhnXfUdGVYz8tqw3gmmN5sIOUEKGUloM/xiPsePvMVQf
         KIVLY+S50yvpIzclfRjeqWo2R9drkXxAefzL7KjWA/NMRGo5UC3ldvHSsqvEmt9jiKY/
         qZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=MFRaPk1Ev/cMHjYkE0pBB+Ocl8g751UJ+EqRDYPwyGU=;
        b=eUeHLEOQxVOy25M7LWeZ5mvA+J1r/3A2ITyJ5VkQQwvuKymQAg6WxozRWdYFgXtKg3
         ZRPoCk5+9qkRX4ExaMee+iICL4t6kULzUvesbGiIdH21iSEX98yKNm9n5ltiNotxjij6
         xtcMxbDTmQEiIBkaPh1qIacMeo+RfIIAUGGh6UtzlZtl1mcqAqdAbQa+8+la6ODyP65A
         KLgzQEg0Nq5lCtQhoFqKH+ru56rEoCqXDBExofEDFpMcYTCuLV2sI30rsJxUhZEDPmS+
         SF+3sdOmRSVawbM1zQV6R4cbFpXEkieOl46O8ReYSoOEi2kXxnFQGPx/4vr4XayTJKQd
         eBgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Thu, 26 Apr 2018 20:43:47 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: LKML <linux-kernel@vger.kernel.org>,
    Philippe Ombredanne <pombredanne@nexb.com>,
    Kate Stewart <kstewart@linuxfoundation.org>,
    Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>,
    Mauro Carvalho Chehab <mchehab@s-opensource.com>,
    Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V3 7/7] scripts: Add SPDX checker script
In-Reply-To: <20180426170428.GA18248@kroah.com>
Message-ID: <alpine.DEB.2.21.1804262043160.1596@nanos.tec.linutronix.de>
References: <20180425203020.594959448@linutronix.de> <20180425203703.650160358@linutronix.de> <20180426070246.GL14025@kroah.com> <alpine.DEB.2.21.1804261552000.1584@nanos.tec.linutronix.de> <20180426170428.GA18248@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752952851638430?=
X-GMAIL-MSGID: =?utf-8?q?1598835375914758437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018, Greg Kroah-Hartman wrote:

> On Thu, Apr 26, 2018 at 03:54:27PM +0200, Thomas Gleixner wrote:
> > +#!/usr/bin/env python
> > +# SPDX-License-Identifier: GPL2.0
> 
> You didn't run the tool on itself :)

Quod erat demonstrandum.
