Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbeCLHCF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:02:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45102 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeCLHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:02:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EC27603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 1/6] reset: qcom: AOSS (Always on subsystem) reset
 controller
To: Trilok Soni <tsoni@codeaurora.org>, Rob Herring <robh@kernel.org>
Cc: bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <1520243613-30393-1-git-send-email-sibis@codeaurora.org>
 <1520243613-30393-2-git-send-email-sibis@codeaurora.org>
 <20180307213514.4sv7ucxo25jpomz3@rob-hp-laptop>
 <519c6298-0619-d98e-6c45-c70936af93c3@codeaurora.org>
 <4a45b7a5-5bc4-ed03-0cf4-c87c8b99fbb2@codeaurora.org>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <5a73b5fb-d70b-5bbc-e9ba-ce343d3985c3@codeaurora.org>
Date: Mon, 12 Mar 2018 12:31:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <4a45b7a5-5bc4-ed03-0cf4-c87c8b99fbb2@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trilok,
Thanks for the review. I will include it in the v3 patch series.

On 03/10/2018 02:59 AM, Trilok Soni wrote:
> Sibi,
> 
> One cosmetic comment below.
> 
> On 3/9/2018 6:55 AM, Sibi S wrote:
>> +
>>>> +This binding describes a reset-controller found on AOSS (Always on 
>>>> SubSysem)
>>>> +for Qualcomm SDM845 SoCs.
> 
> S/SubSysem/Subsytem
>


Will correct it

> ---Trilok Soni
> 
> 
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
