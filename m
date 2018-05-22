Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeEVLZi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:25:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36724 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeEVLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:25:35 -0400
X-Google-Smtp-Source: AB8JxZqgY4rWXyYUUuyvtTtP27kuvk7/J3qgezPYTvpMG9ZisIrY12uJoH4Oox4r+K48zyuuSpPDAxPVOdr6NiPFmCU=
MIME-Version: 1.0
In-Reply-To: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 May 2018 08:25:34 -0300
Message-ID: <CAOMZO5B=-c4erNEBqftyr-aaa17Vhy_bnOTHuvPFSKVP8D6j6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
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

On Tue, May 22, 2018 at 12:25 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6UL has GPIO clock gates in CCM CCGR, add
> them into clock tree for clock management.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
