Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeFDFdc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 01:33:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33064 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeFDFdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:33:31 -0400
X-Google-Smtp-Source: ADUXVKLyhXtw5yQGI8zc503QlMBE4mIACwq0tsl9w3dl5OgroT/5DT+d8H7ULTYYYJfHmMsYzDFFwA==
Date: Mon, 4 Jun 2018 06:33:28 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Correct names of RESETS register bits
Message-ID: <20180604053327.GB17993@dell>
References: <20180424150512.60824-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180424150512.60824-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Andy Shevchenko wrote:

> According to documentation the function has 2 bits for reset
> while iDMA 64-bit has only one.
> 
> Rename it accordingly. Note, there is no functional change since
> we always handle them together.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
