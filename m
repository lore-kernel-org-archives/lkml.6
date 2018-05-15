Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeEOEEs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 00:04:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39531 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752160AbeEOEEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 00:04:45 -0400
X-Google-Smtp-Source: AB8JxZqQO6m77lEui/iNmaGFww+uleg+FiGuO/EZYg1FyZdBpdSTdrNL1jwQPPMFXcmaSTQRi4eKcA==
Date: Tue, 15 May 2018 09:34:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, nm@ti.com, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v6 11/14] dt: qcom: Add SAW regulator for 8x96 CPUs
Message-ID: <20180515040439.3kt6dudim2uroumd@vireshk-i7>
References: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
 <1526303520-5843-12-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526303520-5843-12-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-05-18, 16:11, Ilia Lin wrote:
> 1. Add syscon node for the SAW CPU registers
> 2. Add SAW regulators gang definition for s8-s11
> 3. Add voltages to the OPP tables
> 4. Add the s11 SAW regulator as CPU regulator
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 75 +++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
