Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AB5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE8C217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfBFOdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:33:06 -0500
Received: from foss.arm.com ([217.140.101.70]:53798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfBFOdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:33:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5778880D;
        Wed,  6 Feb 2019 06:33:05 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B583F675;
        Wed,  6 Feb 2019 06:33:04 -0800 (PST)
Subject: Re: [PATCH 0/5] sched/fair: NOHZ cleanups and misfit improvement
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Dietmar.Eggemann@arm.com
References: <20190117153411.2390-1-valentin.schneider@arm.com>
Message-ID: <87867c2b-7935-6dc4-d237-74da43b2fd2f@arm.com>
Date:   Wed, 6 Feb 2019 14:33:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117153411.2390-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/01/2019 15:34, Valentin Schneider wrote:
[...]
> Valentin Schneider (5):
>   sched/fair: Use for_each_cpu_and for asym-packing nohz kicks
>   sched/fair: Explain LLC nohz kick condition
>   sched/fair: Prune nohz_balancer_kick() comment block
>   sched/fair: Tune down misfit nohz kicks
>   sched/fair: Skip LLC nohz logic for asymmetric systems
> 
>  kernel/sched/fair.c | 62 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 18 deletions(-)
> 

Gentle ping

> --
> 2.20.1
> 
