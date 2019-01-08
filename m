Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D095C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE34206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfAHLF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:05:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHLF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:05:57 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ggpCh-0007o7-PC; Tue, 08 Jan 2019 12:05:51 +0100
Date:   Tue, 8 Jan 2019 12:05:51 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        Tom Putzeys <tom.putzeys@be.atlascopco.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: CFS scheduler: spin_lock usage causes dead lock when
 smp_apic_timer_interrupt occurs
Message-ID: <20190108110551.zdvm5mpbdyphspiy@linutronix.de>
References: <AM0PR03MB480425D5999E0D08DAB30204BB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
 <AM0PR03MB4804FA468B7A006AEEA8592ABB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
 <20190107102613.GC2861@worktop.programming.kicks-ass.net>
 <1546864114.26963.5.camel@gmx.de>
 <20190107125231.GE14122@hirez.programming.kicks-ass.net>
 <1546925459.17252.2.camel@gmx.de>
 <20190108090625.GN15430@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190108090625.GN15430@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 10:06:25 [+0100], Peter Zijlstra wrote:
> Much appreciated; I queued it as the below.
thank you, queued, too.

Sebastian
