Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeDYVqT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:46:19 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:36132 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeDYVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:46:15 -0400
X-Google-Smtp-Source: AB8JxZp7ebERkonA3D3Jd5EZiUfKwgww5LMJ+Sx3ioZ1X6gJY2DVx3zyr63i/tTn5Hdnyp+43cJIoYCdCgj9OmFz8A4=
MIME-Version: 1.0
In-Reply-To: <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com> <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Apr 2018 18:46:13 -0300
Message-ID: <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
Subject: Re: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 2:36 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> +&i2c3 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3_2>;
> +       status = "okay";
> +
> +       max7310_a: gpio@30 {
> +               compatible = "maxim,max7310";
> +               reg = <0x30>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       max7310_b: gpio@32 {
> +               compatible = "maxim,max7310";
> +               reg = <0x32>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };

Please also add the users for the MAX7310 pins, such as Ethernet PHY.
