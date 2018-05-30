Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeE3SKf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:10:35 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41208 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753740AbeE3SKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:10:31 -0400
X-Google-Smtp-Source: ADUXVKISkVmocxYovWkjyTjR7TVeA5g+T4pRdO2zoRaen7mrbCue95WiUH+613aSo19LCMmeZIEo5vOUjMpD1NM+Pos=
MIME-Version: 1.0
In-Reply-To: <20180530173414.6121-1-andrew.smirnov@gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 30 May 2018 15:10:30 -0300
Message-ID: <CAOMZO5BbgG2POYvayjT99BAAkC5HzrUWr28Z7DggVwTFSCnpFQ@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>, USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 2:34 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Workaround introduced for i.MX53 in be9cae2479f48 ("usb: chipidea:
> imx: Fix ULPI on imx53") seems to be applicable in case of i.MX51 as
> well. Running latest kernel on ZII RDU1 Board (imx51-zii-rdu1.dts)
> exhibits a kernel frozen on PORTSC access and applying the workaround
> resolves the issue.
>
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
