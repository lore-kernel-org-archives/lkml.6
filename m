Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeDBF2j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:28:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeDBF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:28:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0931E6022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v5 05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
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
 <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
 <20180327170450.GH1403@tuxbook-pro>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <41dbb135-f392-3450-029f-bab5a8e2f9d8@codeaurora.org>
Date: Mon, 2 Apr 2018 10:58:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327170450.GH1403@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2018 10:34 PM, Bjorn Andersson wrote:
> On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
>> +	soc {
>> +		pinctrl@1000000 {
>> +			serial_0_pins: serial0_pinmux {
> 
> Please, no underscores in the node name.

 ok.

> 
>> +				mux {
> 
> Fyi, you can put the pinctrl properties directly into the state node,
> omitting the "mux" level.
> 

 ok, will change.

>> +					pins = "gpio16", "gpio17";
>> +					function = "blsp_uart0";
>> +					bias-disable;
>> +				};
>> +			};
>> +
> 
> Apart from this the patch looks good.
 Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
