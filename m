Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeERNrf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:47:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52052 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbeERNrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:47:31 -0400
X-Google-Smtp-Source: AB8JxZrhwdw43vYVgeVIM2ILBeK3evxOjEQYR+xYwTzoBbebY+7O63xsP23+IMANDdauVzYH2u0JyA==
Date: Fri, 18 May 2018 14:47:27 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Program REMAP register in PIO mode
Message-ID: <20180518134727.GO5130@dell>
References: <20180424150010.60760-1-andriy.shevchenko@linux.intel.com>
 <20180425102559.GO2173@lahna.fi.intel.com>
 <3aa1361401b4ada2da2b8aa7c22969dddc22723b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aa1361401b4ada2da2b8aa7c22969dddc22723b.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018, Andy Shevchenko wrote:

> On Wed, 2018-04-25 at 13:25 +0300, Mika Westerberg wrote:
> > On Tue, Apr 24, 2018 at 06:00:10PM +0300, Andy Shevchenko wrote:
> > > According to documentation REMAP register has to be programmed in
> > > either DMA or PIO mode of the slice.
> > > 
> > > Move the DMA capability check below to let REMAP register be
> > > programmed
> > > in PIO mode.
> > > 
> > > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS
> > > devices")
> > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Lee, can we have this applied in next rc cycle?

This has been broken since v4.3.

We'll roll it into v4.18 and tag it for -stable.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
