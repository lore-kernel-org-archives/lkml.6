Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeEVPzh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:55:37 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45362 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:55:32 -0400
X-Google-Smtp-Source: AB8JxZqpgtqUdrghpiwfzKAmnWo6CZfgFYJt9hP3GjbPJnUt5D6cCs3vIds6jab+ywRDwbHCnL869A==
Date: Tue, 22 May 2018 10:55:29 -0500
From: Rob Herring <robh@kernel.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v9 11/15] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
Message-ID: <20180522155529.GA30543@rob-hp-laptop>
References: <1526901932-9514-1-git-send-email-ilialin@codeaurora.org>
 <1526901932-9514-12-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526901932-9514-12-git-send-email-ilialin@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 02:25:28PM +0300, Ilia Lin wrote:
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> This change adds documentation for the DT bindings.
> The "operating-points-v2-kryo-cpu" DT extends the "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-supported-hw: A single 32 bit bitmap value,
>   representing compatible HW:
> 			0:	MSM8996 V3, speedbin 0
> 			1:	MSM8996 V3, speedbin 1
> 			2:	MSM8996 V3, speedbin 2
> 			3:	unused
> 			4:	MSM8996 SG, speedbin 0
> 			5:	MSM8996 SG, speedbin 1
> 			6:	MSM8996 SG, speedbin 2
> 			7-31:	unused
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Please add acks/reviewed-bys when posting new versions.

Rob
