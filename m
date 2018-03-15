Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbeCOK0V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:26:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:17439 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCOK0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:26:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="35216729"
Message-ID: <1521109575.10722.654.camel@linux.intel.com>
Subject: Re: [PATCH v10] mmc: Export host capabilities to debugfs.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, avri.altman@wdc.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
Date: Thu, 15 Mar 2018 12:26:15 +0200
In-Reply-To: <CAPDyKFo8jFwDO1E=tNSd4yTn3qtefzvHK0V70fcEqzB=SibrJA@mail.gmail.com>
References: <1520917812-20047-1-git-send-email-harish_kandiga@mentor.com>
         <CAPDyKFo8jFwDO1E=tNSd4yTn3qtefzvHK0V70fcEqzB=SibrJA@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 11:12 +0100, Ulf Hansson wrote:
> On 13 March 2018 at 06:10, Harish Jenny K N <harish_kandiga@mentor.com
> > wrote:
> > 

> Honestly, I don't like this, but maybe other people do, then I am fine
> with this approach.
> 
> If were to decide, I would just rather print the caps field in a
> hexadecimal bit form and leave the translation to the user.

A compromise would be to print both:

0xHHHHHHHH\n
Description of each enabled field, one per line


Another format would be:

Bit XX: Description of a field

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
