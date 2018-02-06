Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeBFE1l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:27:41 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44096 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeBFE1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:27:32 -0500
X-Google-Smtp-Source: AH8x227rgUXtEzi7Y9TK4eqzWP68Ar+/k0VDEupJK5YvLcJDD047Q49M7lNUqJVqbBt1h8Lm7IZteg==
Date: Tue, 6 Feb 2018 09:57:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v6 15/15] dt-bindings: cpufreq: Document
 operating-points-v2-krait-cpu
Message-ID: <20180206042729.GH28462@vireshk-i7>
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
 <1517890108-8140-16-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517890108-8140-16-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-18, 09:38, Sricharan R wrote:
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

You can add my Ack if Rob also finds everything to be fine here.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
