Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF34EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884402084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884402084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeKLKnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:43:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50447 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeKLKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:43:20 -0500
Received: from node-1w7jr9qsvbxfi9ota9omrl6fe.ipv6.telus.net ([2001:569:7bc5:1000:8103:8419:bf24:e6ca])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gM0T3-0006pP-2F; Mon, 12 Nov 2018 01:52:41 +0100
Date:   Sun, 11 Nov 2018 16:52:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT pull] scheduler fixes for 4.20
In-Reply-To: <CAHk-=wiv7ZKgcyAtpKGC8yYAWwtnD3f77_nMz72JQciDJ+JXsg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811111651590.14703@nanos.tec.linutronix.de>
References: <154192381794.5458.5498732290895334242.tglx@nanos.tec.linutronix.de> <154192381794.5458.16318183442023794568.tglx@nanos.tec.linutronix.de> <CAHk-=wiv7ZKgcyAtpKGC8yYAWwtnD3f77_nMz72JQciDJ+JXsg@mail.gmail.com>
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

Linus,

On Sun, 11 Nov 2018, Linus Torvalds wrote:

> On Sun, Nov 11, 2018 at 2:11 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus
> 
> Hmm. I get
> 
>    Already up to date.
> 
> with top commit being 993f0b0510da ("sched/topology: Fix off by one
> bug") that I already merged earlier.
> 
> Did you forget to push out?
> 
> I did find the commits in the 'sched/urgent' branch, so I pulled that.

Sorry. I was on a flaky wireless connection at the airport, so one of the
pushs must have failed without me noticing.

Thanks,

	tglx
