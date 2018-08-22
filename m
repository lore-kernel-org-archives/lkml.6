Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55348C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F9F2148C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F9F2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emtrion.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbeHVRO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:14:57 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:48943 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbeHVRO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:14:57 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2018 13:14:56 EDT
Received: from tuelinux-v3.emtrion.local (2003:5a:a012:1:20c:29ff:fecb:7426)
 by bmk019s01.emtrion.local (2003:5a:a012:1:d9c:d045:28a7:5f84) with Microsoft
 SMTP Server (TLS) id 8.3.485.1; Wed, 22 Aug 2018 15:44:29 +0200
From:   Jan Tuerk <jan.tuerk@emtrion.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: Fix typo in compatible description.
Date:   Wed, 22 Aug 2018 15:43:48 +0200
Message-ID: <20180822134348.49165-1-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-24046.007
X-TM-AS-Result: No--3.522100-8.000000-31
X-TM-AS-MatchedID: 157008-704410-188019-702311-704568-712124-711139-148004-1
        48036-42000-42003-55
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the error in the compatible documentation for the EDT
etm0700[g].. panels which have accidentally documented as etm0700[8]0..

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 .../devicetree/bindings/display/panel/edt,et-series.txt     | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/edt,et-series.txt b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
index f56b99ebd9be..5759d64d0c15 100644
--- a/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
+++ b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
@@ -23,13 +23,13 @@ simple-panel.txt
 +-----------------+---------------------+-------------------------------------+
 | Identifier      | compatbile          | description                         |
 +=================+=====================+=====================================+
-| ETM0700G0DH6    | edt,etm070080dh6    | WVGA TFT Display with capacitive    |
+| ETM0700G0DH6    | edt,etm0700g0dh6    | WVGA TFT Display with capacitive    |
 |                 |                     | Touchscreen                         |
 +-----------------+---------------------+-------------------------------------+
-| ETM0700G0BDH6   | edt,etm070080bdh6   | Same as ETM0700G0DH6 but with       |
+| ETM0700G0BDH6   | edt,etm0700g0bdh6   | Same as ETM0700G0DH6 but with       |
 |                 |                     | inverted pixel clock.               |
 +-----------------+---------------------+-------------------------------------+
-| ETM0700G0EDH6   | edt,etm070080edh6   | Same display as the ETM0700G0BDH6,  |
+| ETM0700G0EDH6   | edt,etm0700g0edh6   | Same display as the ETM0700G0BDH6,  |
 |                 |                     | but with changed Hardware for the   |
 |                 |                     | backlight and the touch interface   |
 +-----------------+---------------------+-------------------------------------+
-- 
2.18.0

