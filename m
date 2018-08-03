Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2659EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8542172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8542172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbeHCJoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:44:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39076 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbeHCJoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:44:34 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flUps-0003Pl-Ra; Fri, 03 Aug 2018 09:49:21 +0200
Date:   Fri, 3 Aug 2018 09:49:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Palmer Dabbelt <palmer@sifive.com>
cc:     Christoph Hellwig <hch@lst.de>, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com,
        anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: Re: simplified RISC-V interrupt and clocksource handling v2
In-Reply-To: <mhng-1a7030e5-19c4-481b-9f7c-e0976214eb18@palmer-si-x1c4>
Message-ID: <alpine.DEB.2.21.1808030947480.1841@nanos.tec.linutronix.de>
References: <mhng-1a7030e5-19c4-481b-9f7c-e0976214eb18@palmer-si-x1c4>
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

On Thu, 2 Aug 2018, Palmer Dabbelt wrote:
> bit of arch/riscv diff here so I don't mind taking it through the RISC-V tree,
> but there's also some irqchip and clocksource stuff as well so I'm not sure if
> that's OK to do.

I have no objections if that goes through the risc-v tree once the DT stuff
is sorted out.

For the clocksource and irqchip bits:

    Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
