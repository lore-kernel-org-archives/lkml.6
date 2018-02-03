Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeBCADQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:03:16 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36812 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeBCADI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:03:08 -0500
X-Google-Smtp-Source: AH8x227uV4jc6kRAKrRLqIiXL4tRhhiWX5Taf9gvJgPOOBx9NqgYiBoirMyIUiMZVKAmyw2XLUOYos/ep5XKgewEZ0c=
MIME-Version: 1.0
In-Reply-To: <1516800134-5018-3-git-send-email-marcofrk@gmail.com>
References: <1516800134-5018-1-git-send-email-marcofrk@gmail.com> <1516800134-5018-3-git-send-email-marcofrk@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Feb 2018 22:03:07 -0200
Message-ID: <CAOMZO5AfEon8mGLZyYQav_TjZ5h7KMVvE8ks4Ruw4xyj48wofA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx: Add memory node unit name
To: Marco Franchi <marcofrk@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Marco Franchi <marco.franchi@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2018 at 11:22 AM, Marco Franchi <marcofrk@gmail.com> wrote:
> Fix the following warnings from dtc by adding the unit name to memory
> nodes:
>
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>
> Converted using the following command:
>
> perl -p0777i -e 's/memory \{\n\t\treg = \<0x+([0-9a-f])/memory\@$1$\0000000 \{\n\t\treg = <0x$1/m' `find ./arch/arm/boot/dts -name "imx*"`
>
> The files below were manually fixed:
> -imx1-ads.dts
> -imx1-apf9328.dts
> -imx6q-pistachio.dts
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
