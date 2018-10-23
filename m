Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAFFC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944A920652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944A920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeJWSTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:19:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43341 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWSTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:19:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1409C20789; Tue, 23 Oct 2018 11:56:35 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id BE75820701;
        Tue, 23 Oct 2018 11:56:34 +0200 (CEST)
Date:   Tue, 23 Oct 2018 11:56:34 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Message-ID: <20181023115634.00dd6d23@bbrezillon>
In-Reply-To: <VI1PR04MB1038969FFFCC16DD6094031599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181012080753.2a59b75c@bbrezillon>
        <VI1PR04MB1038A3680E02FC107367E5FF99E20@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <VI1PR04MB1038969FFFCC16DD6094031599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Tue, 23 Oct 2018 09:39:25 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi,
> 
> Did we have have any comments or remarks about this patch-series,  if not please apply.

Sorry, but it was already too late for this release, and the merge
window just started, so it will have to wait at least 2 more weeks.

We've been lagging with SPI NOR patches for the last couple releases
because I clearly don't have time to review those contributions, and it
seems Marek does not have time either.

> 
> Both patches in the series been reviewed by Tudor.

Things are improving a bit thanks to Tudor's involvement in the review
process, but I'd like to remember you that you, as a regular
contributor to the spi-nor subsystem, can help us with that too. That
is, help review patches coming from others instead of only focusing on
your own contributions.

Regards,

Boris
