Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbeCWODp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:03:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeCWODl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:03:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 874D06030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
 <b5dac2f7-eabb-6e09-2146-775b09d4eca8@codeaurora.org>
 <59df3700-c0bd-6ee8-eeab-6a49cb92d1db@codeaurora.org>
 <1521804875.23017.95.camel@linux.intel.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <819014ea-d375-5830-e32f-eeba73e6fa08@codeaurora.org>
Date: Fri, 23 Mar 2018 09:03:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521804875.23017.95.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/18 6:34 AM, Andy Shevchenko wrote:
> No, it seems you missed %p vs. %px discussion.
> 
> The pointers printed by %p nowadays are hashed values, not the original
> ones.

I totally forgot about that, thanks.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
