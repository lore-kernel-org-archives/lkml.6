Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966077AbeEXJho (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:37:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41777 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965783AbeEXJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:37:41 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: tegra20: Fix imbalanced clock enable count
Date: Thu, 24 May 2018 11:36:59 +0200
Message-ID: <2304436.qRMBXhMGsN@aspire.rjw.lan>
In-Reply-To: <db300fa3-ae83-059f-eae0-0808c3cb33fb@gmail.com>
References: <20180522211420.2006-1-digetx@gmail.com> <20180523055817.subrv6oeckfecpcp@vireshk-i7> <db300fa3-ae83-059f-eae0-0808c3cb33fb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 23, 2018 11:30:39 AM CEST Dmitry Osipenko wrote:
> On 23.05.2018 08:58, Viresh Kumar wrote:
> > On 23-05-18, 00:14, Dmitry Osipenko wrote:
> >> Tegra20-cpufreq driver missed enabling the CPU clocks. This results in a
> >> clock-enable refcount disbalance on PLL_P <-> PLL_X reparent, causing
> >> PLL_X to get disabled while it shouldn't. Fix this by enabling the clocks
> >> on the driver probe.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>
> >> CPUFreq maintainers,
> >>
> >> Please take into account that this patch is made on top of my recent
> >> series of patches [0] "Clean up Tegra20 cpufreq driver" that was fully
> >> reviewed, but seems not applied yet. Let me know if you prefer to re-spin
> >> the [0], including this patch into the series.
> >>
> >> [0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=45321
> > 
> > This is already picked by Rafael and is sitting in pm/bleeding-edge
> > branch. Should get merged into linux-next in a day or two.
> 
> Neat, thank you for letting me know.

It actually is there in my linux-next branch, but linux-next proper is not
taking new material this week AFAICS.

You'll see this in linux-next on Monday, most probably.
