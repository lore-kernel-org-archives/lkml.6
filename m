Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078EFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F9A208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 12:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F9A208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933659AbeFQMzB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 08:55:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:58351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933241AbeFQMy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 08:54:59 -0400
Received: from longitude ([109.91.33.105]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lpfas-1g6bZi03le-00fUhc; Sun, 17
 Jun 2018 14:54:52 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: wii: Remove outdated comment about memory fixups
Date:   Sun, 17 Jun 2018 14:49:06 +0200
Message-Id: <20180617124909.26828-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:D/5oVsDoai77aBk0uT3b6uSRqQNmm8e0ycNhS9oW5f9iQVgXtsQ
 fNYJogslQQCNiuymmxE/l7VYT7rXkB6acDR1OfEa9HCF0dzCvzFNxSQ8IHXmLH2wQoAKCcR
 3kTcdmauthAvkKK8SxxLRZIOG4GErzLe8aTboOmKLGESWbuUieWvJMZA03x3C8f79MMsfSy
 ByK8LHQfN8c6bXTy1cbvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0u5vHJGrCGg=:V+qrQRhIqCWPxCLqKd808s
 rK8FKtUcKOF++NURnXRLbTUA4CIm3h0rtJwX35G6vmB5Jnt6l1BLFcCK0g0c4guhepnxy7XNK
 BvcCyL1m3NULZzHEIY3QxCW+9wZnK9jmR9hezLZRALT0o6o27iY7NzzDnUelSm0745LqeccPi
 tcpkhG4T3B8p0aK4ZDCedxfgenmn8e+DgXqnFPqH5zfk+PB6Ades6/oqQB29gjQQawmGHXbch
 IIp2Aa7S837P+7Dfmnyiwlgjlx3Fr7HptbcCe1074jIOgxK8/V6sgiviJsndWExUwiK4UD4Bx
 BmMcNR0OqRjREuDeJeociZoG9rIUSegDQorfJoZEdJ0GUnWA0D1eS8//6IqUHo5UBJiJCqA3k
 lnrifeJAA7aJ66iN/WRh3qXUzZYR6KVMpiLsKxnFl6mXYNYVOxFzSnIYUSy8NjEFK+Xp84FqO
 u4KCJjuq5mHugbg+etykML+5ZYGQAqsHvzjzofFXfSiEKo2DdeD6/oE8eNSqdlxhzfQ1Vs0OL
 V6svzmVejqw8DA/IOmFs4EKbBS72krxIasyJTW5DqhxylnZSgKDWZINNr1Y9uaLBjV2KcXqDE
 5HV69Xq6uxbjnEb6p3ekOcFbVeb35Us/+oBjwEUpUotJPVEao3VCkbq8eGn2dk3J732WvyxQ+
 JxZV/vg2wmS9ZD1Tz8JlLm1pky1+W5ucHbYeRULMIy7Nbz6VPspssaH8wtB72ylL7alBahXSm
 S/qVOb2FvUNW+R/ojJe38flIdFPCgY/Ca+ILqaXJR75XPDcH4QvPPdWtkXENK13oTXNf4tLTl
 MHwnGvU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workaround has been removed. What stays is just code to find the
memory hole so the BATs can be configured properly in the function below.

Fixes: 57deb8fea01f ("powerpc/wii: Don't rely on the reserved memory hack")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/platforms/embedded6xx/wii.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index fc00d82691e1..a133b70bfe6f 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -68,16 +68,6 @@ void __init wii_memory_fixups(void)
 {
 	struct memblock_region *p = memblock.memory.regions;
 
-	/*
-	 * This is part of a workaround to allow the use of two
-	 * discontinuous RAM ranges on the Wii, even if this is
-	 * currently unsupported on 32-bit PowerPC Linux.
-	 *
-	 * We coalesce the two memory ranges of the Wii into a
-	 * single range, then create a reservation for the "hole"
-	 * between both ranges.
-	 */
-
 	BUG_ON(memblock.memory.cnt != 2);
 	BUG_ON(!page_aligned(p[0].base) || !page_aligned(p[1].base));
 
-- 
2.17.1

