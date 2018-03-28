Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeC1H17 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:27:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeC1H14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:27:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E50B8607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v3 5/6] dt-bindings: phy-qcom-usb2: Update bindings for
 sdm845
To: Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org>
 <1521785487-29866-6-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=U03Hijg5NPiY5=5JQJpobJnUNAkf361OOdNRLVc5joWQ@mail.gmail.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <bd13a81d-9f8a-fa3d-11cc-561105d39257@codeaurora.org>
Date: Wed, 28 Mar 2018 12:57:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=U03Hijg5NPiY5=5JQJpobJnUNAkf361OOdNRLVc5joWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 3/28/2018 3:27 AM, Doug Anderson wrote:
> Hi,
>
> On Thu, Mar 22, 2018 at 11:11 PM, Manu Gautam <mgautam@codeaurora.org> wrote:
>> Update compatible strings for USB2 PHYs on sdm845.
>> There are two QUSB2 PHYs present on sdm845. Few PHY registers
>> programming is different for these PHYs related to electrical
>> parameters, otherwise both are same.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> index 42c9742..b99a57f 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> @@ -6,7 +6,9 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
>>  Required properties:
>>   - compatible: compatible list, contains
>>                "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
>> -              "qcom,qusb2-v2-phy" for QUSB2 V2 PHY.
>> +              "qcom,qusb2-v2-phy" for QUSB2 V2 PHY,
>> +              "qcom,sdm845-qusb2-phy-1" for primary PHY on sdm845,
>> +              "qcom,sdm845-qusb2-phy-2" for secondary PHY on sdm845.
> Similar question to the one I posed on
> <https://patchwork.kernel.org/patch/10302761/> for the QMP PHY.  What
> is "qcom,qusb2-v2-phy"?  Is it some ideal abstract version of the PHY?
>  Do we expect that anyone would actually use that compatible string?
>
> In this case in <https://patchwork.kernel.org/patch/10302755/> it
> looks as if you're using the same settings as
> "qcom,sdm845-qusb2-phy-2", so presumably "qcom,qusb2-v2-phy" should
> just be deleted.
>

I will remove "qcom,qusb2-v2-phy".


> -Doug

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
