Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934405AbeCEKnq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:43:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbeCEKnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:43:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B0F9601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v5 4/4] arm64: dts: sdm845: Add serial console support
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: andy.gross@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org,
        evgreen@chromium.org, dianders@chromium.org, marc.zyngier@arm.com,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
References: <20180222061208.2031-1-rnayak@codeaurora.org>
 <20180222061208.2031-5-rnayak@codeaurora.org>
 <20180304195930.GQ93895@bjorns-mbp-2.lan>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <9d24e89f-38be-59e4-6f76-c273dd4d4e79@codeaurora.org>
Date: Mon, 5 Mar 2018 16:13:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180304195930.GQ93895@bjorns-mbp-2.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/05/2018 01:29 AM, Bjorn Andersson wrote:
> On Wed 21 Feb 22:12 PST 2018, Rajendra Nayak wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> [..]
>> +			qup_uart2: serial@a84000 {
>> +				compatible = "qcom,geni-debug-uart";
>> +				reg = <0xa84000 0x4000>;
>> +				reg-names = "se-phys";
>> +				clock-names = "se-clk";
> 
> This was changed to "se" in v3 of the GENI patchset, with that this
> boots nicely again.

Thanks Bjorn for testing.

Karthik, it would be good if you could include just this patch from this series as part
of your GENI series for the next (and subsequent) repost, with updates as needed based on
binding changes?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
