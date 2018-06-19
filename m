Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41DCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B988B2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B988B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966480AbeFSOen (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:34:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966267AbeFSOej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:34:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ABED3AEC9;
        Tue, 19 Jun 2018 14:34:37 +0000 (UTC)
Date:   Tue, 19 Jun 2018 07:34:32 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Davidlohr Bueso <dbueso@suse.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 173/268] sched/rt: Fix rq->clock_update_flags <
 RQCF_ACT_SKIP warning
Message-ID: <20180619143432.mkh7gga3osjdafob@linux-r8p5>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100221.993481294@linuxfoundation.org>
 <1529013356.2289.200.camel@codethink.co.uk>
 <20180614183211.0beacf67@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180614183211.0beacf67@gandalf.local.home>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018, Steven Rostedt wrote:
>
>Although the change log is a bit ambiguous in if it is fixing an actual
>miss update, or if it is just quieting a false positive.
>
>Davidlohr?

It fixes an update, not a false positive.

Thanks,
Davidlohr
