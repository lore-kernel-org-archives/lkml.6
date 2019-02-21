Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1FE2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBUH7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:59:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51172 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:59:19 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 39ECB27F823;
        Thu, 21 Feb 2019 07:59:18 +0000 (GMT)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [v2,2/2] mtd: spi-nor: Add support for MX25V8035F
Date:   Thu, 21 Feb 2019 08:59:16 +0100
Message-Id: <20190221075916.3631-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218120421.5034-2-frieder.schrempf@kontron.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: e36bb65e5d0cf3233d4da6af4a03d802af51a376
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

On Mon, 2019-02-18 at 12:04:43 UTC, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This adds support for the Macronix MX25V8035F, a 8Mb SPI NOR chip.
> It is used on i.MX6UL/ULL SoMs by Kontron Electronics GmbH (N631x).
> It was only tested with a single data line connected, by writing and
> reading random data with dd.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
