Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeERUUj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:20:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63544 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeERUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:20:34 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Suman Anna <s-anna@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ti-cpufreq: minor fixes/cleanups
Date: Fri, 18 May 2018 22:19:58 +0200
Message-ID: <2808028.7H1yeuone6@aspire.rjw.lan>
In-Reply-To: <ffbb49c3-229b-df20-ca0d-c49822fcdaf2@ti.com>
References: <20180402164958.20057-1-s-anna@ti.com> <ffbb49c3-229b-df20-ca0d-c49822fcdaf2@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 18, 2018 5:07:12 PM CEST Suman Anna wrote:
> On 04/02/2018 11:49 AM, Suman Anna wrote:
> > Hi Viresh,
> > 
> > Please find the updated series replacing the previous patch [1] fixing
> > couple of issues in the TI CPUFreq driver. I have split up the patches
> > as per your comments on v1. Final code diff remains the same as before.
> > 
> > regards
> > Suman
> > 
> > [1] https://patchwork.kernel.org/patch/10308925/
> > 
> > Suman Anna (2):
> >   cpufreq: ti-cpufreq: Fix an incorrect error return value
> >   cpufreq: ti-cpufreq: Use devres managed API in probe()
> 
> Gentle reminder, I don't see these patches in -next. Who is picking up
> these patches?

You need to resend them I'm afraid, with any tags received so far.

And they won't be picked up if you don't CC linux-pm@vger.kernel.org on
the submission.

Thanks,
Rafael
