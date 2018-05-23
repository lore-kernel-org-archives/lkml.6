Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeEWFCN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:02:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40907 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeEWFCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:02:12 -0400
X-Google-Smtp-Source: AB8JxZqhFECZIU32AjsFZQtJzIEJGUE9onN/k3zU7G4kU7kTCvWK5X3kSIQH9LvVUiJl0pu54UGU4A==
Date: Wed, 23 May 2018 10:32:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net
Subject: Re: [PATCH] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Message-ID: <20180523050208.rvbeawn377oqzpzx@vireshk-i7>
References: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 04:42, George Cherian wrote:
> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
> feedback via set of performance counters. To determine the actual
> performance level delivered over time, OSPM may read a set of
> performance counters from the Reference Performance Counter Register
> and the Delivered Performance Counter Register.
> 
> OSPM calculates the delivered performance over a given time period by
> taking a beginning and ending snapshot of both the reference and
> delivered performance counters, and calculating:
> 
> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
> 
> Implement the above and hook this to the cpufreq->get method.
> 
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
