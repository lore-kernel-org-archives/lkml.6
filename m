Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966014AbeEXJkQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:40:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44207 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965759AbeEXJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:40:11 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Subject: Re: [RFD] Add debugfs for cpuidle ?
Date: Thu, 24 May 2018 11:39:30 +0200
Message-ID: <11155078.TUGiezxXmY@aspire.rjw.lan>
In-Reply-To: <bcdbf067-4213-18ed-6d30-dc0dd2376c02@linaro.org>
References: <516d8599-8038-7b47-a3f5-640bf13856c2@linaro.org> <2682482.uFPN0cxrGI@aspire.rjw.lan> <bcdbf067-4213-18ed-6d30-dc0dd2376c02@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 24, 2018 10:47:54 AM CEST Daniel Lezcano wrote:
> On 24/05/2018 10:28, Rafael J. Wysocki wrote:
> > On Thursday, May 24, 2018 10:14:31 AM CEST Daniel Lezcano wrote:
> >> 
> >> Hi all,
> > 
> > Hi,
> > 
> >> would it be interesting to add debugfs metrics for cpuidle in order
> >> to read some statistics from there and investigate the behavior ?
> > 
> > What exactly would you like to see in there?
> 
> It could be interesting to have statistics on a per cpu and global basis
> for:
> 
> - prediction accuracy:
> 
> /sys/kernel/debug/cpuidle/prediction/[good|over|under]
> /sys/kernel/debug/cpuidle/cpu*/state*/prediction/[good|over|under]
> 
>  - exit latency
> 
> In addition, it is often the case the idle states values are dropped
> randomly, it is interesting to see the average exit latency for the
> states. That could give also an indication the cluster idle state success.
> 
> /sys/kernel/debug/cpuidle/state*/latency/[min|max|avg|stddev]
> /sys/kernel/debug/cpuidle/cpu*/state*/prediction/[min|max|avg|stddev]
> 
> And perhaps more information like the tick stopped stat ?

Fair enough, but that must be minimum overhead.
