Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDEOQr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:16:47 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:43860 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDEOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:16:45 -0400
X-Google-Smtp-Source: AIpwx4/uUe9yeY9hGALzslzE8CwcRGj6la6Bjdq6LGAtY+mnPnlIR5VXCGH4fds93+mGof8pjU20JUFgesYGixnGtfY=
MIME-Version: 1.0
In-Reply-To: <20180405070939.22245-1-lukma@denx.de>
References: <20180405070939.22245-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 5 Apr 2018 11:16:44 -0300
Message-ID: <CAOMZO5DHtvX64oseDFsLGiYmQPcb3thUrGeLxX8dgp69vUNZMg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Thu, Apr 5, 2018 at 4:09 AM, Lukasz Majewski <lukma@denx.de> wrote:

> +       reg_audio: regulator-audio {
> +               compatible = "regulator-fixed";
> +               regulator-name = "sgtl5000-supply";
> +               gpio = <&gpio6 31 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;
> +       };

sgtl5000 has 3 supplies: VDDD, VDDIO, VDDA.

Which supply does this reg_audio supply to the chip?

Can't you use any of the existing sgtl5000 regulator bindings to
describe this supply?
