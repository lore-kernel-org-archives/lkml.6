Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeCZWXX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:23:23 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34575 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbeCZWXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:23:21 -0400
X-Google-Smtp-Source: AG47ELscePwrmh4hIL53u7oiNz53OwpY+rgNmBUUMBCBgqscyeeVrXq5+Pddp07BsJ/O41s9t4KiWw==
Date: Mon, 26 Mar 2018 17:23:20 -0500
From: Rob Herring <robh@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com,
        sboyd@kernel.org, shengjiu.wang@nxp.com, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock
 tree
Message-ID: <20180326222320.kcbudvanuyvo42fa@rob-hp-laptop>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:30:44AM +0800, Anson Huang wrote:
> i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
> And this lvds2, along with lvds1, can be used to provide
> external clock source to the internal pll, such as pll4_audio
> and pll5_video.
> 
> This patch mainly adds the lvds2 to the clock tree and fix its
> relationship with pll accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6sx.c             | 8 ++++++--
>  include/dt-bindings/clock/imx6sx-clock.h | 6 +++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
