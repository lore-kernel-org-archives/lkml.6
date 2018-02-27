Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbeB0PcF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:32:05 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32943 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753609AbeB0PcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:32:03 -0500
X-Google-Smtp-Source: AG47ELsXMID4QNPsiHap9C0Qvy4zPOTnRvqKCjkUCw3YfsxbOpO2SAR4C5taPbmYga0BC/2+QeAjOFOPeG53xkf103Y=
MIME-Version: 1.0
In-Reply-To: <20180226144943.9835-1-andrew.smirnov@gmail.com>
References: <20180226144943.9835-1-andrew.smirnov@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Feb 2018 12:32:02 -0300
Message-ID: <CAOMZO5D-FrBK0wDQ7cp8G9h3iAES-AS5qXSF9SYGEUfjKzjisQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6: RDU2: Add RAVE SP device
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 11:49 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> With MFD and watchdog drivers for RAVE SP device support added by
> 538ee27290fa ("mfd: Add driver for RAVE Supervisory Processor") and
> c3bb33345721 ("watchdog: Add RAVE SP watchdog driver") add
> corresponding DT node for RDU2.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
