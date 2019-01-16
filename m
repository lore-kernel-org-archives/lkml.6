Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51AD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547643445;
	bh=97/AyEH1Pesr78tRYByb7PJgYyVrNy4bL4YH54eYynM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=Qe2z/PHEuMP+cWB92WVwFQpcZ1H2dNuuBvgUT9bai/oT3FCsp12jPWncO3zUzPIoS
	 yAfy8JQlQeLgl3TX89VkjzCoWB7UiExhzN4r4HsRuPtRf1mK35JT5BNkHNHqBV/HgP
	 BCA1NxHxWIXSU7t85f2RRIZscigHVm5flFEL2HEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392909AbfAPM5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:57:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732803AbfAPM5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:57:23 -0500
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8E7206C2;
        Wed, 16 Jan 2019 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547643443;
        bh=97/AyEH1Pesr78tRYByb7PJgYyVrNy4bL4YH54eYynM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=Lc0PgfNOOIjY/WRX8b932Ypx3J8GPNzsWsSIcrxcQJ89MJFvyr+n4TY76aZMvxVMe
         K8wdZkyOrWGBE4JAK5sbYv+4URnc4JmBEK0uyUNI8dP0DgjbQnAxp6yjg+bZegXTOJ
         8oTeAs7/k8VWSSo0Hvd+8vzhUr7xOpP27Q5pGu8Q=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Tudor.Ambarus@microchip.com, marek.vasut@gmail.com,
        boris.brezillon@bootlin.co, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, miquel.raynal@bootlin.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: MAINTAINERS: add myself as SPI NOR co-maintainer
Date:   Wed, 16 Jan 2019 13:57:15 +0100
Message-Id: <20190116125715.31215-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 6f79a594afdaeb5d0644dfee91ef570be9f0e3fe
In-Reply-To: <20190115165740.32450-1-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

On Tue, 2019-01-15 at 16:57:52 UTC,  wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> I have been reviewing and contributing to the SPI NOR subsystem
> for the last few months and I'm willing to continue doing so.
> Volunteer as a maintainer for the SPI NOR part of the MTD subsystem.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> Acked-by: Richard Weinberger <richard@nod.at>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
