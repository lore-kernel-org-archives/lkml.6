Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeFBOHn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 10:07:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45346 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFBOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:07:41 -0400
X-Google-Smtp-Source: ADUXVKJk/J9MCWaWzRvKLvj6eRuboeSctUB29lOoydV4cOdMR2AQ6D43FF9cmy9LWcMB4DdiyEP5eofJRLNQbELCYQo=
MIME-Version: 1.0
In-Reply-To: <CAOf5uwneWyjNpD-tGGL7CgL2_jJFvDtzbi+NBg7wqGMGR4qGCw@mail.gmail.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
 <1439344955.9677.1526991935718@email.1und1.de> <CAOMZO5BVhjwGpJ22qBihKcjWyvBkzNPU0cNtNY9HToLLEkYByA@mail.gmail.com>
 <CAOf5uwneWyjNpD-tGGL7CgL2_jJFvDtzbi+NBg7wqGMGR4qGCw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 2 Jun 2018 11:07:40 -0300
Message-ID: <CAOMZO5DfpwEDrBrMaTCt1_2Kkkm_tuVLE2WMy5z2=iO_rRFVEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>, Anson Huang <Anson.Huang@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sat, Jun 2, 2018 at 11:04 AM, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> ull is a preatty new platform so one board was listed. Are you sure
> that we need?

There are several imx6ul based dts in mainline and it is better if we
can avoid dtb breakage when possible.

In this case we can avoid the dtb breakage by adding the new clock
definitions at the end of the file, just like we do for all the other
imx devices.
