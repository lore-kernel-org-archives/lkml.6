Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8DAECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1E2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD1E2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbeJQX64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:58:56 -0400
Received: from mail1.skidata.com ([91.230.2.99]:30603 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbeJQX64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:58:56 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2018 19:58:55 EDT
X-IronPort-AV: E=Sophos;i="5.54,393,1534802400"; 
   d="scan'208";a="12919579"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 5/8] dt-bindings: input: touchscreen: sx8654: add sx8650 to comatibles
Date:   Wed, 17 Oct 2018 14:51:13 +0200
Message-ID: <20181017125116.20077-6-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the sx8650 is quite similar to the sx8654 support for it will be
added in the driver. Therefore add it to the compatibles.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
index a538678424dd..0ebe6dd043c7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible: must be one of the following, depending on the model:
+	"semtech,sx8650"
 	"semtech,sx8654"
 	"semtech,sx8655"
 	"semtech,sx8656"
-- 
2.11.0

