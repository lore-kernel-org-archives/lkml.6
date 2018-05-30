Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeE3Muq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:50:46 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42879 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeE3Mun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:50:43 -0400
X-Google-Smtp-Source: ADUXVKJzqoXvL+nw34x5kQ1V5DvAjMmVaJ4uiYtjoiRNI0FvSOi5HYdox28fUzBml4kCdHOU73PZMLyy1KoOV3ttA9A=
MIME-Version: 1.0
In-Reply-To: <1527643842-17643-1-git-send-email-Anson.Huang@nxp.com>
References: <1527643842-17643-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 May 2018 09:50:42 -0300
Message-ID: <CAOMZO5CBgrtKpGdknpwOFbdOR219JqfVJnOeEjdL1a1GiBdg=g@mail.gmail.com>
Subject: Re: [PATCH V2] soc: imx: gpcv2: correct PGC offset
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Tue, May 29, 2018 at 10:30 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Correct MIPI/PCIe/USB_HSIC's PGC offset based on
> design RTL, the values in the Reference Manual
> (Rev. 1, 01/2018 and the older ones) are incorrect.
>
> The correct offset values should be as below:
>
> 0x800 ~ 0x83F: PGC for core0 of A7 platform;
> 0x840 ~ 0x87F: PGC for core1 of A7 platform;
> 0x880 ~ 0x8BF: PGC for SCU of A7 platform;
> 0xA00 ~ 0xA3F: PGC for fastmix/megamix;
> 0xC00 ~ 0xC3F: PGC for MIPI PHY;
> 0xC40 ~ 0xC7F: PGC for PCIe_PHY;
> 0xC80 ~ 0xCBF: PGC for USB OTG1 PHY;
> 0xCC0 ~ 0xCFF: PGC for USB OTG2 PHY;
> 0xD00 ~ 0xD3F: PGC for USB HSIC PHY;
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks for the fix:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
