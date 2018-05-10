Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934040AbeEJBpm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:45:42 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41483 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932857AbeEJBpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:45:40 -0400
X-Google-Smtp-Source: AB8JxZq4+mMUV1V1x6ofN2Nv4eUtZFq/VxD2nPN8yhDil7rgzpN5cOKnx2e7lBWLILFrZfl29iEBHWhEnJRYQZE+KGs=
MIME-Version: 1.0
In-Reply-To: <20180509153428.1440-1-lukma@denx.de>
References: <20180509153428.1440-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 9 May 2018 22:45:39 -0300
Message-ID: <CAOMZO5BGfoLZDesBN=hQ5cr7Rkm1p6xyggwTvWNq6QKJZVyzeA@mail.gmail.com>
Subject: Re: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 12:34 PM, Lukasz Majewski <lukma@denx.de> wrote:

> +               button@1 {
> +                       label = "Kaltstart";
> +                       linux,code = <64>; /* KEY_F6 */

If you include <dt-bindings/input/input.h> then you can simply do:

 linux,code = <KEY_F6 >;

> +                       gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
> +               };
> +               button@2 {
> +                       label = "PowerFailInterrupt";
> +                       linux,code = <65>; /* KEY_F7 */

Same here.
