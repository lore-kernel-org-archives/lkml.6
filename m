Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeDPJeq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:34:46 -0400
Received: from foss.arm.com ([217.140.101.70]:56924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752511AbeDPJep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:34:45 -0400
Date: Mon, 16 Apr 2018 10:34:31 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180416093431.GA27901@e107533-lin>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <3f3b3b7a-3b74-aee2-2fac-f2759babe3f0@arm.com>
 <939f7943-feec-aaa2-3bd3-59a6618330c0@linaro.org>
 <20180416073729.GA4244@vireshk-i7>
 <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 09:44:51AM +0200, Daniel Lezcano wrote:
> On 16/04/2018 09:37, Viresh Kumar wrote:
> > On 13-04-18, 13:47, Daniel Lezcano wrote:
> >> Ok, noted. At the first glance, it should not be a problem.
> > 
> > Why do you think it wouldn't be a problem ?
> 
> Because we rely on the number to identify the cluster and flag it
> 'processed'. The number itself is not important.
> 

In that case, why can't cpu_possible_mask be used for simplicity if all
you need is the tracking and that need not be grouped under the "cluster"
banner.

--
Regards,
Sudeep
