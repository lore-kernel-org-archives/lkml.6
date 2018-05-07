Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeEGOC1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:02:27 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33909 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbeEGOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:02:22 -0400
X-Google-Smtp-Source: AB8JxZqnIm8QJuvlZu/LaRfr0fsJjTEdki+nLpSrlV265L+y1FCce7clFKJ1fFuFK4khIM/ZuNimDLOl3UlXuQWcMMY=
MIME-Version: 1.0
In-Reply-To: <20180507135309.32580-1-nikita.yoush@cogentembedded.com>
References: <20180507135309.32580-1-nikita.yoush@cogentembedded.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 May 2018 11:02:20 -0300
Message-ID: <CAOMZO5A5gXho1_jhGGC6CF02C=JX5vniKB_vxsTcMXC4Ayh4oQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: fix touchscreen bindings
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marco Franchi <marcofrk@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <Chris.Healy@zii.aero>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Mon, May 7, 2018 at 10:53 AM, Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> This fixes errors in RDU1 device tree that cause touch screens not
> working.

Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
Cc: stable@vger.kernel.org #4.15+

> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
