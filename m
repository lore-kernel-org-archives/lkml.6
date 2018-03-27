Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeC0HNS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:13:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeC0HNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:13:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Mar 2018 15:13:15 +0800
From: cang@codeaurora.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: phy-qcom-qmp: Add UFS phy compitable
 string for sdm845
In-Reply-To: <20dcdb46-deda-def5-76d1-0ed5efb40a7a@codeaurora.org>
References: <20180321053720.12780-1-cang@codeaurora.org>
 <20180321053720.12780-3-cang@codeaurora.org>
 <20dcdb46-deda-def5-76d1-0ed5efb40a7a@codeaurora.org>
Message-ID: <bb8740302ee88c920811802c11306f70@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-26 23:00, Vivek Gautam wrote:
> On 3/21/2018 11:07 AM, Can Guo wrote:
>> Update the compatible string for UFS QMP PHY on SDM845.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt 
>> b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> index cef8765..6e68a6d 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> @@ -11,7 +11,8 @@ Required properties:
>>   	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>>   	       "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy,
>>   	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>> -	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on 
>> sdm845.
>> +	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on 
>> sdm845,
>> +	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> 
> We also need an entry for 'ref_aux' clock in the clock names for this 
> phy.
> Please add that.
> With that,
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> 
> Thanks
> Vivek.
> 

I realized that 'ref_aux' is not needed in the driver, shall remove it 
from the PHY driver.

Thanks
Can.

>>      - reg: offset and length of register set for PHY's common serdes 
>> block.
>> 
