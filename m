Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2D0E0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE020891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DE020891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933174AbeFLT2J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:28:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932490AbeFLT2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:28:08 -0400
Received: from p4fea5fc6.dip0.t-ipconnect.de ([79.234.95.198] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fSoxS-0003EY-7M; Tue, 12 Jun 2018 21:27:58 +0200
Date:   Tue, 12 Jun 2018 21:27:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yang Li <pku.leo@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>, Joe Perches <joe@perches.com>,
        linux-xfs@vger.kernel.org,
        Charlemagne Lasse <charlemagnelasse@gmail.com>,
        Carmen Bianca Bakker <carmenbianca@fsfe.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch V5 01/11] Documentation: Add license-rules.rst to describe
 how to properly identify file licenses
In-Reply-To: <CADRPPNTK1x_47fnk4Tor5QSPk2DEuEwNUQQ4dGu1P3QkQDyZeQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806122111400.1592@nanos.tec.linutronix.de>
References: <20171228152710.891701433@linutronix.de> <20171228153308.286787253@linutronix.de> <alpine.DEB.2.20.1712282315030.1899@nanos> <CADRPPNTK1x_47fnk4Tor5QSPk2DEuEwNUQQ4dGu1P3QkQDyZeQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang,

On Tue, 12 Jun 2018, Yang Li wrote:
> On Thu, Dec 28, 2017 at 4:17 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 28 Dec 2017, Thomas Gleixner wrote:
> >
> > Sorry for the spam. I somehow missed to refresh the patch before generating
> > the mbox. Find below the correct version of that one which has ALL braces
> > removed which we don't need.

> I'm not sure how we reached the conclusion that we should remove ALL
> braces?  I cannot find related discussion in the archive except for
> the "WITH" case.

https://lkml.kernel.org/r/CAOFm3uEpM_tBErkOvqghcy+wbw0i4mSnafPBRC3HYZVQjsSyMw@mail.gmail.com

> This is conflicting with the current SPDX spec at
> https://spdx.org/spdx-specification-21-web-version quoted below and
> also the explenation in your own file.
> 
> Quote from SPDX spec 2.1: More expressive composite license
> expressions can be constructed using "OR", "AND", and "WITH" operators
> similar to constructing mathematical expressions using arithmetic
> operators. For the Tag:value format, any license expression that
> consists of more than one license identifier and/or LicenseRef, should
> be encapsulated by parentheses: "( )".

This is not relevant here:

   For the Tag:value format, .....

The kernel does not generate SPDX files in Tag:value format. The kernel
uses SPDX license identifiers to reflect the actual license of a file.

> > +   A <SPDX License Expression> is either an SPDX short form license
> > +   identifier found on the SPDX License List, or the combination of two
> > +   SPDX short form license identifiers separated by "WITH" when a license
> > +   exception applies. When multiple licenses apply, an expression consists
> > +   of keywords "AND", "OR" separating sub-expressions and surrounded by
> > +   "(", ")" .
> 
> Conflicting with the example

No, The keyword is 'separating sub-expressions'. It does not say license
identifiers.

So these examples are completely compliant with the documentation:

> > +      // SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
> > +      // SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note
> > +      // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

Two license (exception) identifiers plus a operator. That's perfectly well
defined.

> > +      // SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT

This is actually a case where you need parentheses and they separate the
sub-expression 'ID with EXC'.

Adding extra parentheses around any simple 'ID operator [ID|EXC]'
expression is really overkill and does not make stuff more
readable. Likewise in programming languages. Why would anyone write:

C et al.:	a = (b || c);
Pyhton:		a = (b and c)

Thanks,

	tglx
