Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FD9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0582176D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0582176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389664AbeHGRAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:00:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48775 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:00:42 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fn3FI-0000rr-Sa; Tue, 07 Aug 2018 16:46:00 +0200
Date:   Tue, 7 Aug 2018 16:46:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [rt-patch 4/3] arm,KVM: Move phys_timer handling to hard irq
 context
Message-ID: <20180807144600.pmyckao2brlsatsr@linutronix.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
 <1532764179.9882.14.camel@gmx.de>
 <1532768853.9882.73.camel@gmx.de>
 <1533192980.11791.8.camel@gmx.de>
 <20180802123104.7fed73b4@gandalf.local.home>
 <1533228650.12550.15.camel@gmx.de>
 <1533231816.12550.54.camel@gmx.de>
 <1533385520.5602.31.camel@gmx.de>
 <1533444777.9157.10.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1533444777.9157.10.camel@gmx.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-05 06:52:57 [+0200], Mike Galbraith wrote:
> 
> FWIW, I had thought that something 4.16..master had made that business
> go entirely away, but it only became much more infrequent.  So much for
> plan to slowly sneak up on whatever than was via ~bisect.

I just released v4.18 based RT. Please repost the kvm/RT patches once
things have settled.

Sebastian
