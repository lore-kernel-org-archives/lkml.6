Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58830C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B25620873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeLROAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:00:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56117 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeLROAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:00:20 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gZFub-0002S7-BM; Tue, 18 Dec 2018 14:59:53 +0100
Date:   Tue, 18 Dec 2018 14:59:53 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, acme@kernel.org,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        bp@alien8.de, hpa@zytor.com, jolsa@kernel.org, jolsa@redhat.com,
        kan.liang@linux.intel.com, mingo@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Message-ID: <20181218135953.h7dcelbbaxg4q32a@linutronix.de>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
 <20181218111637.b53u5pi3nxnyldaq@linutronix.de>
 <20181218113119.GG15430@hirez.programming.kicks-ass.net>
 <20181218113700.GC16284@hirez.programming.kicks-ass.net>
 <20181218114708.p6fpz447brob4kzz@linutronix.de>
 <b8f1f75c-bb8e-3b07-b113-32d1ff70fd3e@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8f1f75c-bb8e-3b07-b113-32d1ff70fd3e@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-18 20:45:32 [+0800], He Zhe wrote:
> This works in my environment, taking CPUs offline and online many times.

thank you.

> Zhe
> 
> >
Sebastian
