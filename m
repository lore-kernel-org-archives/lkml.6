Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeERNv4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:51:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33553 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeERNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:51:52 -0400
X-Google-Smtp-Source: AB8JxZo5Bl1Vu2yaYN+7SLMVwiW6Mh4ihohyHu3AEAFjW5KBD6ypH3Xiv3AUoFQB4qRR3EiWGRFoaw==
Date: Fri, 18 May 2018 14:51:48 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Program REMAP register in PIO mode
Message-ID: <20180518135148.GP5130@dell>
References: <20180424150010.60760-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180424150010.60760-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Andy Shevchenko wrote:

> According to documentation REMAP register has to be programmed in
> either DMA or PIO mode of the slice.
> 
> Move the DMA capability check below to let REMAP register be programmed
> in PIO mode.
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied and tagged for -stable # 4.3+

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
