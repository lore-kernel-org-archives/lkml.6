Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbeFDFeV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 01:34:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36039 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeFDFeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:34:20 -0400
X-Google-Smtp-Source: ADUXVKJxWGJ9iuWxOpJtP51VK0HkPOkwuWs9jMdWWCr4iOfne7hfpVq+YPXK05RnPnop6WsJP87Vdg==
Date: Mon, 4 Jun 2018 06:34:17 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Program REMAP register in PIO mode
Message-ID: <20180604053417.GC17993@dell>
References: <20180424150010.60760-1-andriy.shevchenko@linux.intel.com>
 <20180518135148.GP5130@dell>
 <aab944d64a8860de28a29b0b2564626058fa207e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aab944d64a8860de28a29b0b2564626058fa207e.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jun 2018, Andy Shevchenko wrote:

> On Fri, 2018-05-18 at 14:51 +0100, Lee Jones wrote:
> > On Tue, 24 Apr 2018, Andy Shevchenko wrote:
> > 
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
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/mfd/intel-lpss.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Applied and tagged for -stable # 4.3+
> 
> Thanks!
> 
> Though can not see it in Linus' tree still.

Why would it be in Linus' tree?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
