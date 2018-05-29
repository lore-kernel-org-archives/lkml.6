Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935047AbeE2Ohw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:37:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934608AbeE2Ohs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:37:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B59AF60261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v5 5/8] dt-bindings: remoteproc: Add Q6v5 Modem PIL
 binding for SDM845
To: Rob Herring <robh@kernel.org>
Cc: bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180521172714.8551-1-sibis@codeaurora.org>
 <20180521172714.8551-6-sibis@codeaurora.org>
 <20180522155626.GA2744@rob-hp-laptop>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <3ef231eb-b6c4-b173-89fe-88e376a30b72@codeaurora.org>
Date: Tue, 29 May 2018 20:07:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180522155626.GA2744@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Will send it out again.

On 05/22/2018 09:26 PM, Rob Herring wrote:
> On Mon, May 21, 2018 at 10:57:11PM +0530, Sibi Sankar wrote:
>> Add new compatible string for Qualcomm SDM845 SoCs
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Please add acks/reviewed-bys when posting new versions.
> 
> Rob
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
