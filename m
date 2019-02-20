Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63094C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3970E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfBTD6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:58:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfBTD6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:58:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C239B0ADF;
        Wed, 20 Feb 2019 03:58:49 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-32.phx2.redhat.com [10.3.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EAAD607D5;
        Wed, 20 Feb 2019 03:58:48 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] MAINTAINERS: add linux-security-module mailing list to TPM drivers
Date:   Tue, 19 Feb 2019 20:58:46 -0700
Message-Id: <20190220035846.6272-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 20 Feb 2019 03:58:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen requests to add linux-security-module to tpm patch
submissions a couple of times recently, so just add the list
to MAINTAINERS so get_maintainers.pl will mention it.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41ce5f4ad838..cd0a3aecba65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15477,6 +15477,7 @@ M:	Peter Huewe <peterhuewe@gmx.de>
 M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
 R:	Jason Gunthorpe <jgg@ziepe.ca>
 L:	linux-integrity@vger.kernel.org
+L:	linux-security-module@vger.kernel.org
 Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
 T:	git git://git.infradead.org/users/jjs/linux-tpmdd.git
-- 
2.20.1.98.gecbdaf0899

