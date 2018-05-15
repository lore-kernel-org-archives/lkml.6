Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeEOLoz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:44:55 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39924 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeEOLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:44:54 -0400
X-Google-Smtp-Source: AB8JxZqOOKNMjW25BLQHfLnZGqCXb8TaH6uHI9GZ1G80bD/sFzAO6zYLsdzWScDeBw8I+//33XWcht4HkS+9Bo7VS28=
MIME-Version: 1.0
In-Reply-To: <1526375609-17676-1-git-send-email-Anson.Huang@nxp.com>
References: <1526375609-17676-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 15 May 2018 08:44:53 -0300
Message-ID: <CAOMZO5Ci6Kmb9hK7=pvYXURWLfRun1gu+XOskXAe0xo=v1NTpA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d: correct cpu supply name for voltage scaling
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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

On Tue, May 15, 2018 at 6:13 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> index 7f64568..60deaf9 100644
> --- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> +++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
> @@ -33,7 +33,7 @@
>  };
>
>  &cpu0 {
> -       arm-supply = <&sw1a_reg>;
> +       cpu-supply = <&sw1a_reg>;
>  };
>
>  &fec1 {
> @@ -284,4 +284,4 @@
>                         MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5     0x14 /* OTG PWREN */
>                 >;
>         };
> -};
> \ No newline at end of file
> +};

This change seems unrelated.

Other than that:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
