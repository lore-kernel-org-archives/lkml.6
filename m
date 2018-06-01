Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbeFAHuu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:50:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:30718 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbeFAHut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:50:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,465,1520924400";
   d="scan'208";a="55690465"
Message-ID: <aab944d64a8860de28a29b0b2564626058fa207e.camel@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Program REMAP register in PIO mode
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Fri, 01 Jun 2018 10:50:46 +0300
In-Reply-To: <20180518135148.GP5130@dell>
References: <20180424150010.60760-1-andriy.shevchenko@linux.intel.com>
         <20180518135148.GP5130@dell>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 14:51 +0100, Lee Jones wrote:
> On Tue, 24 Apr 2018, Andy Shevchenko wrote:
> 
> > According to documentation REMAP register has to be programmed in
> > either DMA or PIO mode of the slice.
> > 
> > Move the DMA capability check below to let REMAP register be
> > programmed
> > in PIO mode.
> > 
> > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS
> > devices")
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/intel-lpss.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Applied and tagged for -stable # 4.3+

Thanks!

Though can not see it in Linus' tree still.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
