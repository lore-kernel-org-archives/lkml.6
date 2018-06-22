Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E0C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B25924008
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B25924008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeFVKIT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:08:19 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:46330 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbeFVKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:08:16 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 1m8E1y01A3XaVaC06m8FZL; Fri, 22 Jun 2018 12:08:15 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzG-0001mD-US; Fri, 22 Jun 2018 12:08:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzG-0007bG-So; Fri, 22 Jun 2018 12:08:14 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        uclinux-h8-devel@lists.sourceforge.jp, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] MAINTAINERS: Add file patterns for h8300 device tree bindings
Date:   Fri, 22 Jun 2018 12:08:14 +0200
Message-Id: <20180622100814.29172-1-geert@linux-m68k.org>
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
  - No changes.

Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/h8300/":

+Yoshinori Sato <ysato@users.sourceforge.jp> (maintainer:H8/300 ARCHITECTURE)
 Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
+uclinux-h8-devel@lists.sourceforge.jp (moderated list:H8/300 ARCHITECTURE)
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel@vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07a4927b1e7aada4..76b5dd65291f9650 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6265,6 +6265,7 @@ L:	uclinux-h8-devel@lists.sourceforge.jp (moderated for non-subscribers)
 W:	http://uclinux-h8.sourceforge.jp
 T:	git git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/h8300/
 F:	arch/h8300/
 F:	drivers/clocksource/h8300_*.c
 F:	drivers/clk/h8300/
-- 
2.17.1

