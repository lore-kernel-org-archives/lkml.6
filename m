Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDZGV0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:21:26 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:39701 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeDZGVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:21:22 -0400
X-Google-Smtp-Source: AIpwx49I+ayX4m4I5E1Vz4DyVLcud6FQl0gZlaHwbtODe05ih3WsABvgx+xdYpy1rOxgk4SXV6zVDXslWBNy5ZWrumA=
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com> <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
 <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Apr 2018 03:21:21 -0300
Message-ID: <CAOMZO5AZLbUoL7FWgUFA7qc3q3wcz9UBLSQhMXXkUJeiRz8X4A@mail.gmail.com>
Subject: Re: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
To: Anson Huang <anson.huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:06 AM, Anson Huang <anson.huang@nxp.com> wrote:

> MAX7310 pins are for PCIe, CAN, MLB. GPS etc., these modules are NOT enabled yet, so
> I can NOT test it, I think we should add MAX7310 users when these modules are enabled,
> ethernet PHY is NOT controlled by it.

You said previously that MAX7310 also controls the Ethernet PHY. Is
the vendor dts wrong then?

If there are no MAX7310 users, why are you adding support for MAX7310 then?

Confused.
