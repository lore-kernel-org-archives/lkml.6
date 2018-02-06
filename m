Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeBFEq6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:46:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeBFEqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:46:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8D2C60558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 01/15] firmware: qcom: scm: Add ipq4019 soc compatible
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        sboyd@codeaurora.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-2-git-send-email-sricharan@codeaurora.org>
 <20180205022530.xf64gqeijicewdla@rob-hp-laptop>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <23641ff4-59c9-cf14-8fef-12614e265512@codeaurora.org>
Date: Tue, 6 Feb 2018 10:16:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205022530.xf64gqeijicewdla@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2/5/2018 11:37 AM, Rob Herring wrote:
> On Mon, Jan 29, 2018 at 10:41:15AM +0530, Sricharan R wrote:
>> Add the compatible for ipq4019.
>> This does not need clocks to do scm calls.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
>>  drivers/firmware/qcom_scm.c                             | 3 +++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

 Thanks !!

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
