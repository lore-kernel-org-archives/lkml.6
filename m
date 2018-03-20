Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeCTDk7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:40:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbeCTDky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:40:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B6B060131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: Add a reserved-gpio-ranges
 property
To: Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <20180126011400.2191-2-sboyd@codeaurora.org>
 <CACRpkdbAYPpcoyVkMm=yKABMByJuCyXdYifuFdYhV4g6CU3sEg@mail.gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <3192b736-6d0f-2107-7171-b9c18138a648@codeaurora.org>
Date: Mon, 19 Mar 2018 22:40:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbAYPpcoyVkMm=yKABMByJuCyXdYifuFdYhV4g6CU3sEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/18 10:36 PM, Linus Walleij wrote:
> This looks fine except Andy's note to rename this ranges
> to gpio-reserved-ranges for namespacing.
> 
> Are you reposting this series as v3 with this fixed or does someone
> else need to pick it up?

I will pick this up if Stephen wants me to.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
