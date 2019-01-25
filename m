Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E314AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A384C218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="A5WEa+KB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfAYRmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:42:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54878 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfAYRmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:42:37 -0500
Received: from zn.tnic (p200300EC2BCAC50081F77380180606C8.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:c500:81f7:7380:1806:6c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A50F31EC0242;
        Fri, 25 Jan 2019 18:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548438155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=GiE4Pq1+e1Khyui8tinEEHFgC4L8hh0M0G+mLQ32G3c=;
        b=A5WEa+KBePyG4jUJDyqZvyTYWsKRmLaZ/dhpRurTKEStE4eRu9gc14gXbTLMI/KtoKjGU7
        4Tu5+pXOlUPSCw0nF812MPU0dunKtwsXubGTN1VN2h2Uv2qMyFFm7zB6kzUzwCdQqp3V94
        S1WOPg+VCexY5ohveeJdrzPI3JH7JRU=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH] RAS: Add a MAINTAINERS entry
Date:   Fri, 25 Jan 2019 18:42:27 +0100
Message-Id: <20190125174227.10652-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This was long overdue and it is needed at least so that Tony and I get
CCed on patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..a63f2b52a8dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12767,6 +12767,16 @@ M:	Alexandre Bounine <alex.bou9@gmail.com>
 S:	Maintained
 F:	drivers/rapidio/
 
+RAS INFRASTRUCTURE
+M:	Tony Luck <tony.luck@intel.com>
+M:	Borislav Petkov <bp@alien8.de>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/ras/
+F:	include/linux/ras.h
+F:	include/ras/ras_event.h
+F:	Documentation/admin-guide/ras.rst
+
 RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
-- 
2.19.1

