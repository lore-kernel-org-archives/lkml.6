Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeCGQHi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:07:38 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35077 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933479AbeCGQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:07:37 -0500
X-Google-Smtp-Source: AG47ELu6lck0RWjpWYrwCikU7MA2uEQPwmYYG1jHHeC+eod9SOLZvV7rz2mLkRQPl9D+luLoOKAltA==
Date: Wed, 7 Mar 2018 16:07:33 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Wenkai Du <wenkai.du@intel.com>
Cc: Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        Archana Patni <archana.patni@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] Revert "mfd: cros_ec: Add ACPI GPE handler for LID0
 devices"
Message-ID: <20180307160733.6p2oaon4ducz3f6r@dell>
References: <20180222213052.126692-1-wenkai.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180222213052.126692-1-wenkai.du@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2018, Wenkai Du wrote:

> This reverts commit e04653a9dcf4d98defe2149c885382e5cc72082f.
> 
> It is no longer needed to install Chrome EC GPE handler to have
> GPE enabled in suspend to idle path. It is found that with this
> handler installed, EC wake up doesn't work because default EC
> event handler that can wake up system is not getting called.
> 
> Signed-off-by: Wenkai Du <wenkai.du@intel.com>
> ---
>  drivers/mfd/Makefile           |   1 -
>  drivers/mfd/cros_ec.c          |  15 ++----
>  drivers/mfd/cros_ec_acpi_gpe.c | 103 -----------------------------------------
>  include/linux/mfd/cros_ec.h    |  18 -------
>  4 files changed, 3 insertions(+), 134 deletions(-)
>  delete mode 100644 drivers/mfd/cros_ec_acpi_gpe.c

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
