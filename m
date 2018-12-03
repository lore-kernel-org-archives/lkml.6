Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0663C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F54214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F54214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeLCLsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:48:45 -0500
Received: from shell.v3.sk ([90.176.6.54]:37944 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeLCLso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:48:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 909EAC8123;
        Mon,  3 Dec 2018 12:47:59 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7lCOIR_jgzxz; Mon,  3 Dec 2018 12:47:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E19DDC80DB;
        Mon,  3 Dec 2018 12:47:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wK8YimR0I27F; Mon,  3 Dec 2018 12:47:51 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A9D13C8131;
        Mon,  3 Dec 2018 12:47:50 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dt-bindings: marvell,mmp2: fix a typo in bindings doc
Date:   Mon,  3 Dec 2018 12:47:48 +0100
Message-Id: <20181203114748.637314-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial one, but it's annoying that copy & paste of the link
doesn't work.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/clock/marvell,mmp2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt b/D=
ocumentation/devicetree/bindings/clock/marvell,mmp2.txt
index af376a01f2b7..b0447d9896bc 100644
--- a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
+++ b/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
@@ -18,4 +18,4 @@ Required Properties:
 Each clock is assigned an identifier and client nodes use this identifie=
r
 to specify the clock which they consume.
=20
-All these identifier could be found in <dt-bindings/clock/marvell-mmp2.h=
>.
+All these identifier could be found in <dt-bindings/clock/marvell,mmp2.h=
>.
--=20
2.19.1

