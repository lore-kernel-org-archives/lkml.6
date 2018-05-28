Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbeE1FDo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:03:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44831 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeE1FDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:03:42 -0400
X-Google-Smtp-Source: AB8JxZr7VDumfkZMWvKZZt0gYmkIOqmO5CO8TkXdMGKa2LGVkrkadwDEM+2N2+/ndKmbkIFmTmUnBA==
Date: Mon, 28 May 2018 10:33:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: ilia.lin@gmail.com, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 1/2] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180528050338.p4zg6a2v5fu3oxwe@vireshk-i7>
References: <1527252112-7015-1-git-send-email-ilialin@codeaurora.org>
 <1527252112-7015-2-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527252112-7015-2-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-18, 15:41, Ilia Lin wrote:
> In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
> the CPU frequency subset and voltage value of each OPP varies
> based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> defines the voltage and frequency value based on the msm-id in SMEM
> and speedbin blown in the efuse combination.
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  MAINTAINERS                          |   7 ++
>  drivers/cpufreq/Kconfig.arm          |  10 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c  | 212 +++++++++++++++++++++++++++++++++++
>  5 files changed, 233 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
