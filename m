Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B067C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1990E2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1990E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLCHwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:52:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48846 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeLCHwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:52:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 89FD320CFA; Mon,  3 Dec 2018 08:52:14 +0100 (CET)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3F5102071D;
        Mon,  3 Dec 2018 08:52:14 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Colin King <colin.king@canonical.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: mtd: nftl: clean up indentation, remove extraneous tabs
Date:   Mon,  3 Dec 2018 08:52:13 +0100
Message-Id: <20181203075213.28993-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 4845a077c0b9c5c10422a090dbd1d894233f9456
In-Reply-To: <20181118163656.30698-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-18 at 16:36:56 UTC, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The hunk of code is indented too much by one level, fix this by
> removing the extraneous tabs. Also terminate block comment using
> the recommended coding style to clean up checkpatch warning.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
