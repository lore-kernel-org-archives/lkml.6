Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeE2Ic3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:32:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932121AbeE2IcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:32:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BAB360541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [RFC PATCH 5/5] remoteproc: qcom: Introduce Hexagon V5 based WCSS
 driver
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod <vkoul@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
 <20180523052054.19025-6-bjorn.andersson@linaro.org>
 <20180523060516.GD20991@vkoul-mobl> <20180523065815.GZ14924@minitux>
 <20180523073723.GF20991@vkoul-mobl>
 <fa0af8c1-f635-13e7-e600-4c1f91a48351@codeaurora.org>
 <20180529040742.GD2259@tuxbook-pro>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <7a2e86a2-00bc-cd64-6d86-4c5e8c7a7b0e@codeaurora.org>
Date: Tue, 29 May 2018 14:02:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529040742.GD2259@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 5/29/2018 9:37 AM, Bjorn Andersson wrote:
> On Wed 23 May 07:48 PDT 2018, Sricharan R wrote:
>> On 5/23/2018 1:07 PM, Vinod wrote:
>>> On 22-05-18, 23:58, Bjorn Andersson wrote:
>>>> On Tue 22 May 23:05 PDT 2018, Vinod wrote:
>>>>> On 22-05-18, 22:20, Bjorn Andersson wrote:
> [..]
>>>>> Looking at the patch, few other comments would be applicable too, so would be
>>>>> great if you/Sricharan can update this
>>>>>
>>>>
>>>> I agree, the primary purpose of this patch was rather to get feedback on
>>>> the structure of the drivers, I do expect this to take another round
>>>> through the editor to get some polishing touches. Sorry if this wasn't
>>>> clear from the description.
>>>
>>> Since Sricharan replied to comments, I though they would be fixed. Yeah this is
>>> fine from RFC..
>>>
>>
>>  Thanks for this.
>>
>>  Tested this on ipq8074 and wcss rproc is up with this.
>>
>>  Tested-by: Sricharan R <sricharan@codeaurora.org>
>>
> 
> Thanks Sricharan!
> 
>>  So regarding the cleanup, as i see, this consolidates the code much better.
>>
>>  so about the point of avoiding duplication for soc specific functions like
>>  qcv5_wcss_reset common between qcv5_wcss and qcv5_pil drivers as done in my
>>  series, with a second thought that feels it might be difficult to maintain
>>  in the longer run. Since the sequences are specific to each soc and for now
>>  although some part of it is common, for a minor update in one soc, common
>>  code needs to reworked every time and tested on all boards that share them.
>>
>>  So feels like having the duplication for hw init sequences is the cleaner way.
>>
> 
> Sounds good, then let's go with this approach!
> 
>>  Apart from that for other comments on the q6v5 wcss driver, i can address them
>>  on this final patch that you have posted and same can be included in your
>>  next version. Please let me know how you want to go about it.
>>
> 
> If you can help me review the first 4 patches and fix up and resend the
> 5th that would be greatly appreciated.

 Sure, will do.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
