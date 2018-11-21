Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43090C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D12214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D12214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeKVBOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:14:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50998 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbeKVBOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:14:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6FAFD207AD; Wed, 21 Nov 2018 15:39:18 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 72CE720DA8;
        Wed, 21 Nov 2018 15:39:04 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: Re: [v3,1/2] mtd: spi-nor: add macros related to MICRON flash
Date:   Wed, 21 Nov 2018 15:39:04 +0100
Message-Id: <20181121143904.15449-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: aa7b5bead04fbf2cc199b85fd2095d564b9b48db
In-Reply-To: <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-12 at 02:23:08 UTC, Yogesh Narayan Gaur wrote:
> Some MICRON related macros in spi-nor domain were ST.
> Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.
> 
> Added entry of MFR Id for Micron flashes, 0x002C.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
