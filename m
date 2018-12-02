Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2B6C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DBB20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DBB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbeLBLk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:40:29 -0500
Received: from shell.v3.sk ([90.176.6.54]:60723 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbeLBLk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 06:40:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1532CC7E44;
        Sun,  2 Dec 2018 12:40:24 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qnmHDXNwWRFV; Sun,  2 Dec 2018 12:40:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8494CC7E45;
        Sun,  2 Dec 2018 12:40:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6um-7Ug_nAlR; Sun,  2 Dec 2018 12:40:18 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 73BC3C7E44;
        Sun,  2 Dec 2018 12:40:18 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dt-bindings: arm: mrvl: amend Browstone compatible string
Date:   Sun,  2 Dec 2018 12:40:08 +0100
Message-Id: <20181202114008.2861-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Brownstone board is compatible with "mrvl,mmp2". The actual DTS
already contains the string -- add it to the binding doc as well.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/arm/mrvl/mrvl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Docume=
ntation/devicetree/bindings/arm/mrvl/mrvl.txt
index 117d741a2e4f..951687528efb 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
@@ -11,4 +11,4 @@ Required root node properties:
=20
 MMP2 Brownstone Board
 Required root node properties:
-	- compatible =3D "mrvl,mmp2-brownstone";
+	- compatible =3D "mrvl,mmp2-brownstone", "mrvl,mmp2";
--=20
2.19.1

