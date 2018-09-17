Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0D7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECC620883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECC620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbeIQUdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:33:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55351 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbeIQUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:33:01 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1v59-000156-T9; Mon, 17 Sep 2018 17:05:00 +0200
Date:   Mon, 17 Sep 2018 17:04:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Atish Patra <atish.patra@wdc.com>, palmer@sifive.com,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        robh@kernel.org, Damien.LeMoal@wdc.com, marc.zyngier@arm.com,
        anup@brainfault.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] RISC-V: Remove per cpu clocksource
In-Reply-To: <20180917150149.GA25348@infradead.org>
Message-ID: <alpine.DEB.2.21.1809171703220.16580@nanos.tec.linutronix.de>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com> <1536962096-233842-4-git-send-email-atish.patra@wdc.com> <20180917143550.GC15588@infradead.org> <alpine.DEB.2.21.1809171638560.16580@nanos.tec.linutronix.de>
 <20180917150149.GA25348@infradead.org>
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

On Mon, 17 Sep 2018, Christoph Hellwig wrote:
> > Just for the record, this would be the first (architected) timer ever which
> > just works. I'm having a hard time to believe this, but I'd certainly
> > welcome it.
> 
> And that would be the contact with reality.

I've dealt with the reality of timers for a long time ....

Thanks,

	tglx
