Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BAEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCF220827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCF220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeKICKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:10:06 -0500
Received: from ms.lwn.net ([45.79.88.28]:59382 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeKICKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:10:06 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 734B24FA;
        Thu,  8 Nov 2018 16:33:48 +0000 (UTC)
Date:   Thu, 8 Nov 2018 09:33:47 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
Message-ID: <20181108093347.61dd6cf3@lwn.net>
In-Reply-To: <20181108162133.GC1080@thunk.org>
References: <20181107171010.421878737@linutronix.de>
        <20181107124855.328133e7@lwn.net>
        <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
        <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
        <20181108074920.4c601ee3@lwn.net>
        <20181108150517.GV9761@hirez.programming.kicks-ass.net>
        <20181108162133.GC1080@thunk.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 11:21:33 -0500
"Theodore Y. Ts'o" <tytso@mit.edu> wrote:

> I thought there was a slot already scheduled on the refereed track,
> "Towards a Linux Kernel Mainainer Handbook" (Tuesday at 4:45pm) for
> this purpose?

My expectation is that this will be an actual talk; it seemed rude to
assume that Dan had penciled in a block of time for open arguments about
the tip-tree handbook :)  That said, I'm not feeling a groundswell of
support for scheduling another session at this point...

jon
