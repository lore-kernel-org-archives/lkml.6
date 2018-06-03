Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeFCCGQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 22:06:16 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46073 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFCCGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 22:06:14 -0400
X-Google-Smtp-Source: ADUXVKLWU+ERvThq6VufCngEpLP5UERM9x68+u8U74HskElLoc9ljr3FUr+K18HH4Z4kBhNFhKLEYxQce6TnsnbJo/k=
MIME-Version: 1.0
In-Reply-To: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 2 Jun 2018 23:06:13 -0300
Message-ID: <CAOMZO5D1f3=+u-51K5U0CVZdmrtZomRkHO1KR1k9N6K+ws0WLA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] clk: imx6ul: add GPIO clock gates
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 10:44 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6UL has GPIO clock gates in CCM CCGR,
> add them into clock tree for clock management.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
