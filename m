Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39461ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCE520673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCE520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeGTIlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:41:06 -0400
Received: from mout.perfora.net ([74.208.4.197]:43707 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbeGTIlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:41:06 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MdtW7-1fNVH73PXJ-00PgNi; Fri, 20 Jul 2018 09:53:41 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-mtd@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] mtd: nand: fix spelling in driver api documentation
Date:   Fri, 20 Jul 2018 09:53:33 +0200
Message-Id: <20180720075334.24254-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:MFLqMv186UIH4Sp+rvdAI1MG1AcDNVN/jHsIX/L9T5cMB4oU1eV
 Bg21CeUQSwK+zfLFwhb+UhY6l19nefbLMITkKe/mWQto/Cy6D9nLTba2rExx3A6TI6hgZs9
 nVNFf2yox0J2mrmpPMragcx2UHNwjrJtfoNRqVx7mqLFxgorbIfyH9/WFpFgxCxBcfTWXvo
 3tYvVtfR/TNICH5JroqYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:huIpSAjKbsc=:4iVIkC5mxEHvdU8BB7HZXA
 86lzZZ21yYf6WjlTEQN2bkh/ukRFtN35IEVdR1TmWuEF89h5YwORfNAIPLg4sL3NVB403G9Tl
 j+swH0NZMhN9HAZ3f1hFPKMFYXlWSM6iaDefRlEsV21dNAQc9GMvAAF3Daw1TJOXq10KDP0Mb
 PnSDwaPqYkpJg9vi07J1+mwN7FP/WY1pKDh+BWOw8v0i8J0mpzvoD8cSGQnh3iOHuSqU+b775
 +TS3FZqfM4+dEKGtGA51j4yRN0y7AHkCxI5moZVe9ViHLBRd6jSdoluayehW8CBqfSBLgmX95
 qFukvqPJ1M6P6/EqPxyMPDr5EEYp0nEASjmo4dLcywHyAlCsFiKF2twM7BLIr90vF9Tmyn3ZC
 7r5jc8QVaj4OFDzWmHsopRLysq2ryNf/eM56A0txBVSPrxRqI1LBAzx0PiYtS9FPubuia1LwB
 m+fB4VAX4QisTdU2YzzzQOqVcr9Bpojkg2aKiyD4e2Bcla8p1ae7o6ap0sOWWZRQFNO0ZiSwd
 sm7mDmqWlrA2HSGoLkgF6w95ms7Mgicf6qCpwA9dKWEQ7Tdh3HQigULI+JWpte4204GgaFJYL
 78t1K8FWbQhjzvkHfQtt/ZdqYf6AU/2cr7KQM0LDN7w1wPkOxA9KgqllbcT6hbOHTqCRik/HX
 eJGALgzrwd8gordIqfnD3tU+2s02R4Oxa2BlwrIU9nljACGZvc8dRwIddWdFWVItlFxM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes some spelling mistakes.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 Documentation/driver-api/mtdnand.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
index dcd63599f700..c55a6034c397 100644
--- a/Documentation/driver-api/mtdnand.rst
+++ b/Documentation/driver-api/mtdnand.rst
@@ -374,7 +374,7 @@ The nand driver supports three different types of hardware ECC.
 
 -  NAND_ECC_HW8_512
 
-   Hardware ECC generator providing 6 bytes ECC per 512 byte.
+   Hardware ECC generator providing 8 bytes ECC per 512 byte.
 
 If your hardware generator has a different functionality add it at the
 appropriate place in nand_base.c
@@ -889,7 +889,7 @@ Use these constants to select the ECC algorithm::
     #define NAND_ECC_HW3_512    3
     /* Hardware ECC 6 byte ECC per 512 Byte data */
     #define NAND_ECC_HW6_512    4
-    /* Hardware ECC 6 byte ECC per 512 Byte data */
+    /* Hardware ECC 8 byte ECC per 512 Byte data */
     #define NAND_ECC_HW8_512    6
 
 
-- 
2.14.4

