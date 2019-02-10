Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B41C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCCD20873
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBJS4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:56:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34270 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfBJS4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:56:47 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E1850260547;
        Sun, 10 Feb 2019 18:56:44 +0000 (GMT)
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Purna Chandra Mandal <purna.chandra.mandal@intel.com>,
        Fred Bloggs <f.blogs@napier.co.nz>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtd: spi-nor: cadence-quadspi: write upto 8-bytes data in STIG mode
Date:   Sun, 10 Feb 2019 19:56:41 +0100
Message-Id: <20190210185641.29270-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128050229.44965-1-purna.chandra.mandal@intel.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 9558281572e35a86c8072d47c23ae6c9cdae2149
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <bbrezillon@kernel.org>

On Mon, 2019-01-28 at 05:02:29 UTC, Purna Chandra Mandal wrote:
> cadence-quadspi controller allows upto eight bytes of data to
> be written in software Triggered Instruction generator (STIG) mode
> of operation. Lower 4 bytes are written through writedatalower and
> upper 4 bytes by writedataupper register.
> 
> This patch allows all the 8 bytes to be written.
> 
> Signed-off-by: Purna Chandra Mandal <purna.chandra.mandal@intel.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Vignesh R <vigneshr@ti.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
