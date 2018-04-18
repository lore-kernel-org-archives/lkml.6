Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeDRIjZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:39:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeDRIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:39:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0832F60500
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [v5,05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
To: Sven Eckelmann <sven.eckelmann@openmesh.com>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com
References: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
 <2284833.pBtR1QS54F@bentobox>
 <734eb6eb-9af9-d599-81f1-ec66d9cd839c@codeaurora.org>
 <2715737.hC3rduhfyA@bentobox>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <7008f7bb-300e-c2ce-cb2a-61ecfccf3691@codeaurora.org>
Date: Wed, 18 Apr 2018 14:09:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2715737.hC3rduhfyA@bentobox>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On 4/18/2018 1:08 PM, Sven Eckelmann wrote:
> Hi,
> 
> On Mittwoch, 18. April 2018 12:45:20 CEST Sricharan R wrote:
>>  Right, will add the above change to soc.dtsi in V6. Does that sound ok for 
>> you ?
> 
> I have submitted a patch for this now [1] because I need this for OpenWrt 
> (sooner rather than later). And I am not sure whether it is good to have this 
> in your feature series because it is a bugfix which might even qualify for 
> stable@vger.kernel.org.
> 
> I hope this patch [1] is ok for you.
> 

 Sure. Acked that. Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
