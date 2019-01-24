Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE51C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2475721872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Fmb8Oa/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfAXGe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:34:59 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:48654 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfAXGe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p9YwQTMU1NIR8yBUcFCMZp55/LDbtWd+q7P/tUdebOU=; b=Fmb8Oa/MdSIPDNRU4UINEBKya
        HQHXhOy+VwRyVhc+NffCtar1TB0uMnDmCRipu6Tskzz/FTeYp8k9S8/B0TDJbaOurt3A63mOXeItW
        1JpYlCe68V9fbwWcc2dRvd7v5pdn+q6bGDBpmujEziKoR7FdxsVMO1vKoxATAT7VPaY24=;
Received: from [77.247.85.78] (helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYb9-0000uo-57; Thu, 24 Jan 2019 07:34:47 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gmYb7-0007rR-Bo; Thu, 24 Jan 2019 07:34:45 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 3/5] dt-bindings: gnss: add w2sg0004 compatible string
Date:   Thu, 24 Jan 2019 07:34:37 +0100
Message-Id: <20190124063439.29897-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190124063439.29897-1-andreas@kemnade.info>
References: <20190124063439.29897-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add w2sg0004 compatible string since devices without wakeup
pins are now supported.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
 Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.txt b/Documentation/devicetree/bindings/gnss/sirfstar.txt
index 648d183cdb77..f4252b6b660b 100644
--- a/Documentation/devicetree/bindings/gnss/sirfstar.txt
+++ b/Documentation/devicetree/bindings/gnss/sirfstar.txt
@@ -12,6 +12,7 @@ Required properties:
 
 			"fastrax,uc430"
 			"linx,r4"
+			"wi2wi,w2sg0004"
 			"wi2wi,w2sg0008i"
 			"wi2wi,w2sg0084i"
 
-- 
2.11.0

