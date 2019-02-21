Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529CF2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfBULcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:32:16 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59337 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:32:16 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 839361899e8bc1af; Thu, 21 Feb 2019 12:32:14 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, Qais.Yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/5] cpufreq: Use QoS layer to manage freq-constraints
Date:   Thu, 21 Feb 2019 12:30:47 +0100
Message-ID: <2575955.AqKVkXLaMl@aspire.rjw.lan>
In-Reply-To: <cover.1550748118.git.viresh.kumar@linaro.org>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 21, 2019 12:29:26 PM CET Viresh Kumar wrote:
> Hello,
> 
> This patchset attempts to manage CPU frequency constraints using the PM
> QoS framework. It only does the basic stuff right now and moves the
> userspace constraints to use the QoS infrastructure.
> 
> Todo:
> - Migrate all users to the QoS framework and get rid of cpufreq specific
>   notifiers.
> - Make PM QoS learn about the relation of CPUs in a policy, so a single
>   list of constraints is managed for all of them instead of per-cpu
>   constraints.
> 
> V1->V2:
> - The previous version introduced a completely new framework, this one
>   moves to PM QoS instead.
> - Lots of changes because of this.

Well, thanks for working on this, but I'm rather unlikely to look at it in
detail before 5.1-rc1 is released.

Cheers,
Rafael

