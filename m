Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeEUNRS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:17:18 -0400
Received: from foss.arm.com ([217.140.101.70]:49612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751081AbeEUNRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:17:15 -0400
Date: Mon, 21 May 2018 14:17:41 +0100
From: Will Deacon <will.deacon@arm.com>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, rjw@rjwysocki.net,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org, tfinkel@codeaurora.org,
        nicolas.dechesne@linaro.org, celster@codeaurora.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 01/15] soc: qcom: Separate kryo l2 accessors from PMU
 driver
Message-ID: <20180521131740.GI19713@arm.com>
References: <1526901932-9514-1-git-send-email-ilialin@codeaurora.org>
 <1526901932-9514-2-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526901932-9514-2-git-send-email-ilialin@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 02:25:18PM +0300, Ilia Lin wrote:
> The driver provides kernel level API for other drivers
> to access the MSM8996 L2 cache registers.
> Separating the L2 access code from the PMU driver and
> making it public to allow other drivers use it.
> The accesses must be separated with a single spinlock,
> maintained in this driver.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  drivers/perf/Kconfig                 |  1 +
>  drivers/perf/qcom_l2_pmu.c           | 90 ++++++++++--------------------------

I'm fine with the perf bits:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
