Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935830AbeBLOQY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:16:24 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41619 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933892AbeBLOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:16:21 -0500
X-Google-Smtp-Source: AH8x226OAMm03YMlPrxRw/9TrEhuAZfxXqgoS9ium9p07kE4rAPKewvFOZiHN4ZOPcd30cDa1IzdfOCrcvsa+f8E5Ms=
MIME-Version: 1.0
In-Reply-To: <20180212120600.5cghrzz4jqvvkgz6@dell>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-3-git-send-email-amelie.delaunay@st.com> <20180212120600.5cghrzz4jqvvkgz6@dell>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 12 Feb 2018 15:15:39 +0100
Message-ID: <CAOFm3uH+DLcOqiSV0z0N6JnmSk+JfTF3bfkC0_2kdFT-eDMr8A@mail.gmail.com>
Subject: Re: [PATCH 2/6] mfd: Add ST Multi-Function eXpander core driver
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amelie,

On Mon, Feb 12, 2018 at 1:06 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 08 Feb 2018, Amelie Delaunay wrote:
>
>> ST Multi-Function eXpander (MFX) is a slave controller using I2C
>> for communication with the main MCU. Main features are:
>> - 16 fast GPIOs individually configurable in input/output
>> - 8 alternate GPIOs individually configurable in input/output
>> - Main MCU IDD measurement
>> - Resistive touchscreen controller
>>
>> Only GPIO expander (16 fast GPIOs + 8 alternate) feature is
>> supported for the moment.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

<snip>

>> --- /dev/null
>> +++ b/drivers/mfd/st-mfx.c
>> @@ -0,0 +1,526 @@
>> +/*
>> + * STMicroelectronics Multi-Function eXpander (ST-MFX) Core Driver
>> + *
>> + * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
>> + * Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
>
> You don't need to put "for STMicroelectronics".  This was something we
> made up when submitting from a different (!st.com) email address.
>
>> + * License terms: GPL V2.0.
>> + *
>> + * st-mfx Core Driver is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + * st-mfx Core Driver is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
>> + * details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * st-mfx Core Driver. If not, see <http://www.gnu.org/licenses/>.
>
> You should be able to use the short version of the licensing
> agreement.  Also, please grep for "SPDX".

You can check the doc for the (fairly new) way to remove legalese
boilerplate at Documentation/process/license-rules.rst or [1]
It helps keep the focus on the code and less on licensing!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
