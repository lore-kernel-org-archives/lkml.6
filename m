Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeERJEw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:04:52 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38268 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbeERJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:04:49 -0400
X-Google-Smtp-Source: AB8JxZqkDetk18Mc6s6gAqjxdOf/RYThld8+dXSwo2Zo2SPd5cQ5g56sOjYJzWtMxtN0o3rcMw25gg==
Date: Fri, 18 May 2018 14:34:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 10/11] cpufreq: tegra20: Wrap cpufreq into platform
 driver
Message-ID: <20180518090445.g7aeufyu7agawofa@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-11-digetx@gmail.com>
 <20180518020730.byftoaodycccze3m@vireshk-i7>
 <6127765f-e953-ce28-9994-43ffbe98703d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6127765f-e953-ce28-9994-43ffbe98703d@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-18, 11:09, Dmitry Osipenko wrote:
> On 18.05.2018 05:07, Viresh Kumar wrote:
> > On 17-05-18, 21:00, Dmitry Osipenko wrote:
> >> -static int __init tegra_cpufreq_init(void)
> >> +static int tegra20_cpufreq_probe(struct platform_device *pdev)
> >>  {
> >> +	struct tegra20_cpufreq_data *data;
> >>  	int err;
> >>  
> >> -	if (!of_machine_is_compatible("nvidia,tegra20"))
> >> -		return -ENODEV;
> > 
> > So this stuff wasn't really required as you are getting rid of that in
> > the same series. Should we really add it then ? Maybe ..
> > 
> 
> It's not strictly needed, but I'd prefer to keep that stuff for clarity as it
> kinda shows the way that led to the final result.

Okay.

-- 
viresh
