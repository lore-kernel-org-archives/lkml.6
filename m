Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeCTKmT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:42:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeCTKmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:42:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 625AB602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH 5/6] dt-bindings: phy-qcom-usb2: Update bindings for
 sdm845
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
 <1521193500-4696-6-git-send-email-mgautam@codeaurora.org>
 <229f884f-e349-9e2d-86fb-6f4d69608814@codeaurora.org>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <63f9f102-db60-7b23-2624-e47ab0f6833b@codeaurora.org>
Date: Tue, 20 Mar 2018 16:12:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <229f884f-e349-9e2d-86fb-6f4d69608814@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 3/20/2018 3:53 PM, Vivek Gautam wrote:
> Hi Manu,
>
>
> On 3/16/2018 3:14 PM, Manu Gautam wrote:
>> Update compatible strings for USB2 PHYs on sdm845.
>> There are two QUSB2 PHYs present on sdm845. Few PHY registers
>> programming is different for these PHYs related to electrical
>> parameters, otherwise both are same.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> index 42c9742..20deaeb 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> @@ -6,7 +6,9 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
>>   Required properties:
>>    - compatible: compatible list, contains
>>              "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
>> -           "qcom,qusb2-v2-phy" for QUSB2 V2 PHY.
>> +           "qcom,qusb2-v2-phy" for QUSB2 V2 PHY,
>> +           "qcom,sdm845-1-qusb2-phy" for primary PHY on sdm845,
>> +           "qcom,sdm845-2-qusb2-phy" for secondary PHY on sdm845.
>
> Thanks for the patch.
>
> "qcom,sdm845-1/2-qusb2-phy" gives an impression that it is different versions of SoC,
> and not like two numbers of phy.
> May be - "qcom,sdm845-qusb2-phy-1/2"

I agree with that. Will update.

>
> Regards
> Vivek
>  
>
>>      - reg: offset and length of the PHY register set.
>>    - #phy-cells: must be 0.
>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
