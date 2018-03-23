Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755142AbeCWLen (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:34:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:8198 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753689AbeCWLek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 07:34:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,349,1517904000";
   d="scan'208";a="27417433"
Message-ID: <1521804875.23017.95.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Timur Tabi <timur@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org
Date: Fri, 23 Mar 2018 13:34:35 +0200
In-Reply-To: <59df3700-c0bd-6ee8-eeab-6a49cb92d1db@codeaurora.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
         <20180321165848.89751-4-swboyd@chromium.org>
         <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
         <b5dac2f7-eabb-6e09-2146-775b09d4eca8@codeaurora.org>
         <59df3700-c0bd-6ee8-eeab-6a49cb92d1db@codeaurora.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 19:59 -0500, Timur Tabi wrote:
> On 03/22/2018 07:23 PM, Timur Tabi wrote:
> > 
> > Also, you don't allocate chip->valid_mask anywhere.
> 
> So I see now where it's allocated, but something is fishy.

No, it seems you missed %p vs. %px discussion.

The pointers printed by %p nowadays are hashed values, not the original
ones.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
