Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeBWJ2P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:28:15 -0500
Received: from mx.socionext.com ([202.248.49.38]:45210 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeBWJ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:28:14 -0500
From: "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To: "'Marcus Folkesson'" <marcus.folkesson@gmail.com>
Cc: "'Wim Van Sebroeck'" <wim@linux-watchdog.org>,
        "'Guenter Roeck'" <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Masahiro Yamada'" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3] watchdog: add SPDX identifiers for watchdog subsystem
Date: Fri, 23 Feb 2018 18:28:09 +0900
Message-ID: <001601d3ac88$9e64eb20$db2ec160$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdOsg5fkopjUlKsJRRWrppzgYS2m9A==
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcus,

I'm sorry that it became a different thread.
I'll be careful hereafter.

This mail is reply to here.
  https://patchwork.kernel.org/patch/10232065/


> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index 0ea2339d9702..769d75344050 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -1,18 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Watchdog driver for the UniPhier watchdog timer
>   *
>   * (c) Copyright 2014 Panasonic Corporation
>   * (c) Copyright 2016 Socionext Inc.
>   * All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
> 
>  #include <linux/bitops.h>

Acked-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>

Thank you.

----
Best Regards,
Keiji Hayashibara
