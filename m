Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706CFC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E060214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E060214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeLCHv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:51:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48804 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbeLCHv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:51:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F13F520CFB; Mon,  3 Dec 2018 08:51:50 +0100 (CET)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A33A120786;
        Mon,  3 Dec 2018 08:51:50 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Huijin Park <huijin.park@samsung.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        bbanghj.park@gmail.com
Subject: Re: [v3] mtd: change len type from signed to unsigned type
Date:   Mon,  3 Dec 2018 08:51:50 +0100
Message-Id: <20181203075150.28570-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: c840755a1284a974600ddb16c84722dd66bae1ee
In-Reply-To: <1543465191-2100-1-git-send-email-huijin.park@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 04:19:51 UTC, Huijin Park wrote:
> From: "huijin.park" <huijin.park@samsung.com>
> 
> Callers of erase_write() always pass an unsigned int.
> So this patch avoids a cast to an int.
> 
> Signed-off-by: huijin.park <huijin.park@samsung.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
