Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCNLi7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:38:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54849 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeCNLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:38:57 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] ACPI / PMIC: Update to SPDX license identifier
Date: Wed, 14 Mar 2018 12:39:31 +0100
Message-ID: <29263549.3mTuWCYWkj@aspire.rjw.lan>
In-Reply-To: <1519170849-28802-4-git-send-email-rajmohan.mani@intel.com>
References: <1519170849-28802-1-git-send-email-rajmohan.mani@intel.com> <1519170849-28802-4-git-send-email-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 21, 2018 12:54:09 AM CET Rajmohan Mani wrote:
> Remove the GPL v2 license boilerplate and update with
> the SPDX license identifier.
> 
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> ---
>  drivers/acpi/pmic/tps68470_pmic.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/pmic/tps68470_pmic.c b/drivers/acpi/pmic/tps68470_pmic.c
> index 7f3c567..a083de5 100644
> --- a/drivers/acpi/pmic/tps68470_pmic.c
> +++ b/drivers/acpi/pmic/tps68470_pmic.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * TI TPS68470 PMIC operation region driver
>   *
> @@ -5,15 +6,6 @@
>   *
>   * Author: Rajmohan Mani <rajmohan.mani@intel.com>
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License version
> - * 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   * Based on drivers/acpi/pmic/intel_pmic* drivers
>   */
>  
> 

Applied, thanks!
