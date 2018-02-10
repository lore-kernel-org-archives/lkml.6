Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbeBJQYM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 11:24:12 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:34949 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 11:24:11 -0500
X-Google-Smtp-Source: AH8x2255mSeCz778zVXmq9QlaajNAM97oaV17vDui+stXCqiWZRysYj5otu+hkeXfpEgHKQnEXeFrH16Ht+ZDHa7Puw=
MIME-Version: 1.0
In-Reply-To: <20180107134905.15624-1-stefan@agner.ch>
References: <20180107134905.15624-1-stefan@agner.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 10 Feb 2018 14:24:09 -0200
Message-ID: <CAOMZO5Bmokay7E6mf8j53HXppT74LOMu_nCd=TwBzha1XH0k-w@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpc: de-register power domains only if initialized
To: Stefan Agner <stefan@agner.ch>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 7, 2018 at 11:49 AM, Stefan Agner <stefan@agner.ch> wrote:
> If power domain information are missing in the device tree, no
> power domains get initialized. However, imx_gpc_remove tries to
> remove power domains always in the old DT binding case. Only
> remove power domains when imx_gpc_probe initialized them in
> first place.
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
