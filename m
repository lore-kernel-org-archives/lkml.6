Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBEEX0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 23:23:26 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43876 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbeBEEXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 23:23:17 -0500
X-Google-Smtp-Source: AH8x227JMtEO/YiVAKIUgLGUbf8VpOYSrypZi4bhwLiswnkAcymXC7uphvbWXg7k1t7Poj60Pb5hQR8YWPudRqmEXRw=
MIME-Version: 1.0
In-Reply-To: <20180204192246.GC24569@lunn.ch>
References: <20180204184514.2396-1-yungching0725@gmail.com> <20180204192246.GC24569@lunn.ch>
From: Yung-Ching LIN <yungching0725@gmail.com>
Date: Sun, 4 Feb 2018 20:23:16 -0800
Message-ID: <CACGtqyyriQ7hdUWO8HLn=KC1+vkD=kPAMVZEixqByjdw0Dxf5g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Add support for Advantech DMS-BA16
To: Andrew Lunn <andrew@lunn.ch>
Cc: shawnguo@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Will provide the v2 for all the fixes.
Thank you for the comments.

On Sun, Feb 4, 2018 at 11:22 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, Feb 05, 2018 at 02:45:14AM +0800, Ken Lin wrote:
>> Add support for Advantech DMS-BA16 board, which use
>> the Advantech BA-16 module.
>>
>> Signed-off-by: Ken Lin <yungching0725@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile           |   1 +
>>  arch/arm/boot/dts/imx6q-dms-ba16.dts | 154 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 155 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/imx6q-dms-ba16.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index ade7a38543dc..d97511273f30 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -428,6 +428,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>>       imx6q-b450v3.dtb \
>>       imx6q-b650v3.dtb \
>>       imx6q-b850v3.dtb \
>> +     imx6q-dms-ba16.dtb \
>>       imx6q-cm-fx6.dtb \
>>       imx6q-cubox-i.dtb \
>>       imx6q-cubox-i-emmc-som-v15.dtb \
>
> Hi Ken
>
> I think the intention is to keep this list sorted. So dms puts it
> later, after cubox.
>

Thanks. will fix the order issue in the v2.

>> @@ -0,0 +1,154 @@
>> +/*
>> + * Copyright 2018 Advantech Corporation
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "imx6q-ba16.dtsi"
>> +
>> +/ {
>> +     model = "Advantech DMS-BA16";
>> +     compatible = "fsl,imx6q-dms-ba16", "fsl,imx6q";
>
> This looks wrong. I would expect "advantech,imx6q-dms-ba16".
>
>      Andrew

Thanks. will fix the board comptability issue in the v2.
