Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCWXuX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:50:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeCWXuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:50:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7AA7607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v4 0/5] Support qcom pinctrl protected pins
To: Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20180323163453.96495-1-swboyd@chromium.org>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <d7e0d2e1-c0d8-f751-7a73-71d5ab15bf52@codeaurora.org>
Date: Fri, 23 Mar 2018 18:50:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323163453.96495-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 11:34 AM, Stephen Boyd wrote:
> Stephen Boyd (5):
>    dt-bindings: gpio: Add a gpio-reserved-ranges property
>    gpiolib: Extract mask allocation into subroutine
>    gpiolib: Change bitmap allocation to kmalloc_array
>    gpiolib: Support 'gpio-reserved-ranges' property
>    pinctrl: qcom: Don't allow protected pins to be requested

ACPI parts:

Tested-by: Timur Tabi <timur@codeaurora.org>

I posted a pair of patches that should be applied on top of yours.  The 
first one fixed pinctrl-msm when there is more than one TLMM device. 
The second adds support for my SOC.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
