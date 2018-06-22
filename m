Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD96C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A1924010
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A1924010
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933612AbeFVKIa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:08:30 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:53878 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933465AbeFVKIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:08:23 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 1m8L1y00A3XaVaC06m8LPW; Fri, 22 Jun 2018 12:08:22 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzM-0001mg-5j; Fri, 22 Jun 2018 12:08:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzM-0007gq-4B; Fri, 22 Jun 2018 12:08:20 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] MAINTAINERS: Add file patterns for tpm device tree bindings
Date:   Fri, 22 Jun 2018 12:08:19 +0200
Message-Id: <20180622100819.29518-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v3:
  - Update for next-20180622,

v2:
  - Add Acked-by.

Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/security/tpm/":

-Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:2/2=100%,authored:1/2=50%)
-Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:1/2=50%)
-Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> (commit_signer:2/2=100%)
-Enric Balletbo i Serra <enric.balletbo@collabora.com> (commit_signer:1/2=50%,authored:1/2=50%)
-Sonny Rao <sonnyrao@chromium.org> (commit_signer:1/2=50%)
+Peter Huewe <peterhuewe@gmx.de> (maintainer:TPM DEVICE DRIVER)
+Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> (maintainer:TPM DEVICE DRIVER)
+Jason Gunthorpe <jgg@ziepe.ca> (reviewer:TPM DEVICE DRIVER)
+Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
+Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
+linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER)
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel@vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c546cf9a53ca301..1030624a6e113786 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14481,6 +14481,7 @@ Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
 T:	git git://git.infradead.org/users/jjs/linux-tpmdd.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/security/tpm/
 F:	drivers/char/tpm/
 
 TRACING
-- 
2.17.1

