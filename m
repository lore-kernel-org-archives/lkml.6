Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeBTQpI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:45:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35326 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeBTQpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:45:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2A9860712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v2 0/3] Support qcom pinctrl protected pins
To: Stephen Boyd <sboyd@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-gpio@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
        devicetree@vger.kernel.org
References: <20180126011400.2191-1-sboyd@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <94a7bd07-8ad5-7ab1-20ab-a02fe2476efd@codeaurora.org>
Date: Tue, 20 Feb 2018 10:45:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180126011400.2191-1-sboyd@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25/2018 07:13 PM, Stephen Boyd wrote:
> This patchset proposes a solution to describing the valid
> pins for a pin controller in a semi-generic way so that qcom
> platforms can expose the pins that are really available.
> 
> Typically, this has been done by having drivers and firmware
> descriptions only use pins they know they have access to, and that
> still works now because we no longer read the pin direction at
> boot. But there are still some userspace drivers and debugfs facilities
> that don't know what pins are available and attempt to read everything
> they can. On qcom platforms, this may lead to a system hang, which isn't
> very nice behavior, even if root is the only user that can trigger it.

Any progress on this patch set?  Stephen no longer works for Qualcomm, 
so I don't know what the next step is, and I really want this feature in 
4.17 (we've missed so many merge windows already).

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
