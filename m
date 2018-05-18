Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeERO0o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:26:44 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37580 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbeERO0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:26:41 -0400
X-Google-Smtp-Source: AB8JxZqJp3j3IDM59LTBZuRFZPiVyw5wPejKEnJacRPKrBWsqz7Opn0x9LlhT/jU/WaRFn8U3rNtbA==
Date: Fri, 18 May 2018 09:26:39 -0500
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
Subject: Re: [PATCH v8 11/15] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
Message-ID: <20180518142639.GA3877@rob-hp-laptop>
References: <1526555955-29960-1-git-send-email-ilialin@codeaurora.org>
 <1526555955-29960-12-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526555955-29960-12-git-send-email-ilialin@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 02:19:11PM +0300, Ilia Lin wrote:
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
> ---
>  .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
>  1 file changed, 680 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt

Reviewed-by: Rob Herring <robh@kernel.org>
