Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DBB2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DBB2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJJS1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:27:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbeJJS1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:27:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5DA281DEB;
        Wed, 10 Oct 2018 11:05:42 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74C291001F41;
        Wed, 10 Oct 2018 11:05:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] LICENSES: Add note to CDDL-1.0 license that it should not be used
Date:   Wed, 10 Oct 2018 13:05:39 +0200
Message-Id: <20181010110540.22468-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 10 Oct 2018 11:05:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only reason we have the CDDL-1.0 license text around is for some
dual-licensed files from virtualbox. New code should not use this license.

Add a note about this and change the example tag to be dual-licensed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 LICENSES/other/CDDL-1.0 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/LICENSES/other/CDDL-1.0 b/LICENSES/other/CDDL-1.0
index 195a1687930a..164401ea9e62 100644
--- a/LICENSES/other/CDDL-1.0
+++ b/LICENSES/other/CDDL-1.0
@@ -1,10 +1,12 @@
 Valid-License-Identifier: CDDL-1.0
 SPDX-URL: https://spdx.org/licenses/CDDL-1.0.html
 Usage-Guide:
+  Do NOT use. The CDDL-1.0 is not GPL compatible. It may only be used for
+  dual-licensed files where the other license is GPL compatible.
   To use the Common Development and Distribution License 1.0 put the
   following SPDX tag/value pair into a comment according to the placement
   guidelines in the licensing rules documentation:
-    SPDX-License-Identifier: CDDL-1.0
+    SPDX-License-Identifier: (GPL-2.0 OR CDDL-1.0)
 
 License-Text:
 
-- 
2.19.0

