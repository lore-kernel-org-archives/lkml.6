Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757610AbeDXMW4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:22:56 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:43583 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756093AbeDXMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:22:53 -0400
X-Google-Smtp-Source: AB8JxZoGZx/70PJabTzze38cRwsGNKFHCAb15REKgEPCMjo9EGv7D57TtX19EHKcFUEyCQ8Ss9Q4vTM6aYNWoeL4I2Y=
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com> <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 24 Apr 2018 09:22:52 -0300
Message-ID: <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
To: Anson Huang <anson.huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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

Hi Anson,

On Mon, Apr 23, 2018 at 11:09 PM, Anson Huang <anson.huang@nxp.com> wrote:

> Ah, yes, thanks for pointing out this issue, I just removed it and the function is still working,
> already sent out V2 patch set, thanks.

So now maybe it is working only because the bootloader activated this
GPIO, which is not good.

I don't have access to the mx6sx sabreauto schematics to verify  where
&max7322 0 connects to, but it would be better to make sure that you
activate this pin in dts if it is needed for Ethernet, without relying
on the bootloader.
