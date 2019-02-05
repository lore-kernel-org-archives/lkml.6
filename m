Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC4AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA6A2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UzPDtY5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfBEIiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:38:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbfBEIiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:38:52 -0500
Received: from zn.tnic (p200300EC2BCB6B008896F3D5E1C66173.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:8896:f3d5:e1c6:6173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 139C91EC0911;
        Tue,  5 Feb 2019 09:38:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549355931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=HVEYFmg9HFJIqAd6lwQ6y1GC1+SOvTeR7oIR5PrjbQI=;
        b=UzPDtY5Boh7RQg41vYd03FB8jUBoCgYNbwksR5m/q7FfNJpt1RrFXCydxMkhUpcbvILlze
        kXFUD2GFho6IaVytFPLrrz3bAbIkTGqKsA2LFA875U49wi//mN1QTul81js90flOxnSsDl
        4S/E4Ehgy5eIwTjtRijUgzBNb5k8lW8=
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] MAINTAINERS: Add James Morse to the list of APEI reviewers
Date:   Tue,  5 Feb 2019 09:38:36 +0100
Message-Id: <20190205083836.21641-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add James to the list of reviewers of the firmware-assisted RAS glue.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: James Morse <james.morse@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5f8ea1e08b..a7e9263a208b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -331,6 +331,7 @@ ACPI APEI
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Len Brown <lenb@kernel.org>
 L:	linux-acpi@vger.kernel.org
+R:	James Morse <james.morse@arm.com>
 R:	Tony Luck <tony.luck@intel.com>
 R:	Borislav Petkov <bp@alien8.de>
 F:	drivers/acpi/apei/
-- 
2.19.1

