Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF7EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD0520840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Yi982F8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfAPVS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:18:57 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55570 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfAPVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p9YwQTMU1NIR8yBUcFCMZp55/LDbtWd+q7P/tUdebOU=; b=Yi982F8iB9nIPigVwYA7mn+hS
        Ejv8149tUJSxEApGTDCcgKHX6iCLWzvj76i13eCHjvPsSPRqWpu8fTcuhEXYbL88lTYJPcYdOVHvf
        oaAyYBPIM7QI5WQo6nRp6AJUMddQOX4cTsLnBCoRF4pTbnyvz6t8N5r1yA6oMDaAKIk8o=;
Received: from p200300ccfbcc8e007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbcc:8e00:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjsaG-0006J8-2N; Wed, 16 Jan 2019 22:18:48 +0100
Received: from andi by eeepc with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjsaE-0001fD-Ee; Wed, 16 Jan 2019 22:18:46 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     letux-kernel@openphoenux.org, johan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 4/6] dt-bindings: gnss: add w2sg0004 compatible string
Date:   Wed, 16 Jan 2019 22:18:10 +0100
Message-Id: <20190116211812.6337-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190116211812.6337-1-andreas@kemnade.info>
References: <20190116211812.6337-1-andreas@kemnade.info>
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

