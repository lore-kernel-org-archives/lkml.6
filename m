Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDAFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB192151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB192151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeIZVwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:52:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49914 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeIZVwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:52:01 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g5BtS-0001qN-4v; Wed, 26 Sep 2018 17:38:26 +0200
Date:   Wed, 26 Sep 2018 17:38:26 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, will.deacon@arm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [RFC][PATCH 0/3] locking/qspinlock: Improve determinism for x86
Message-ID: <20180926153825.lqkus5b6m7bscot2@linutronix.de>
References: <20180926110117.405325143@infradead.org>
 <20180926150059.ua5576guhns5osgj@breakpoint.cc>
 <alpine.DEB.2.21.1809261707090.4072@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809261707090.4072@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-26 17:08:42 [+0200], Thomas Gleixner wrote:
> Remember that 4.14 took almost 8 hours to fail, so I'd recommend not to
> cheer too much. Let's see what it tells us in 48 hours.

I don't cheer. I merely point out that shuffling the whole atomic code
around did not make a change while applying the three patches did.
The v4.4 kernel did survive for 5 days. Here we might start looking for
the cheer outfit.

> Thanks,
> 
> 	tglx
Sebastian
