Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbeCGFKC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 00:10:02 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36870 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbeCGFJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 00:09:59 -0500
X-Google-Smtp-Source: AG47ELs8pG3J6w7OcbIAcxJC5AFalPlEdaFHsPtHDJC4ShLbceyTc3AZho/ymioBaiRcQJGN49Me/w==
Date: Wed, 7 Mar 2018 10:39:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
Subject: Re: [PATCH v9 14/15] cpufreq: Add module to register cpufreq on
 Krait CPUs
Message-ID: <20180307050956.GA6842@vireshk-i7>
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
 <1520347148-27852-15-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520347148-27852-15-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-03-18, 20:09, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Register a cpufreq-generic device whenever we detect that a
> "qcom,krait" compatible CPU is present in DT.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> [Sricharan: updated to use dev_pm_opp_set_prop_name and
> 	    nvmem apis]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm          |  10 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   5 +
>  drivers/cpufreq/qcom-cpufreq.c       | 183 +++++++++++++++++++++++++++++++++++
>  4 files changed, 199 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
