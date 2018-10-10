Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBC6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1842075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1842075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJKDi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:38:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJKDi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:38:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8E9D7F6B0;
        Wed, 10 Oct 2018 20:15:13 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6246E5C2E6;
        Wed, 10 Oct 2018 20:15:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH v2 2/2] LICENSES: Add ISC license text
Date:   Wed, 10 Oct 2018 22:15:09 +0200
Message-Id: <20181010201509.26979-2-hdegoede@redhat.com>
In-Reply-To: <20181010201509.26979-1-hdegoede@redhat.com>
References: <20181010201509.26979-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 10 Oct 2018 20:15:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the full text of the ISC license to the kernel tree. It was copied
directly from:

   https://spdx.org/licenses/ISC.html

With the mention of "ISC" in the warranty disclaimer replaced with
"THE AUTHOR" as done in the ISC license headers used in the ath10k and
brcmfmac wifi drivers.

Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 LICENSES/other/ISC | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 LICENSES/other/ISC

diff --git a/LICENSES/other/ISC b/LICENSES/other/ISC
new file mode 100644
index 000000000000..8953c3142079
--- /dev/null
+++ b/LICENSES/other/ISC
@@ -0,0 +1,24 @@
+Valid-License-Identifier: ISC
+SPDX-URL: https://spdx.org/licenses/ISC.html
+Usage-Guide:
+  To use the ISC License put the following SPDX tag/value pair into a
+  comment according to the placement guidelines in the licensing rules
+  documentation:
+    SPDX-License-Identifier: ISC
+License-Text:
+
+ISC License
+
+Copyright (c) <year> <copyright holders>
+
+Permission to use, copy, modify, and/or distribute this software for any
+purpose with or without fee is hereby granted, provided that the above
+copyright notice and this permission notice appear in all copies.
+
+THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
+OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
+CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-- 
2.19.0

