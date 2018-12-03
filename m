Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A55C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6592E20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6592E20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeLCLsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:48:06 -0500
Received: from shell.v3.sk ([90.176.6.54]:37854 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeLCLsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:48:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E5787C80DB;
        Mon,  3 Dec 2018 12:47:20 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VOsIENeWdPVf; Mon,  3 Dec 2018 12:47:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7C587C811D;
        Mon,  3 Dec 2018 12:47:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f8gPwLCWhKw0; Mon,  3 Dec 2018 12:47:18 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id BCF0EC80DB;
        Mon,  3 Dec 2018 12:47:17 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dt-bindings: mrvl,intc: fix a trivial typo
Date:   Mon,  3 Dec 2018 12:47:10 +0100
Message-Id: <20181203114710.636840-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/whold/whole/.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/interrupt-controller/mrvl,intc.txt      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mrvl,=
intc.txt b/Documentation/devicetree/bindings/interrupt-controller/mrvl,in=
tc.txt
index 8b53273cb22f..608fee15a4cf 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.tx=
t
+++ b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.tx=
t
@@ -5,7 +5,7 @@ Required properties:
   "mrvl,mmp2-mux-intc"
 - reg : Address and length of the register set of the interrupt controll=
er.
   If the interrupt controller is intc, address and length means the rang=
e
-  of the whold interrupt controller. If the interrupt controller is mux-=
intc,
+  of the whole interrupt controller. If the interrupt controller is mux-=
intc,
   address and length means one register. Since address of mux-intc is in=
 the
   range of intc. mux-intc is secondary interrupt controller.
 - reg-names : Name of the register set of the interrupt controller. It's
--=20
2.19.1

