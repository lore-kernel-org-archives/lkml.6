Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A553C282D6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAB420881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548838736;
	bh=myyEUTnhx4vD0+QVNDPfocI8er48p8RnKngtTleZi0g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Nb/1GKuHafdlrUroXft8/pNMz/zpJyc44KQyxpP5bD23/Y5IujHUBKe5jTK77VSf6
	 Qy0Fok6dKeCIf4V0BysA6kUzDMj/kljm6vVikpH0uuxk1ig2aAKO4YTrMfb1t8bz2R
	 aur5VOEUcKTr5Z2cGR09hJCZ07kZv//CS0fKLwJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfA3I6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfA3I6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:58:54 -0500
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 235862087F;
        Wed, 30 Jan 2019 08:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548838733;
        bh=myyEUTnhx4vD0+QVNDPfocI8er48p8RnKngtTleZi0g=;
        h=From:To:Cc:Subject:Date:From;
        b=FciL5bLK+pp8VX1mM1ektWOc8mg1SkOl/1cAztMSWgUOQC0JeQtippFazBb22BqT0
         LoU4ZCh5Tb2Tf2kPzMU3syxdyydVAiP/3ZCzkSEH7MIX5LSk8InTaePKLhNjwV56Xd
         o/VF778LS7lvC+KFZQUDM3MVwtKPVYOvLozq1sPk=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add the IRC channel to the MTD entry
Date:   Wed, 30 Jan 2019 09:58:45 +0100
Message-Id: <20190130085845.6790-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #mtd channel (on OFTC servers) is being used to discuss MTD related
topics. Add it to the MTD entry.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..7b39ba46384a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9805,6 +9805,7 @@ M:	Richard Weinberger <richard@nod.at>
 L:	linux-mtd@lists.infradead.org
 W:	http://www.linux-mtd.infradead.org/
 Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
+C:	irc://irc.oftc.net/mtd
 T:	git git://git.infradead.org/linux-mtd.git master
 T:	git git://git.infradead.org/linux-mtd.git mtd/next
 S:	Maintained
-- 
2.17.1

