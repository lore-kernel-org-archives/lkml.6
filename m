Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582AAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2858620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2858620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeLEMqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:46:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51891 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbeLEMqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:46:31 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2559920C36; Wed,  5 Dec 2018 13:46:29 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id BAD5020A35;
        Wed,  5 Dec 2018 13:46:18 +0100 (CET)
Date:   Wed, 5 Dec 2018 13:46:18 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Vignesh R <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Message-ID: <20181205134618.56223758@bbrezillon>
In-Reply-To: <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181203101937.7b01a0ad@bbrezillon>
        <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 17:25:12 +0530
Vignesh R <vigneshr@ti.com> wrote:

> >>   mtd: spi-nor: add opcodes for octal Read/Write commands
> >>   mtd: spi-nor: add octal read flag for flash mt35xu512aba  
> 
> Could you consider merging these two patches alone for v4.21?
> These can be applied independent of other patches in the series and
> would allow supporting OSPI flash at SPI NOR level with Cadence QSPI driver.

Yep, I'll queue them to spi-nor/next.

> >>   spi: nxp-fspi: add octal mode flag bit for octal support  

Mark, I think you can pick this one too.
