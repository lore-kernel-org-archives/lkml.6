Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755100AbeCSElh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 00:41:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52530 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeCSEle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 00:41:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E6386055B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH 5/6] dt-bindings: phy-qcom-usb2: Update bindings for
 sdm845
To: Rob Herring <robh@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-arm-msm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
 <1521193500-4696-6-git-send-email-mgautam@codeaurora.org>
 <20180318033421.bicewbj3s5wenuis@rob-hp-laptop>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <71f0d215-9d6b-efd6-d3fc-e11326615b2c@codeaurora.org>
Date: Mon, 19 Mar 2018 10:11:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318033421.bicewbj3s5wenuis@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 3/18/2018 6:22 PM, Rob Herring wrote:
> On Fri, Mar 16, 2018 at 03:14:58PM +0530, Manu Gautam wrote:
>> Update compatible strings for USB2 PHYs on sdm845.
>> There are two QUSB2 PHYs present on sdm845. Few PHY registers
>> programming is different for these PHYs related to electrical
>> parameters, otherwise both are same.
> Register locations are different or tuning values are different? For the 
> latter, is that something that could be DT properties?

There are only register values changes. Corresponding driver change:
https://patchwork.kernel.org/patch/10286803/


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
