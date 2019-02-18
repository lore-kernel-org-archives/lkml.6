Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EA9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CEF21902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498828;
	bh=KOS80/Q9DqqL8LYrapIwpBdVp23rYOfkPyxFTboRe34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kBXM2s0pjoLx3Pm8Akxpw6LYm77AXiEHfDkjAqSD7ZE4h6WbEwpHOypiFzBGyCWJd
	 mhaVda5OVZrhKN37H4+Z69vbOO7FzG9WLHsUaOKK1UmIgv6NpKnmd9aoLR3OqAu/mV
	 ew894DLcm1PLg2b5psEt3cP/uYVcapbP1Co2xTrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390540AbfBROHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388970AbfBROHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16DDC21916;
        Mon, 18 Feb 2019 14:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498820;
        bh=KOS80/Q9DqqL8LYrapIwpBdVp23rYOfkPyxFTboRe34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnuGnq6hfxaIipGuSyw2RuQz+QF80kYMYWZqRkUt9tbvYPtYha1AHcL1Hj9qheIRO
         rpd9IYI58A0clLZGYJdGE03sjFzgsXBLVvlX97HyqFeTqyuzMqRRaMMZglo4f2SZ3T
         XuCpKE0237QnNFXVzxOeBrborlbuk306hVVW4gd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rustad <mrustad@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 124/143] Documentation/network: reword kernel version reference
Date:   Mon, 18 Feb 2019 14:44:12 +0100
Message-Id: <20190218133533.532381561@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

It seemed odd to say "since 4.17" in a 4.4 kernel. Consider
rewording the reference to indicate where in the stable series
it was introduced as well as where it originated.

Signed-off-by: Mark Rustad <mrustad@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/ip-sysctl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
index 7c229f59016f..2fb35658d151 100644
--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -116,7 +116,7 @@ ipfrag_high_thresh - LONG INTEGER
 	Maximum memory used to reassemble IP fragments.
 
 ipfrag_low_thresh - LONG INTEGER
-	(Obsolete since linux-4.17)
+	(Obsolete since linux-4.4.174, backported from linux-4.17)
 	Maximum memory used to reassemble IP fragments before the kernel
 	begins to remove incomplete fragment queues to free up resources.
 	The kernel still accepts new fragments for defragmentation.
-- 
2.19.1



