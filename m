Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeDBGLG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:11:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40400 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeDBGLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:11:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3379F601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v5 09/13] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c1
 board file
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        richardcochran@gmail.com, will.deacon@arm.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        absahu@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        linux-soc@vger.kernel.org, sboyd@codeaurora.org,
        linux-arm-kernel@lists.infradead.org
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-10-git-send-email-sricharan@codeaurora.org>
 <20180327172219.GL1403@tuxbook-pro>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <9ec8f97d-59a9-09d0-c68c-86206601446a@codeaurora.org>
Date: Mon, 2 Apr 2018 11:40:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327172219.GL1403@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2018 10:52 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
>> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1-C1";
> 
> Add compatible for the board.
> 

 ok.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
