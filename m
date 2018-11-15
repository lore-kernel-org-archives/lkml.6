Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AB7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172262087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172262087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbeKOXqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:46:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41020 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbeKOXqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:46:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 943F720752; Thu, 15 Nov 2018 14:38:48 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4B5B520510;
        Thu, 15 Nov 2018 14:38:48 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Tudor.Ambarus@microchip.com, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        yogeshnarayan.gaur@nxp.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, cyrille.pitchen@wedev4u.fr
Subject: Re: [v2,5/5] mtd: spi-nor: remove unneeded smpt zeroization
Date:   Thu, 15 Nov 2018 14:38:48 +0100
Message-Id: <20181115133848.16443-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 472247d323153395f392ff2bfcf796f0f51890fe
In-Reply-To: <20181109165644.30534-6-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-09 at 16:56:56 UTC,  wrote:
> The entire smpt array is initialized with data read from sfdp,
> there is no need to init it with zeroes before.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris
