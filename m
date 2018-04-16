Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeDPVrs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:47:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeDPVro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:47:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1DBF603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v3 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1523673401-21611-1-git-send-email-tdas@codeaurora.org>
 <1523673401-21611-3-git-send-email-tdas@codeaurora.org>
 <152390031768.51482.12790579493617671456@swboyd.mtv.corp.google.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <5af35710-b521-e22e-055b-798cbe343dc6@codeaurora.org>
Date: Mon, 16 Apr 2018 14:47:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <152390031768.51482.12790579493617671456@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Taniya,

On 04/16/2018 10:38 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-04-13 19:36:41)
>> Add the RPMh clock driver to control the RPMh managed clock resources on
>> some of the Qualcomm Technologies, Inc. SoCs.
>>
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> 
> Your signoff chain is very confused. The first signoff should match the
> "From:" header but that doesn't seem to be the case here. And the sender
> should be the last in the chain.

It looks like the provenance of this driver go muddled during downstream
propagation between branches.  The original downstream version of the
clk-rpmh driver was written by Osvaldo Banuelos [1].  I think that the
best course of action here would be to remove my Signed-off-by, add
Osvaldo's, and add yours.

Thanks,
David

[1]:
https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?id=11d3623c37afb945ce36755501812a44efeb6cd9

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
