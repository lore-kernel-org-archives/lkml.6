Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeCONCN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:02:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:60360 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752071AbeCONCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:02:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="35249851"
Message-ID: <1521118928.10722.658.camel@linux.intel.com>
Subject: Re: [PATCH v10] mmc: Export host capabilities to debugfs.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Harish Jenny K N <harish_kandiga@mentor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, avri.altman@wdc.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
Date: Thu, 15 Mar 2018 15:02:08 +0200
In-Reply-To: <CAPDyKFrZaDx2NdvaFdgOxWBuwtjMnJE41p=x5b2x2moFEO3kXQ@mail.gmail.com>
References: <1520917812-20047-1-git-send-email-harish_kandiga@mentor.com>
         <CAPDyKFo8jFwDO1E=tNSd4yTn3qtefzvHK0V70fcEqzB=SibrJA@mail.gmail.com>
         <1521109575.10722.654.camel@linux.intel.com>
         <CAPDyKFrZaDx2NdvaFdgOxWBuwtjMnJE41p=x5b2x2moFEO3kXQ@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 13:29 +0100, Ulf Hansson wrote:
> On 15 March 2018 at 11:26, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, 2018-03-15 at 11:12 +0100, Ulf Hansson wrote:
> > > On 13 March 2018 at 06:10, Harish Jenny K N <harish_kandiga@mentor
> > > .com
> > > > wrote:
> > > > 
> > > Honestly, I don't like this, but maybe other people do, then I am
> > > fine
> > > with this approach.
> > > 
> > > If were to decide, I would just rather print the caps field in a
> > > hexadecimal bit form and leave the translation to the user.
> > 
> > A compromise would be to print both:
> > 
> > 0xHHHHHHHH\n
> > Description of each enabled field, one per line
> > 
> > 
> > Another format would be:
> > 
> > Bit XX: Description of a field
> 
> If we were to print the description, there is no point in printing the
> bits in hex. Or is it?

It is helpful for scripting (since it's debugfs, under scripting I mean
something rather for test suites than for actual use).

> As I said, if you and other folkz thinks this is valuable, then I am
> fine as well. Just saying, it's not my preferred option.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
