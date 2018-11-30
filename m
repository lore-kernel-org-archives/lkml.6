Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F62BC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2C52146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2C52146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeK3Uqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:46:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47567 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeK3Uqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:46:35 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE7BA20CFB; Fri, 30 Nov 2018 10:37:51 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7953F20787;
        Fri, 30 Nov 2018 10:37:51 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Tudor.Ambarus@microchip.com, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at
Cc:     alexander.sverdlin@nokia.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2] mtd: spi-nor: fix erase_type array to indicate current map conf
Date:   Fri, 30 Nov 2018 10:37:51 +0100
Message-Id: <20181130093751.5553-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: dc92843159a7d01e37cf68750745333e944a9e55
In-Reply-To: <20181126124531.17548-1-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 12:45:44 UTC,  wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> BFPT advertises all the erase types supported by all the possible
> map configurations. Mask out the erase types that are not supported
> by the current map configuration.
> 
> Backward compatibility test done on sst26vf064b.
> 
> Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table")
> Reported-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Applied to http://git.infradead.org/linux-mtd.git master, thanks.

Boris
