Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754307AbeDBGM0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:12:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41970 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754282AbeDBGMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:12:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6888601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v5 10/13] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2
 board file
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-11-git-send-email-sricharan@codeaurora.org>
 <20180327172917.GM1403@tuxbook-pro>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <a0bf3ee8-10f5-7384-8f87-bec3649040b4@codeaurora.org>
Date: Mon, 2 Apr 2018 11:42:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327172917.GM1403@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 3/27/2018 10:59 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> 
>> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/Makefile                      |  1 +
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts | 26 +++++++++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index ae7f214..3b65e30 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -750,6 +750,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>  	qcom-ipq4019-ap.dk04.1-c1.dtb \
>>  	qcom-ipq4019-ap.dk04.1-c3.dtb \
>>  	qcom-ipq4019-ap.dk07.1-c1.dtb \
>> +	qcom-ipq4019-ap.dk07.1-c2.dtb \
>>  	qcom-ipq8064-ap148.dtb \
>>  	qcom-msm8660-surf.dtb \
>>  	qcom-msm8960-cdp.dtb \
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
>> new file mode 100644
>> index 0000000..c1e909c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1-C2";
> 
> compatible
> 

 ok.

> Apart from that you have my
> 
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 

 Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
