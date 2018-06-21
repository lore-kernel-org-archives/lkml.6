Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B364CC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6739220883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zHuCpCBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6739220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbeFUOdd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:33:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55378 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932645AbeFUOdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vG/L8kjVr/BZOkOxp+zWuCT5dqhzmUyTCOR92SWhGGQ=; b=zHuCpCBpcA/nYLITuwKsu8PRg
        lZ1XsukJXdxSj4+u4ZCDfBjXt2A91FYPoqQxMouWAD0HwdUp+YDYHKudBRuFvbDZDa8ifvTy9CU5z
        v7ZIlbW8YuQgySaml0gCtmPHbQnT/It9KduP+tGo4yAdxyN/OC1iCFoDS0l+1BaEIjop5uCP3+Y22
        tv/i+taz8KtGdw/U96L3OJq6yrm85auv6Q4/J280C951ROMWRvkMQTEH1qRwle5D8keYiZtziMnTL
        FIcfteNPwgMl2RB24c1OF0TJa5vU0Yyq/T6XQvWfjjQVmAwoV2rUSfESOcanSOiuFdL2RzSPTFwQT
        I/CtxbdbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW0eF-0007Zr-2o; Thu, 21 Jun 2018 14:33:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4823A2029F1D5; Thu, 21 Jun 2018 16:33:16 +0200 (CEST)
Date:   Thu, 21 Jun 2018 16:33:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 02/11] sched/pelt: remove blank line
Message-ID: <20180621143316.GA27616@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-3-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528459794-13066-3-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:09:45PM +0200, Vincent Guittot wrote:
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index e6ecbb2..4174582 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -287,7 +287,6 @@ int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_e
>  
>  	if (___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
>  				cfs_rq->curr == se)) {
> -
>  		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
>  		cfs_se_util_change(&se->avg);
>  		return 1;
> @@ -302,7 +301,6 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
>  				scale_load_down(cfs_rq->load.weight),
>  				scale_load_down(cfs_rq->runnable_weight),
>  				cfs_rq->curr != NULL)) {
> -
>  		___update_load_avg(&cfs_rq->avg, 1, 1);
>  		return 1;
>  	}

So I put them there on purpose, I find it easier to read when a
multi-line if statement and the body are separated. Makes it clearer
where the if ends and the block begins.

I mean, all whitespace in C is superfluous, and yet we keep adding it to
these files :-)
