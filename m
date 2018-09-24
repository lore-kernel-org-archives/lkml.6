Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B2AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B05F2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B05F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbeIXSlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:41:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44651 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbeIXSlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:41:20 -0400
Received: from tmo-108-1.customers.d1-online.com ([80.187.108.1] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g4Q8i-0007vg-Ps; Mon, 24 Sep 2018 14:39:01 +0200
Date:   Mon, 24 Sep 2018 14:38:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
In-Reply-To: <nycvar.YFH.7.76.1809241032000.15880@cbobk.fhfr.pm>
Message-ID: <alpine.DEB.2.21.1809241438070.1398@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144EA58@ORSMSX107.amr.corp.intel.com> <20180919154828.GJ24124@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1809220936520.15880@cbobk.fhfr.pm> <alpine.DEB.2.21.1809221022250.1391@nanos.tec.linutronix.de> <20180922101844.GF24124@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1809221219270.1391@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809221527140.1391@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1809241032000.15880@cbobk.fhfr.pm>
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

On Mon, 24 Sep 2018, Jiri Kosina wrote:

> On Sat, 22 Sep 2018, Thomas Gleixner wrote:
> 
> > Lunch and coffee indeed made brain work better. The simple solution was way
> > too obvious.
> 
> Ah, cool, I like it a lot.
> 
> Do you want me to fold this into v7, or are you on it already?

Please do so. I'm traveling/conferencing and only spotty online.

Thanks,

	tglx
