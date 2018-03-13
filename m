Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeCMWMY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:12:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47266 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbeCMWMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:12:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAAAA60390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=austinwc@codeaurora.org
Subject: Re: [PATCH v2 00/13] Major code reorganization to make all i2c
 transfers working
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
 <2a092d8f-6d1a-27e4-01f6-49790f767ae6@codeaurora.org>
 <20180313211758.kv5voneg4akm3rqo@ninjato>
From: "Christ, Austin" <austinwc@codeaurora.org>
Message-ID: <cf4b43fc-8051-77d1-c4f0-e46cb209fa49@codeaurora.org>
Date: Tue, 13 Mar 2018 16:12:19 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313211758.kv5voneg4akm3rqo@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the miscommunication. I reviewed the patches and tested them 
on the Centriq 2400 platform.

Perhaps the following is the most appropriate.

Acked-by: Austin Christ <austinwc@codeaurora.org>


On 3/13/2018 3:17 PM, Wolfram Sang wrote:
> On Tue, Mar 13, 2018 at 03:09:00PM -0600, Christ, Austin wrote:
>> I've tested this v2 series on Centriq 2400. Looks good to me.
>>
>> Reviewed-by: Austin Christ <austinwc@codeaurora.org>
> 
> I am a little confused. Do you mean Tested-by or Reviewed-by?
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
