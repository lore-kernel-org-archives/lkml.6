Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeDRHPb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:15:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeDRHP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:15:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CBB26030D
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
 <2641190.FRMBLJWkCS@bentobox> <2284833.pBtR1QS54F@bentobox>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <734eb6eb-9af9-d599-81f1-ec66d9cd839c@codeaurora.org>
Date: Wed, 18 Apr 2018 12:45:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2284833.pBtR1QS54F@bentobox>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On 4/18/2018 12:37 PM, Sven Eckelmann wrote:
> On Mittwoch, 18. April 2018 08:59:46 CEST Sven Eckelmann wrote:
> [...]
>> I would not know how to disable QSEE on these boards and thus would assume 
>> that it should be part of this dtsi.
> 
> 
> Just did some reviews of the reserved-memory regions in other QCA devices and 
> it looks like this tz and smem are often directly added to the SoC dtsi. So I 
> will prepare a similar change for qcom-ipq4019.dtsi and this would then solve 
> it for AP-DK01/04/07 and no changes in the board-family specific dtsi would be 
> necessary.
> 
> But maybe someone has an objection because tz and smem can actually be 
> disabled in a sane way on these SoCs and thus it would be better to have these 
> regions in the board specific dts(i) files. We will see...

 Right, will add the above change to soc.dtsi in V6. Does that sound ok for you ?

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
