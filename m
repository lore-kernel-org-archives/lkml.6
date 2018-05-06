Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeEFPGT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 11:06:19 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:33294 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeEFPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 11:06:15 -0400
X-Google-Smtp-Source: AB8JxZqlC7IWYTz2i4pUhsJGeqS3p3dTz6lsHDjgR6jWBXKkdTHxtxqUyprz6mCI6LjdLnh4nZkZuKLMcv/4e4Not3s=
MIME-Version: 1.0
In-Reply-To: <1525588093-29994-3-git-send-email-Anson.Huang@nxp.com>
References: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com> <1525588093-29994-3-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 6 May 2018 12:06:14 -0300
Message-ID: <CAOMZO5CRwBCNLD3mxZ5E60=OzMHspTxpd_fqgKayk=rQ=ms5Vg@mail.gmail.com>
Subject: Re: [PATCH V7 3/7] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fugang Duan <fugang.duan@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
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

On Sun, May 6, 2018 at 3:28 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SX Sabre Auto board has two max7310 IO expander on I2C3 bus, add
> support for them.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
