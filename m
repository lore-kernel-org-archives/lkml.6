Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827CAC2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4811B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dQq0lzxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfAUMjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:39:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53242 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbfAUMjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:39:45 -0500
Received: from zn.tnic (p200300EC2BC62500F05176FA1988078F.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:2500:f051:76fa:1988:78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21E341EC01B6;
        Mon, 21 Jan 2019 13:39:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548074384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=0E81+HK1MLUjBEqq6zbS4tFCYla6sSBx7zaJPfEQKS4=;
        b=dQq0lzxBpRkbITCh0D1drnJFTgMcwBzgBxGHtUSetxgNkZuxToedaW0nGB49yNv6AVv05L
        IYyGRTpINfnfs/Kpt2XPXD5L9j/kh08BrE5n4bp/6kEAwbXHWIHXUhKVlixEVGveV4aC69
        jH0PTa5H5VFLXgZ8Pz4VB3DM3/x6tTE=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH] EDAC: Add James Morse as a reviewer
Date:   Mon, 21 Jan 2019 13:39:41 +0100
Message-Id: <20190121123941.28247-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

With the growing amount of ARM[,64] EDAC enablement happening, add James
as a reviewer for the ARM bits.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: James Morse <james.morse@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ce25174fa02..0f5ef1d6299a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5426,6 +5426,7 @@ F:	drivers/edac/thunderx_edac*
 EDAC-CORE
 M:	Borislav Petkov <bp@alien8.de>
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
+R:	James Morse <james.morse@arm.com>
 L:	linux-edac@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git for-next
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-edac.git linux_next
-- 
2.19.1

