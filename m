Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030189AbeCAKK7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:10:59 -0500
Received: from mail1.bemta5.messagelabs.com ([195.245.231.137]:25891 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967363AbeCAKK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:10:56 -0500
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRWlGSWpSXmKPExsUSt3Opse7ai9O
  jDO5fU7K4vGsOm8WNdfvYLSauv8fqwOyxc9Zddo/Pm+QCmKJYM/OS8isSWDOW3l3IXtCvUfF8
  0X/mBsYz6l2MXBxCAksYJV6e28zWxcjJwSZgKDHvzXvGLkYODhEge/N9B5AaZoHdjBKPb95kA
  qkRFvCVOLF3L1i9iIC/xJF1C1ghbCOJeTdmgtksAioSFz6+ZAGxeQUCJI6uuwzWKyRgJ9F+4i
  4LyHxOAXuJ/QvtQMKMArISXxpXM4PYzALiEreezAcrlxAQkFiy5zwzhC0q8fLxP1YIW17i5qt
  jLBC2vcTre+/ARkoI6Ev0NRZDhA0lVk07AFViLnHsyAFmkBJmAU2J9bv0ITYpSkzpfsgOcaSg
  xMmZT1gmMIrPQnLELISOWUg6ZiHpWMDIsopRozi1qCy1SNfQWC+pKDM9oyQ3MTNH19DAVC83t
  bg4MT01JzGpWC85P3cTIzDmGIBgB+O/bZ6HGCU5mJREefuOTosS4kvKT6nMSCzOiC8qzUktPs
  Qow8GhJMF78ML0KCHBotT01Iq0zBxg9MOkJTh4lER414OkeYsLEnOLM9MhUqcYjTluvHjdxsy
  xZdmbNmYhlrz8vFQpcd4tIKUCIKUZpXlwg2BJ6RKjrJQwLyPQaUI8BalFuZklqPKvGMU5GJWE
  eY+CTOHJzCuB2/cK6BQmoFOOfJ4CckpJIkJKqoGxc1HeGvcJSimdwZqJO9dnaT6Q1fGRM5w29
  3zDhd0/j+p+ct4z0+xDzVoe6y22LZ+7H15hjWhpN5hwc4UXf/qm2udW4XV/9dwev1U5px25YU
  Pb0VtaVxZF2h/imiu62HXSbzP75TEH5t11ucuQW1WU0yKYe0whacEMl6BjC3LSrye76WgaFv1
  XYinOSDTUYi4qTgQAriuSLEUDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-9.tower-179.messagelabs.com!1519899053!90530262!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
CC: Support Opensource <Support.Opensource@diasemi.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] watchdog: add SPDX identifiers for watchdog subsystem
Thread-Topic: [PATCH v4] watchdog: add SPDX identifiers for watchdog
 subsystem
Thread-Index: AQHTsKU445KjgJrxV0+AzSmRlfmdTKO7J2OA
Date: Thu, 1 Mar 2018 10:10:51 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7019414ED80@SW-EX-MBX02.diasemi.com>
References: <20180228150209.2525-1-marcus.folkesson@gmail.com>
In-Reply-To: <20180228150209.2525-1-marcus.folkesson@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.26.49]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 01/03/2018 07:53:00
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21AB6IZ004542

On 28 February 2018 15:02, Marcus Folkesson wrote:

> Subject: [PATCH v4] watchdog: add SPDX identifiers for watchdog subsystem
> 
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate license

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Hi Marcus,

Acked for the files below.

Regards,
Steve

[...]

>  drivers/watchdog/da9052_wdt.c          |  6 +---
>  drivers/watchdog/da9055_wdt.c          |  6 +---
>  drivers/watchdog/da9062_wdt.c          | 10 +------
>  drivers/watchdog/da9063_wdt.c          |  5 +---

[...]

> diff --git a/drivers/watchdog/da9052_wdt.c
> b/drivers/watchdog/da9052_wdt.c
> index d6d5006efa71..e263bad99574 100644
> --- a/drivers/watchdog/da9052_wdt.c
> +++ b/drivers/watchdog/da9052_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * System monitoring driver for DA9052 PMICs.
>   *
> @@ -5,11 +6,6 @@
>   *
>   * Author: Anthony Olech <Anthony.Olech@diasemi.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>   */
> 
>  #include <linux/module.h>
> diff --git a/drivers/watchdog/da9055_wdt.c
> b/drivers/watchdog/da9055_wdt.c
> index 50bdd1022186..26a5b2984094 100644
> --- a/drivers/watchdog/da9055_wdt.c
> +++ b/drivers/watchdog/da9055_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * System monitoring driver for DA9055 PMICs.
>   *
> @@ -5,11 +6,6 @@
>   *
>   * Author: David Dajun Chen <dchen@diasemi.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>   */
> 
>  #include <linux/module.h>
> diff --git a/drivers/watchdog/da9062_wdt.c
> b/drivers/watchdog/da9062_wdt.c
> index 814dff6045a4..a001782bbfdb 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -1,16 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog device driver for DA9062 and DA9061 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
> 
>  #include <linux/kernel.h>
> diff --git a/drivers/watchdog/da9063_wdt.c
> b/drivers/watchdog/da9063_wdt.c
> index 2a20fc163ed0..b17ac1bb1f28 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog driver for DA9063 PMICs.
>   *
> @@ -5,10 +6,6 @@
>   *
>   * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
>   *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
>   */
> 
>  #include <linux/kernel.h>
