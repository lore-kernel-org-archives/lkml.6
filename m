Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeERKRl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:17:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:37610 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeERKRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:17:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="scan'208";a="200457064"
Message-ID: <3aa1361401b4ada2da2b8aa7c22969dddc22723b.camel@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Program REMAP register in PIO mode
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Date: Fri, 18 May 2018 13:17:37 +0300
In-Reply-To: <20180425102559.GO2173@lahna.fi.intel.com>
References: <20180424150010.60760-1-andriy.shevchenko@linux.intel.com>
         <20180425102559.GO2173@lahna.fi.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-25 at 13:25 +0300, Mika Westerberg wrote:
> On Tue, Apr 24, 2018 at 06:00:10PM +0300, Andy Shevchenko wrote:
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
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Lee, can we have this applied in next rc cycle?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
