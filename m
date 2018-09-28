Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9BBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836A720684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836A720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeI1PBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:01:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60537 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeI1PBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:01:08 -0400
Received: from guest-nat.fw1.untrust.par1.mozilla.net (185.155.181.200) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 9c295b92d7af310f; Fri, 28 Sep 2018 10:38:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v7 02/14] sched/cpufreq: Prepare schedutil for Energy Aware Scheduling
Date:   Fri, 28 Sep 2018 10:35:31 +0200
Message-ID: <1955193.fk0stZ6klG@aspire.rjw.lan>
In-Reply-To: <20180928083503.h4jbdgk3dqpaufzb@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com> <2417577.QmA9JEQx1z@aspire.rjw.lan> <20180928083503.h4jbdgk3dqpaufzb@queper01-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 28, 2018 10:35:05 AM CEST Quentin Perret wrote:
> Hi Rafael,
> 
> On Friday 28 Sep 2018 at 10:23:42 (+0200), Rafael J. Wysocki wrote:
> [...]
> > OK, so please document the enum type.
> 
> Will do.
> 
> [...]
> > Documenting things properly is absolutely required.
> 
> Understood.
> 
> > The other changes suggested by me are rather straightforward, so why would it
> > be a problem to make them right away if you agree to make them?
> 
> Right, if I need to spin a v8 for doc purpose anyway, I guess I can do
> the other small fixes at the same time.
> 
> I'll wait a bit before sending the update to see if others have some
> feedback. It's probably a bit late for 4.20 anyway ... Or is it not ?

I think this is scheduler material anyway, even though it affects cpufreq
somewhat, so that depends on what Peter thinks really.

Thanks,
Rafael

