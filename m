Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeEEPRr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 11:17:47 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34593 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeEEPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 11:17:41 -0400
X-Google-Smtp-Source: AB8JxZoTSOfO3FNVBRrasPf/zQFDI5QWpPm1MXLKJynIGQQHb1oVn9E8+Ck9jTaUz2lAItB8hZitnOuAWD+dTWeyb9o=
MIME-Version: 1.0
In-Reply-To: <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com> <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 May 2018 12:17:39 -0300
Message-ID: <CAOMZO5A7bf1qcHrWjM1mr31Nkz+oDJ=fQo3rjksp1YY-HhPM9A@mail.gmail.com>
Subject: Re: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
 screen support
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Haibo Chen <haibo.chen@freescale.com>,
        Fugang Duan <fugang.duan@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 5, 2018 at 5:29 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

>  &iomuxc {
> +       pinctrl_egalax_int: egalax-intgrp {
> +               fsl,pins = <
> +                       MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22      0x80000000

Please avoid using 0x80000000 and use the real IOMUX value instead.
