Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933595AbeEHSTG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932870AbeEHSTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:19:04 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Jacky Bai <ping.bai@nxp.com>, Stefan Agner <stefan@agner.ch>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <4188ee25bd5179b57d09e4624dcfbfbb@agner.ch>
Cc: Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, mturquette@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180418124908.3079-1-stefan@agner.ch> <20180502073807.GE3443@dragon>
 <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
 <HE1PR04MB311395765D3DC03D5960DBA3879A0@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <4188ee25bd5179b57d09e4624dcfbfbb@agner.ch>
Message-ID: <152580354289.138124.13657232356773397650@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
Date: Tue, 08 May 2018 11:19:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48IJCsX002430

Quoting Stefan Agner (2018-05-08 06:20:03)
> On 08.05.2018 09:32, Jacky Bai wrote:
> > 
> > I have tried two 6ULL board, I don't meet such issue. System can boot
> > up successfully with commit 6f9575e55632 included.
> > Anyway, the change in this patch is ok for me. it is no harm to the
> > BUS clock change flow.
> 
> Hm, that is interesting, maybe it is because we use a different SKU? Or
> maybe bootloader?
> 
> I tested here with a 800 MHz clocked variant on a Colibri iMX6ULL using
> U-Boot 2016.11.
> 

I'll throw this into fixes today because it fixes something to be
useful. It's still interesting to see what's different between the two
setups though.
