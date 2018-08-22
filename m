Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9F2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6692098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6692098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeHVWoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:44:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVWoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:44:03 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fsYdT-0002tz-ED; Wed, 22 Aug 2018 21:17:43 +0200
Date:   Wed, 22 Aug 2018 21:17:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Rob Herring <rob.herring@linaro.org>,
        Jonas Oberg <jonas@fsfe.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH V2] license-rules.rst and LICENSES: Use only spdx version
 3 with -only and -or-later
In-Reply-To: <CA+55aFyd5D9Rj2Wm+rP9QnZg2Jd_LKqPTKTmPv+doYN=JXra=w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808222115050.1652@nanos.tec.linutronix.de>
References: <9f90ed3678d32bdde88d63e877880dcb08a97e15.1534519501.git.joe@perches.com> <7275a821f20ba080b6a262089ceeaf8fa94d4bab.camel@perches.com> <CA+55aFyd5D9Rj2Wm+rP9QnZg2Jd_LKqPTKTmPv+doYN=JXra=w@mail.gmail.com>
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

On Wed, 22 Aug 2018, Linus Torvalds wrote:
> On Wed, Aug 22, 2018 at 11:01 AM Joe Perches <joe@perches.com> wrote:
> >
> > How likely is it that this is applied at rc1?
> 
> I'm staying out of the crazy license name bikeshedding, so it's going
> to be up to the people who have decided they care.
> 
> I think whoever *did* care and argued for the change to the SPDX
> format is a hopeless wanker. "GPL-2.0{-only,-or-later}" is in no ways
> better than the "GPL-2.0{,+}" that was in an earlier version of the
> SPDX spec
> 
> So I want nothing at all to do with pointless patches. Life is too
> short to deal with this.
> 
> Other people disagree, so I expect I will get these kinds of stupid
> noise patches through the usual channels.

I'm not a great fan of that change either. We have settled on a well
documented and machine readable format. External tools have to be able to
deal with SPDX versions anyway and if we do this now, then we have the next
round of pointless churn in a year when the SPDX folks decide to rename yet
another license identifier which is used in the kernel.

Thanks,

	tglx
