Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeEEDse (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 23:48:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeEEDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 23:48:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5008460AE0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1] clk: qcom: gdsc: Add support to poll CFG register to
 check GDSC state
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1525151013-28291-1-git-send-email-tdas@codeaurora.org>
 <152524425583.138124.2497854182982735033@swboyd.mtv.corp.google.com>
 <e1d6f7a1-9b2b-113a-4c21-4730c6514e9c@codeaurora.org>
 <152548867593.138124.17769741201119581476@swboyd.mtv.corp.google.com>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <aae43315-1506-983d-312c-e28f1cc46b71@codeaurora.org>
Date: Sat, 5 May 2018 09:18:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152548867593.138124.17769741201119581476@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah sure Stephen.

On 5/5/2018 8:21 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-05-03 02:09:57)
>> Hello Stephen,
>>
>> I have tested the below patch & didn't see any issues.
> 
> Alright. Thanks! Can I take that as a "Tested-by"?
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
