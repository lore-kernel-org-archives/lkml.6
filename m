Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1973ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878BA20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878BA20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeKIAz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:55:58 -0500
Received: from ms.lwn.net ([45.79.88.28]:59064 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbeKIAz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:55:58 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E1D226EC;
        Thu,  8 Nov 2018 15:19:58 +0000 (UTC)
Date:   Thu, 8 Nov 2018 08:19:57 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20181108081957.4350d22d@lwn.net>
In-Reply-To: <20181108150517.GV9761@hirez.programming.kicks-ass.net>
References: <20181107171010.421878737@linutronix.de>
        <20181107124855.328133e7@lwn.net>
        <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
        <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
        <20181108074920.4c601ee3@lwn.net>
        <20181108150517.GV9761@hirez.programming.kicks-ass.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 16:05:17 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 08, 2018 at 07:49:20AM -0700, Jonathan Corbet wrote:
> > Might it be worth asking Ted for a kernel summit slot to talk about this
> > next week?  
> 
> Ah, on that, let me complain :-)
> 
> My plumbers schedule is already 100% booked with MCs and other things.
> There is no kernel-summit schedule details available as of yet, but it
> is already almost certain that I will not have time for anything in that
> track anyway :/

But surely you can find a few minutes to drop by and throw catchboxes at
the docs maintainer? :)

I do understand, though, it's going to be a crazy week.

jon
