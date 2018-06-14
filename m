Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D9B7DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1BE208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jReTthJQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g0M8tkgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1BE208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755297AbeFNNiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:38:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754966AbeFNNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:38:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 637FE602FC; Thu, 14 Jun 2018 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528983495;
        bh=kv7A8EUY0ISbGmD6JDv1NIJgJK4TLybrOgM+jWbVN3g=;
        h=From:To:Cc:Subject:Date:From;
        b=jReTthJQhmq/rNyQE3eEbrk7IDPBsSm2ksEzXtECzE2MDu+M1lkoUxumPO4QrKxaj
         TVCFc0E5Jr5PzOg/ijFgzwtKKmNofTGsnhindYez/xcpSbmyoWWK4kPFZleBjo5Wiq
         KmAipR1lYv5+esLtyNjG0/5UwVcgmtTHL/ZuYxac=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5701A601D2;
        Thu, 14 Jun 2018 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528983494;
        bh=kv7A8EUY0ISbGmD6JDv1NIJgJK4TLybrOgM+jWbVN3g=;
        h=From:To:Cc:Subject:Date:From;
        b=g0M8tkggbkRZGR8tVmKrMgAEjN9LteXrgge5PGlbVLRg1mt+0sfKfVqkwdB+ej5+p
         FpXxZ2yYVhGaf+xiC+qVCFXZyir19rkCi2dqM5iJR5+1/kccKrRScG6K07v6oCoMt6
         c8VcphIplt/fAogFFuzkNW5PhzrRYEgi+vENTL4s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5701A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     dmaengine@vger.kernel.org, timur@codeaurora.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MAINTAINERS: Update email-id of Sinan Kaya
Date:   Thu, 14 Jun 2018 09:37:46 -0400
Message-Id: <1528983482-31028-1-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm no longer with QCOM. I am still interested in maintaining or reviewing
PCI/DMA engine patches. Update email-id to an active one.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44fb3a1..dd9bd2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11803,7 +11803,7 @@ S:	Supported
 F:	arch/hexagon/
 
 QUALCOMM HIDMA DRIVER
-M:	Sinan Kaya <okaya@codeaurora.org>
+M:	Sinan Kaya <okaya@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org
 L:	linux-arm-msm@vger.kernel.org
 L:	dmaengine@vger.kernel.org
-- 
2.7.4

