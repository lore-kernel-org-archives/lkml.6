Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66EECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E5A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E5A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbeGSIRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:17:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60339 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeGSIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:17:41 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fg3TY-0002hp-P9; Thu, 19 Jul 2018 09:35:48 +0200
Date:   Thu, 19 Jul 2018 09:35:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Shaohua Li <shli@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 1/6] drivers/md/raid5: Use irqsave variant of
 atomic_dec_and_lock()
Message-ID: <20180719073548.r5n7is4svcsnu3ro@linutronix.de>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
 <20180703200141.28415-2-bigeasy@linutronix.de>
 <20180716122740.q7oim7te5bybcniz@linutronix.de>
 <20180717003727.GA128433@kernel.org>
 <20180718105721.rcd6l7s6l4yfbahg@linutronix.de>
 <20180719024405.GA99813@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719024405.GA99813@kernel.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-18 19:44:05 [-0700], Shaohua Li wrote:
> Since you sent a series, I suppose you want someone else to take it. But I can
> take it for sure, will do soon.

I'm sorry for the miss understanding. I tried to explain this in the
cover letter. The prerequisites are already merged so then the actual
changes can be merged via the individual maintainer.
Thank you Shaohua.

> Thanks,
> Shaohua

Sebastian
