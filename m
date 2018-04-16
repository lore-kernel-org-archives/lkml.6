Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeDPAC2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 20:02:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59802 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbeDPAC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 20:02:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1D7C606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v2] phy: core: Allow phy_pm_runtime_xxx API calls with
 NULL phy
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-msm@vger.kernel.org,
        "open list:GENERIC PHY FRAMEWORK" <linux-kernel@vger.kernel.org>
References: <1521525707-23927-1-git-send-email-mgautam@codeaurora.org>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <06290d81-3c2d-9d88-7482-f092815a8d31@codeaurora.org>
Date: Mon, 16 Apr 2018 05:32:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521525707-23927-1-git-send-email-mgautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,


On 3/20/2018 11:31 AM, Manu Gautam wrote:
> phy_init() and phy_exit() calls, and phy_power_on() and
> phy_power_off() already accept NULL as valid PHY reference
> and act as NOP. Extend same concept to phy runtime_pm APIs
> to keep drivers (e.g. dwc3) code simple while dealing with
> optional PHYs.

Wondering if you had a chance to review this.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
