Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBFFz4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 00:55:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeBFFzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 00:55:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9ABB56014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 05/15] ARM: dts: ipq4019: Add ipq4019-ap-dk01-c2 board
 file
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk,
        bjorn.andersson@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-arm-msm-owner@vger.kernel.org,
        linux-soc@vger.kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-6-git-send-email-sricharan@codeaurora.org>
 <9afb20e560a7ebbcefcb801e7447a983@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <508a5777-a009-15d9-6d5a-bed1b1bfa1e7@codeaurora.org>
Date: Tue, 6 Feb 2018 11:25:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9afb20e560a7ebbcefcb801e7447a983@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2/3/2018 4:25 PM, Abhishek Sahu wrote:
> On 2018-01-29 10:41, Sricharan R wrote:
>> The board has a spi-nand interface on spi0 bus chipselect1.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/Makefile                      |  1 +
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts | 25
>> +++++++++++++++++++++++++
>>  2 files changed, 26 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index d0381e9..21ed56d 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -724,6 +724,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>      qcom-apq8084-ifc6540.dtb \
>>      qcom-apq8084-mtp.dtb \
>>      qcom-ipq4019-ap.dk01.1-c1.dtb \
>> +    qcom-ipq4019-ap.dk01.1-c2.dtb \
>>      qcom-ipq8064-ap148.dtb \
>>      qcom-msm8660-surf.dtb \
>>      qcom-msm8960-cdp.dtb \
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts
>> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts
>> new file mode 100644
>> index 0000000..e3442da
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts
>> @@ -0,0 +1,25 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk01.1.dtsi"
>> +
>> +/ {
>> +    model = "Qualcomm Technologies, Inc. IPQ40xx/AP-DK01.1-C2";
> 
>  s/IPQ40xx/IPQ4019
> 
 ok

>> +
>> +    soc {
>> +        spi_0: spi@78b5000 { /* BLSP1 QUP1 */
>> +            status = "ok";
>> +            cs-gpios = <&tlmm 54 0>, <&tlmm 59 0>;
> 
>  the base dk01 file has pinmux for 54 only.
>  for 59 pin, we need to add pinmux entry also.
> 

 ok. btw, infact think that 59 should be removed.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
