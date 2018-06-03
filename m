Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeFCCGn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 22:06:43 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41621 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeFCCGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 22:06:41 -0400
X-Google-Smtp-Source: ADUXVKKXMfSv+pQsrKBCImiuxtw3MtuW/d3D2OzfxusCWkFkJNcEPu2qeCPYgoyVHz1gcPRMmvUgFLPWibBKSeBQNFk=
MIME-Version: 1.0
In-Reply-To: <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com> <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 2 Jun 2018 23:06:38 -0300
Message-ID: <CAOMZO5BMNhVu6UGmMDzQzEc=r1VkxNshksuuh0YVKcjs1wt41w@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 10:44 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6UL has GPIO clock gates in CCM CCGR, add
> clock property for GPIO driver to make sure all
> GPIO banks work as expected.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
