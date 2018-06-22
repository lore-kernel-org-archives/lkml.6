Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5B5C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448CB2401D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448CB2401D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933756AbeFVKKu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:10:50 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:53682 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeFVKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:08:17 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 1m8F1y0143XaVaC06m8FNM; Fri, 22 Jun 2018 12:08:15 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzH-0001mI-M4; Fri, 22 Jun 2018 12:08:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzH-0007c4-KI; Fri, 22 Jun 2018 12:08:15 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openipmi-developer@lists.sourceforge.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] MAINTAINERS: Add file patterns for ipmi device tree bindings
Date:   Fri, 22 Jun 2018 12:08:15 +0200
Message-Id: <20180622100815.29221-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v3:
  - Update for next-20180622,

v2:
  - New.

Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/ipmi/":

+Corey Minyard <minyard@acm.org> (supporter:IPMI SUBSYSTEM)
 Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-Corey Minyard <cminyard@mvista.com> (commit_signer:2/2=100%)
-Haiyue Wang <haiyue.wang@linux.intel.com> (commit_signer:2/2=100%,authored:2/2=100%)
-Avi Fishman <avifishman70@gmail.com> (commit_signer:1/2=50%)
+openipmi-developer@lists.sourceforge.net (moderated list:IPMI SUBSYSTEM)
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel@vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 76b5dd65291f9650..321fbaa7e7d273a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7463,6 +7463,7 @@ M:	Corey Minyard <minyard@acm.org>
 L:	openipmi-developer@lists.sourceforge.net (moderated for non-subscribers)
 W:	http://openipmi.sourceforge.net/
 S:	Supported
+F:	Documentation/devicetree/bindings/ipmi/
 F:	Documentation/IPMI.txt
 F:	drivers/char/ipmi/
 F:	include/linux/ipmi*
-- 
2.17.1

