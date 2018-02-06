Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeBFRIX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:08:23 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36371 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeBFRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:08:02 -0500
X-Google-Smtp-Source: AH8x227X1mxwi/3kFRjNt6eGMDmx0o0FtF1ub7bgJWi5AqFGW0VpfFOtVaPClEEnPjLzUdYrWbas35wJsJ7s7DNErXM=
MIME-Version: 1.0
In-Reply-To: <20180206142629.534-3-sebastian.reichel@collabora.co.uk>
References: <20180206142629.534-1-sebastian.reichel@collabora.co.uk> <20180206142629.534-3-sebastian.reichel@collabora.co.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 6 Feb 2018 15:08:01 -0200
Message-ID: <CAOMZO5DYiFg0T9Byd5cbJKXbFHmO7d1-T0KnMVKhn03nqRm0Ag@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] ARM: imx53: add SoC specific PMU setup
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 12:26 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> From: Peter Senna Tschudin <peter.senna@collabora.com>

Looking at http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/277931.html
this patch seems to be originally from Martin Fuzzey.

In this case I would expect to see his name in the From field.

Please check the same on the other patches.

> On i.MX53 it is necessary to set the DBG_EN bit in the
> platform GPC register to enable access to PMU counters
> other than the cycle counter.
>
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
