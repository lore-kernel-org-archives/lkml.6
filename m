Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E3EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E6821720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeLTIjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:39:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54071 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbeLTIjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:39:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 446FC208CB; Thu, 20 Dec 2018 09:39:21 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id D24592078E;
        Thu, 20 Dec 2018 09:39:10 +0100 (CET)
Date:   Thu, 20 Dec 2018 09:39:09 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/7] spi: add support for octal mode
Message-ID: <20181220093909.0e3ad8f1@bbrezillon>
In-Reply-To: <VI1PR04MB5726FABF724D8EE0144E2C8499BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
        <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <d513cf77-b308-a089-71cf-4598bfd2f085@ti.com>
        <VI1PR04MB5726FABF724D8EE0144E2C8499BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 08:23:07 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Octal mode support patch series has dependency over these patches.
> Should I send these two patches again or specifies them as dependency patches in the cover letter.

No, you should either base your work on the master branch of the
linux-next repo [1] (as suggested by Vignesh) or wait
for 4.21-rc1/5.0-rc1 before sending a new version.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/
