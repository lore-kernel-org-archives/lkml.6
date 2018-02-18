Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeBRRb6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:31:58 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40138 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbeBRRb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:31:56 -0500
X-Google-Smtp-Source: AH8x227+R066EMMqmAXPeJqt+TwFLlUy0lmgDl6hLVn4xBSg3Yt3scHmo703iYtjUYJEwYEJj+zjCAmmJbi6Gj4m6dg=
MIME-Version: 1.0
In-Reply-To: <20180216194415.6103-1-david.daney@cavium.com>
References: <20180216194415.6103-1-david.daney@cavium.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sun, 18 Feb 2018 18:31:14 +0100
Message-ID: <CAOFm3uGGRopoD-wsX51Duh5vnS5SmK7Qd_uGF=8c6_fYmWPJXw@mail.gmail.com>
Subject: Re: [PATCH v4] rtc: isl12026: Add driver.
To: David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Feb 16, 2018 at 8:44 PM, David Daney <david.daney@cavium.com> wrote:
> The ISL12026 is a combination RTC and EEPROM device with I2C
> interface.  The standard RTC driver interface is provided.  The EEPROM
> is accessed via the NVMEM interface via the "eeprom0" directory in the
> sysfs entry for the device.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: David Daney <david.daney@cavium.com>

<snip>

> --- /dev/null
> +++ b/drivers/rtc/rtc-isl12026.c
> @@ -0,0 +1,529 @@
> +// SPDX-License-Identifier: GPL-2.0

<snip>

> +MODULE_LICENSE("GPL");

Your MODULE_LICENSE does not match your SPDX tag.
Per module.h, GPL would mean GPL-2.0+ not GPL-2.0
It would be best if you can sync the two.

-- 
Cordially
Philippe Ombredanne
