Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CCDC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6277321759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6277321759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeHCOWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:22:24 -0400
Received: from verein.lst.de ([213.95.11.211]:44165 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeHCOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:22:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 03B1168D40; Fri,  3 Aug 2018 14:31:06 +0200 (CEST)
Date:   Fri, 3 Aug 2018 14:31:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [PATCH 11/11] clocksource: new RISC-V SBI timer driver
Message-ID: <20180803123105.GB18301@lst.de>
References: <20180802115008.4031-1-hch@lst.de> <20180802115008.4031-12-hch@lst.de> <78e56d2f-155b-72df-1094-fdfb45090216@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e56d2f-155b-72df-1094-fdfb45090216@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +/*
>> + * It is guarnteed that all the timers across all the harts are synchronized
>
> /s/guarnteed/guaranteed

Fixed.
