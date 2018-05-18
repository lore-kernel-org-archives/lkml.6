Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeERPHS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:07:18 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:36660 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:07:16 -0400
Subject: Re: [PATCH v2 0/2] ti-cpufreq: minor fixes/cleanups
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180402164958.20057-1-s-anna@ti.com>
From: Suman Anna <s-anna@ti.com>
Message-ID: <ffbb49c3-229b-df20-ca0d-c49822fcdaf2@ti.com>
Date: Fri, 18 May 2018 10:07:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180402164958.20057-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2018 11:49 AM, Suman Anna wrote:
> Hi Viresh,
> 
> Please find the updated series replacing the previous patch [1] fixing
> couple of issues in the TI CPUFreq driver. I have split up the patches
> as per your comments on v1. Final code diff remains the same as before.
> 
> regards
> Suman
> 
> [1] https://patchwork.kernel.org/patch/10308925/
> 
> Suman Anna (2):
>   cpufreq: ti-cpufreq: Fix an incorrect error return value
>   cpufreq: ti-cpufreq: Use devres managed API in probe()

Gentle reminder, I don't see these patches in -next. Who is picking up
these patches?

regards
Suman

> 
>  drivers/cpufreq/ti-cpufreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
