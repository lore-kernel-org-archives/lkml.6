Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D6EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1522089A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1522089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbeKJFXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:23:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54385 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725758AbeKJFXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:23:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 96350224CA; Fri,  9 Nov 2018 20:41:06 +0100 (CET)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4187420714;
        Fri,  9 Nov 2018 20:41:06 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: mtd: cfi_cmdset_0020: Mark expected switch fall-throughs
Date:   Fri,  9 Nov 2018 20:40:59 +0100
Message-Id: <20181109194059.20893-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: f7d6cf6d0c7e2d8035f849c9c4407c48924cbd0f
In-Reply-To: <20180815170226.GA14553@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-15 at 17:02:26 UTC, "Gustavo A. R. Silva" wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 114857 ("Missing break in switch")
> Addresses-Coverity-ID: 114858 ("Missing break in switch")
> Addresses-Coverity-ID: 114859 ("Missing break in switch")
> Addresses-Coverity-ID: 114860 ("Missing break in switch")
> Addresses-Coverity-ID: 114861 ("Missing break in switch")
> Addresses-Coverity-ID: 114862 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
