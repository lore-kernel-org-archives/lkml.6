Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeCEWTl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:19:41 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34357 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCEWTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:19:38 -0500
X-Google-Smtp-Source: AG47ELtGipxLLpYFwLYPPfLYM5jg/kBbCEiGkkikrmNSA4dioICTnR8Kl8vWUF7xkuGp8xHMxTFVVg==
Date: Mon, 5 Mar 2018 16:19:36 -0600
From: Rob Herring <robh@kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: viresh.kumar@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
Subject: Re: [PATCH v8 15/15] dt-bindings: cpufreq: Document
 operating-points-v2-krait-cpu
Message-ID: <20180305221936.yu2mlcjodlcumedx@rob-hp-laptop>
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
 <1519740422-3835-16-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519740422-3835-16-git-send-email-sricharan@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 07:37:02PM +0530, Sricharan R wrote:
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
> operating-points-v2-krait-cpu specifies the phandle to nvmem efuse cells
> and the operating-points-v2 table for each opp. The qcom-cpufreq driver
> reads the efuse value from the SoC to provide the required information
> that is used to determine the voltage and current value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  .../devicetree/bindings/cpufreq/krait-cpufreq.txt  | 363 +++++++++++++++++++++
>  1 file changed, 363 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt

Reviewed-by: Rob Herring <robh@kernel.org>
