Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeEVR45 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:56:57 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34213 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeEVR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:56:55 -0400
X-Google-Smtp-Source: AB8JxZrrc2NJBHR0xOoeZIgFVUqRvgjyEC6UKBYFT5XyBPrJ6tYwDjCScw85n5rCdnsidyiQIkfcfA==
Date: Tue, 22 May 2018 12:56:53 -0500
From: Rob Herring <robh@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        stefan@agner.ch, adriana.reus@nxp.com, rui.silva@linaro.org,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V2 2/3] clk: imx7d: correct enet clock CCGR registers
Message-ID: <20180522175652.GA4795@rob-hp-laptop>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
 <1526605266-18464-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526605266-18464-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 09:01:05AM +0800, Anson Huang wrote:
> Correct enet clock gates as below:
> 
> CCGR6: IMX7D_ENET_AXI_ROOT_CLK (enet1 and enet2 bus clocks)
> CCGR112: IMX7D_ENET1_TIME_ROOT_CLK, IMX7D_ENET1_IPG_ROOT_CLK
> CCGR113: IMX7D_ENET2_TIME_ROOT_CLK, IMX7D_ENET2_IPG_ROOT_CLK
> 
> Just rename unused IMX7D_ENETx_REF_ROOT_CLK for
> IMX7D_ENETx_IPG_ROOT_CLK instead of adding new clocks.
> 
> Based on Andy Duan's patch from the NXP kernel tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7d.c             | 10 ++++++----

>  include/dt-bindings/clock/imx7d-clock.h |  4 ++--

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 8 insertions(+), 6 deletions(-)
