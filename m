Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C887DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928252081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928252081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKIDZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:25:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44912 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKIDZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:25:09 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKoPx-0005xH-EC; Thu, 08 Nov 2018 18:48:33 +0100
Date:   Thu, 8 Nov 2018 18:48:33 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: rcu: Merge RCU-bh into RCU-preempt
Message-ID: <20181108174833.suvpdaari2emilu7@linutronix.de>
References: <20181101231804.GA11280@linux.ibm.com>
 <20181108160256.xpawe65h5lm65soi@linutronix.de>
 <20181108164247.GL4170@linux.ibm.com>
 <20181108171516.axwvjtgay4zolc56@linutronix.de>
 <20181108173525.GO4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181108173525.GO4170@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 09:35:25 [-0800], Paul E. McKenney wrote:
> I agree that tglx's patch is needed for 4.19 and earlier.  Just not for
> 4.20 and later.
> 
> Or am I still missing your point?

nope, I think we are good.

> 							Thanx, Paul

Sebastian
