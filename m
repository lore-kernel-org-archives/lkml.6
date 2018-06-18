Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1270CC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB6920850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFV1B7Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB6920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964908AbeFRVPA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936896AbeFRVO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:14:59 -0400
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net [91.224.148.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6D62075A;
        Mon, 18 Jun 2018 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529356499;
        bh=8UPDtGwhNEeI6C/HLjB/9kM/2XtJU6Vzu+/BtBugoKA=;
        h=From:To:Cc:Subject:Date:From;
        b=XFV1B7Zx3rkN1GSLT0omnZCMGTBi1lVDCpCHauU1Vh+/EoNFmPufAsxpBlqxztFPG
         GQ5w+eXvxLn1Z52VtUbdEEmHbbYy/i92SqplVr0dOPNCUjfjvZlWUH6QykGP2X3422
         u1YY2sdphTqpi40IEfrxbwhM0AJ7Qsb+e5o4FAm0=
From:   ilia.lin@kernel.org
Cc:     Ilia Lin <ilia.lin@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update e-mail address for Ilia Lin
Date:   Mon, 18 Jun 2018 23:14:05 +0200
Message-Id: <20180618211421.12110-1-ilia.lin@kernel.org>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Lin <ilia.lin@kernel.org>

Change to the @kernel.org address

Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 035973b23b8b..15a836eebe9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11799,7 +11799,7 @@ F:	Documentation/media/v4l-drivers/qcom_camss.rst
 F:	drivers/media/platform/qcom/camss-8x16/
 
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
-M:  Ilia Lin <ilia.lin@gmail.com>
+M:  Ilia Lin <ilia.lin@kernel.org>
 L:  linux-pm@vger.kernel.org
 S:  Maintained
 F:  Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
-- 
2.11.0

