Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeAaWWU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:22:20 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:36625 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbeAaWWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:22:18 -0500
X-Google-Smtp-Source: AH8x22438W/zlqxFMOGtuLjyc0CqLfIwD/MiDU87rMIBx2s8dpAQ4tGtnriSjdYOq0PxrftNEuRgwIHHiV4ZQnfPVbc=
MIME-Version: 1.0
In-Reply-To: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
References: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 31 Jan 2018 20:22:16 -0200
Message-ID: <CAOMZO5C_cV+w_xQg4F2=RqeMEOW8hANB_Td-memf08mPLvtr8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ARM: dts: imx25-pinfunc: Use consistent naming for eSDHC
To: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VMMTuE005145

On Wed, Jan 31, 2018 at 7:35 PM, Benoît Thébaudeau
<benoit.thebaudeau.dev@gmail.com> wrote:
> This file had several naming inconsistencies for eSDHC:
>  - the instances were named sometimes SDn, sometimes SDHCn, whereas they
>    are named ESDHCn in the reference manual, e.g.:
>      MX25_PAD_SD1_CMD__SD1_CMD
>      MX25_PAD_D15__SDHC1_DAT7
>  - the data ports were named sometimes DATAn, sometimes DATn like in the
>    reference manual, e.g.:
>      MX25_PAD_SD1_DATA0__SD1_DATA0
>      MX25_PAD_D15__SDHC1_DAT7
>  - in one case, the clock port was named DAT_CLK instead of CLK:
>      MX25_PAD_CSI_D7__SDHC2_DAT_CLK
>
> This change:
>  - introduces new definitions using the naming from the reference
>    manual,
>  - keeps definitions using the legacy naming in order not to break
>    compatibility for out-of-tree users (they can be removed later),
>  - updates the in-tree files that were using the legacy naming.
>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Benoît Thébaudeau <benoit.thebaudeau.dev@gmail.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
