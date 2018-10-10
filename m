Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F798C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E252086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E252086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJKDi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:38:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJKDi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:38:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2524830024C4;
        Wed, 10 Oct 2018 20:15:12 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E62E91810C;
        Wed, 10 Oct 2018 20:15:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] LICENSES: Add note to CDDL-1.0 license that it should not be used
Date:   Wed, 10 Oct 2018 22:15:08 +0200
Message-Id: <20181010201509.26979-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 10 Oct 2018 20:15:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only reason we have the CDDL-1.0 license text around is for some
dual-licensed files from virtualbox. New code should not use this license.

Add a note about this and change the example tag to be dual-licensed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add text specifying that CDDL may only be used together with OR
-Change GPL-2.0 in example with $GPL-COMPATIBLE-ID
---
 LICENSES/other/CDDL-1.0 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/LICENSES/other/CDDL-1.0 b/LICENSES/other/CDDL-1.0
index 195a1687930a..25f614276ddd 100644
--- a/LICENSES/other/CDDL-1.0
+++ b/LICENSES/other/CDDL-1.0
@@ -1,10 +1,14 @@
 Valid-License-Identifier: CDDL-1.0
 SPDX-URL: https://spdx.org/licenses/CDDL-1.0.html
 Usage-Guide:
+  Do NOT use. The CDDL-1.0 is not GPL compatible. It may only be used for
+  dual-licensed files where the other license is GPL compatible.
+  If you end up using this it MUST be used together with a GPL2 compatible
+  license using "OR".
   To use the Common Development and Distribution License 1.0 put the
   following SPDX tag/value pair into a comment according to the placement
   guidelines in the licensing rules documentation:
-    SPDX-License-Identifier: CDDL-1.0
+    SPDX-License-Identifier: ($GPL-COMPATIBLE-ID OR CDDL-1.0)
 
 License-Text:
 
-- 
2.19.0

