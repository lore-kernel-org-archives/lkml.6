Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE06C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FB920879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfAVL1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:27:42 -0500
Received: from foss.arm.com ([217.140.101.70]:51478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfAVL1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:27:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 262E6A78;
        Tue, 22 Jan 2019 03:27:41 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE8473F6A8;
        Tue, 22 Jan 2019 03:27:37 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:27:35 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 08/16] sched/cpufreq: uclamp: Add utilization clamping
 for FAIR tasks
Message-ID: <20190122112735.lxlebhjyz3ztip5k@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-9-patrick.bellasi@arm.com>
 <3006911.57lVBuUGX3@aspire.rjw.lan>
 <20190122110205.lpk6o2jdfe3mttjr@e110439-lin>
 <CAJZ5v0j2NQY_gKJOAy=rP5_1Dk9TODKNhW0vuvsynTN3BUmYaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j2NQY_gKJOAy=rP5_1Dk9TODKNhW0vuvsynTN3BUmYaQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Jan 12:04, Rafael J. Wysocki wrote:
> On Tue, Jan 22, 2019 at 12:02 PM Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> >
> > On 22-Jan 11:37, Rafael J. Wysocki wrote:
> > > On Tuesday, January 15, 2019 11:15:05 AM CET Patrick Bellasi wrote:
> 
> Merge the two together, please.

Ok, will do in v7, thanks.

-- 
#include <best/regards.h>

Patrick Bellasi
