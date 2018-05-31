Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeEaBGO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:06:14 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36738 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeEaBGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:06:12 -0400
X-Google-Smtp-Source: ADUXVKKZaMoTSwMT7uEYOLetg/3S/qf/vlGKihMolX+V9Cil+8Ynw+Q07w/cKh5gxuVwTS16Q9XgM1JxnCT4D5RpXdM=
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB1315345C3578D0644B82E8E9F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
 <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com> <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
 <AM3PR04MB13157285F0D882AD1C189617F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BJzSHx4zmkMWZVR-Z-y6p-=bMG+WQ2LASOroEdXHdyLA@mail.gmail.com> <AM3PR04MB1315345C3578D0644B82E8E9F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 May 2018 22:06:11 -0300
Message-ID: <CAOMZO5DB4YrU=JiKe0HAqQsr82iU=Fac3or++bwddrBVAZ+Cfw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle driver
To: Anson Huang <anson.huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 9:59 PM, Anson Huang <anson.huang@nxp.com> wrote:

> It is in arch/arm/mach-imx/mxc.h included by hardware.h, it is added by commit
> (dee5dee ARM: imx: Add basic msl support for imx6sll), so I removed it since we
> no longer need it.

Ah, OK: "mxc.h" is included by "hardware.h". Got it!
