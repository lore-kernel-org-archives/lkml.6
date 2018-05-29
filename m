Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbeE2JuE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:50:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeE2JuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:50:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11D8B6021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: opp: Introduce qcom-opp bindings
To: David Collins <collinsd@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180525100121.28214-1-rnayak@codeaurora.org>
 <20180525100121.28214-3-rnayak@codeaurora.org>
 <67054dca-33a8-7e7c-6218-dc5abf84f6d8@codeaurora.org>
Message-ID: <9786fd42-b48a-757f-97cb-0ca65c2f030e@codeaurora.org>
Date: Tue, 29 May 2018 15:19:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <67054dca-33a8-7e7c-6218-dc5abf84f6d8@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/26/2018 04:03 AM, David Collins wrote:
> Hello Rajendra,
> 
> On 05/25/2018 03:01 AM, Rajendra Nayak wrote:
>> On Qualcomm platforms, an OPP node needs to describe an
> 
> s/Qualcomm/Qualcomm Technologies, Inc./
> 
> 

[] ..

> 
> s/Qualcomm/Qualcomm Technologies, Inc./ ?
> 
> s/descibe/describe/
> 
> 
>> +
>> +OPP tables for devices on Qualcomm platforms require an additional
> 
> s/Qualcomm/Qualcomm Technologies, Inc./
> 
> 
>> +platform specific corner/level value to be specified.
>> +This value is passed on to the RPM (Resource Power Manager) by
> 
> Do you want to mention RPMh here as well?
> 
> 

[] ..

>> +
>> +Required properties:
>> +- qcom,level: On Qualcomm platforms an OPP node can describe a positive value
> 
> s/Qualcomm/Qualcomm Technologies, Inc./
> 
> 
>> +representing a corner/level that's communicated with a remote microprocessor
>> +(usually called the RPM) which then translates it into a certain voltage on
>> +a voltage rail.
> 
> Should these lines be indented 2 spaces as is the case for the compatible
> property above?
> 
> Could you add an example for both RPM and RPMh in this binding file?

Thanks David for the review. I will fix all this up when I respin.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
