Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B4620693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B4620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbeFTJVT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:21:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59448 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeFTIab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:30:31 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVYVa-0000qn-7z; Wed, 20 Jun 2018 10:30:30 +0200
Date:   Wed, 20 Jun 2018 10:30:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH] MAINTAINERS: Add me as an x86 entry code maintainer
In-Reply-To: <CA+55aFyZm1+eoeiwitrw-aqhSBa+g_LpvWvJAhHpRQ=UTKwtqg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806201029470.10546@nanos.tec.linutronix.de>
References: <c2394b008adfb6e7480f3b1193386537e96a6a69.1529358034.git.luto@kernel.org> <CA+55aFyZm1+eoeiwitrw-aqhSBa+g_LpvWvJAhHpRQ=UTKwtqg@mail.gmail.com>
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

On Tue, 19 Jun 2018, Linus Torvalds wrote:

> On Tue, Jun 19, 2018 at 6:41 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Linus has been saying that I might as well maintain this stuff for years.
> > What do you all think?
> 
> I invoked executive privilege and just applied it. It's just making
> official what has been practice.

Indeed. Belated Acked-by-me.

