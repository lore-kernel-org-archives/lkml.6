Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4EAC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD38218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfAYJkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:40:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37699 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfAYJkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:40:06 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gmxxv-0002Ax-3H; Fri, 25 Jan 2019 10:39:59 +0100
Message-ID: <1548409197.28802.38.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/5] dt-bindings: dma: fsl-imx-sdma: add fsl,imx8mq
 to the accepted compatible node
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 25 Jan 2019 10:39:57 +0100
In-Reply-To: <20190125025528.15645-4-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
         <20190125025528.15645-1-angus@akkea.ca>
         <20190125025528.15645-4-angus@akkea.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 24.01.2019, 19:55 -0700 schrieb Angus Ainslie (Purism):
> The imx8mq is a slightly different variant on the imx7d

Not really AFAICS, but it's good to document the used compatibles
anyways, so:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index 3c9a57a8443b..9d8bbac27d8b 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -9,6 +9,7 @@ Required properties:
>        "fsl,imx53-sdma"
>        "fsl,imx6q-sdma"
>        "fsl,imx7d-sdma"
> +      "fsl,imx8mq-sdma"
>    The -to variants should be preferred since they allow to determine the
>    correct ROM script addresses needed for the driver to work without additional
>    firmware.
