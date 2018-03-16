Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeCPMpd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:45:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:45:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 017756016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v2 09/13] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c1
 board file
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-10-git-send-email-sricharan@codeaurora.org>
 <e09ea99753ce59e4b595ba3ecab36c8a@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <0a80b9b3-5e64-91b9-b5de-4aff09d5699a@codeaurora.org>
Date: Fri, 16 Mar 2018 18:15:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e09ea99753ce59e4b595ba3ecab36c8a@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2018 3:55 PM, Abhishek Sahu wrote:
> On 2018-03-16 15:08, Sricharan R wrote:
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/Makefile                      |  1 +
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts | 65 +++++++++++++++++++++++++
>>  2 files changed, 66 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index b71487a..8c93fd0 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -749,6 +749,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>      qcom-ipq4019-ap.dk01.1-c1.dtb \
>>      qcom-ipq4019-ap.dk04.1-c1.dtb \
>>      qcom-ipq4019-ap.dk04.1-c3.dtb \
>> +    qcom-ipq4019-ap.dk07.1-c1.dtb \
>>      qcom-ipq8064-ap148.dtb \
>>      qcom-msm8660-surf.dtb \
>>      qcom-msm8960-cdp.dtb \
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
>> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
>> new file mode 100644
>> index 0000000..4562f7f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
>> @@ -0,0 +1,65 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
>> +
>> +/ {
>> +    model = "Qualcomm Technologies, Inc. IPQ40xx/AP-DK07.1-C1";
> 
>  s/IPQ40xx/IPQ4019
> 
>  with that.
> 
>  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
  Thanks, will update

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
