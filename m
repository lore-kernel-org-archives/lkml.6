Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbeBZVSq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:18:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBZVSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:18:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F25760591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v2 0/3] Support qcom pinctrl protected pins
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <94a7bd07-8ad5-7ab1-20ab-a02fe2476efd@codeaurora.org>
 <CACRpkdbgz9PnyLgsn_grsGHbVnak54aOKhetsqfvag5wJNm7=g@mail.gmail.com>
 <20180223165455.GN93895@bjorns-mbp-2.lan>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <04facb14-1c6c-4fcd-a1f1-e1f132de5a32@codeaurora.org>
Date: Mon, 26 Feb 2018 15:18:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223165455.GN93895@bjorns-mbp-2.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 10:54 AM, Bjorn Andersson wrote:
> I haven't found the time to review the reuse of the irq valid mask or
> the effort needed to replace this, other than that I think the series
> looks good.

So is that an ACK?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
