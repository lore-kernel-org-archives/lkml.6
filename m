Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeCQS1a (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:27:30 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:43248 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeCQS1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:27:24 -0400
X-Google-Smtp-Source: AG47ELslMNeFMJDsmNMx5Ka/PYbeFddDU0+LlkLoAlJe1VAh/t9NvqCGzAhWtHlbG46VOQmE8Yx1JO04Oc8YXsWilkk=
MIME-Version: 1.0
In-Reply-To: <1937778373.476574.1521290144753@email.1und1.de>
References: <1521269828-8874-1-git-send-email-Anson.Huang@nxp.com>
 <1521269828-8874-2-git-send-email-Anson.Huang@nxp.com> <1937778373.476574.1521290144753@email.1und1.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 Mar 2018 15:27:23 -0300
Message-ID: <CAOMZO5CUD373oZsnE69kEwj0oXLSQTMeb5k2YK6H5gPY7QyZPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: pfuze100: update voltage setting for
 pfuze3000 sw1a
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>, Robin Gong <yibin.gong@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Anson Huang <Anson.Huang@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2HIRYnR008680

Hi Stefan,

On Sat, Mar 17, 2018 at 9:35 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Anson,
>
>> Anson Huang <Anson.Huang@nxp.com> hat am 17. März 2018 um 07:57 geschrieben:
>>
>>
>> Latest pfuze3000 datasheet from:
>>
>> http://cache.freescale.com/files/analog/doc/data_sheet/PF3000.pdf?fsrch=1&sr=1&pageNum=1
>
> this link goes to Rev. 7.0, 9/2016, which isn't the latest one.
>
> I guess Rev. 9.0, 8/2017 is the latest.

You are right. This is the link to the latest datasheet:
https://www.nxp.com/docs/en/data-sheet/PF3000.pdf
