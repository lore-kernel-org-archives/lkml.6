Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbeCRMys (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:54:48 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:41040 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeCRMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:54:43 -0400
X-Google-Smtp-Source: AG47ELvnr9BpHDq+zcAFt5v3jIGJjXAkEZR+M+qcI2+49jNWrwd8aag4tDTfD9bLTn44zBZAZsJg48fbxg7DaERx6VI=
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB1315E1C3071C0BD2E7169968F5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BzE46Dm24++j+xVA4KGFnpsopGfJ97h7sFGOAxVa19=g@mail.gmail.com> <AM3PR04MB1315E1C3071C0BD2E7169968F5D50@AM3PR04MB1315.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 18 Mar 2018 09:54:42 -0300
Message-ID: <CAOMZO5AFJk_Q5CYrV0s+hLmORHosWujRSGjwf9smyAQc4nmJ+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
To: Anson Huang <anson.huang@nxp.com>
Cc: Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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

On Sat, Mar 17, 2018 at 11:23 PM, Anson Huang <anson.huang@nxp.com> wrote:

> I thought the max value here means the capability of regulator itself, like the internal

No it is not.

Please check Documentation/devicetree/bindings/regulator/regulator.txt:

"- regulator-max-microvolt: largest voltage consumers may set"
