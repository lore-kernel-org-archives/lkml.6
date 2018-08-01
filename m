Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A590FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F67D208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F67D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbeHARjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:39:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34338 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389562AbeHARjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:39:31 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fktQy-0001si-EZ; Wed, 01 Aug 2018 17:53:08 +0200
Date:   Wed, 1 Aug 2018 17:53:08 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT] sched: drop is_special_task_state() check from
 __set_current_state_no_track()
Message-ID: <20180801155308.wcw6mo6mrhlsgpg3@linutronix.de>
References: <20180801090524.7hmzfdx7r4bivekq@linutronix.de>
 <20180801091942.46292953@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180801091942.46292953@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-01 09:19:42 [-0400], Steven Rostedt wrote:
> I don't think we need to keep the do { } while with a single line. It
> is now equivalent to the non-debug version of __set_current_state()
> which is defined as:
> 
> #define __set_current_state(state_value)				\
> 	current->state = (state_value)

okay.

> -- Steve

Sebastian
