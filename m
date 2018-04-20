Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeDTBHR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 21:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754127AbeDTBHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 21:07:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887EB217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AB8JxZoTOsE69l1jhy8VqnSnvN09CLLxuq00h9U7WjQC2WedlIsgyT1mRlRFOWyESgDOy5nHNuPLOD9oXWC+GuvkHkM=
MIME-Version: 1.0
In-Reply-To: <20180419143240.3717-1-lukma@denx.de>
References: <20180405070939.22245-1-lukma@denx.de> <20180419143240.3717-1-lukma@denx.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 19 Apr 2018 20:06:52 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+TCaWZOuS-wKTFtxFShZcSj=Zg12f1NonN3DL-4hHWSA@mail.gmail.com>
Message-ID: <CAL_Jsq+TCaWZOuS-wKTFtxFShZcSj=Zg12f1NonN3DL-4hHWSA@mail.gmail.com>
Subject: Re: [PATCH v6] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
To: Lukasz Majewski <lukma@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 9:32 AM, Lukasz Majewski <lukma@denx.de> wrote:
> This commit adds device tree description of Kieback & Peter GmbH
> iMX6Q TPC board.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>
> ---
> Changes for v6:
> - Add space between // and SPDX
> - Replace 'disp0' with 'display'
> - Replace 'rtc: ds1307@32' with 'ds1307: rtc@32'
> - Replace 'codec: audio-codec@a' with 'sgtl5000: audio-codec@a'
> - Move &can[12] nodes extension to proper position to be alphabetically sorted
>
> Changes for v5:
> - Use 'interpolation-steps' to fill the brightness level table
> - Remove not needed status = "okay" properties
> - Replace goodix_ts -> touchscreen
> - Replace sgtl5000 -> audio-codec
>
> This patch depends on PWM backlight intepolation work:
> https://patchwork.kernel.org/patch/10330775/
> https://patchwork.kernel.org/patch/10330777/
>
> Changes for v4:
> - Remove not needed bus-format-override = "rgb565";
>   property
>
> Changes for v3:
> - Provide proper compatible for RTC DTS node
> - Remove wrong comment style for beeper
> - Add proper SPDX entries for DTS files
> - Add vendor prefix to a separate patch
>
> Changes for v2:
> - SPDX license identifiers used
> - Separate regulators
> - Proper beeper driver
> - Use of the lcd panel (with compatible) instead of timings provided in
>   device tree
> - Add IRQ types (like IRQ_TYPE_EDGE_FALLING) and GPIO active levels (like
>   GPIO_ACTIVE_HIGH)
> - Remove not needed nodes
> - Make W=1 dtbs compilation with no errors
> ---
>  arch/arm/boot/dts/Makefile         |   1 +
>  arch/arm/boot/dts/imx6q-kp-tpc.dts |  22 ++
>  arch/arm/boot/dts/imx6q-kp.dtsi    | 432 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 455 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-kp-tpc.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-kp.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>
