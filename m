Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6735EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ADB20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfAJRmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:42:18 -0500
Received: from shell.v3.sk ([90.176.6.54]:58368 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730613AbfAJRmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:42:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AB6C71002E4;
        Thu, 10 Jan 2019 18:42:13 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eajg9i4tldFI; Thu, 10 Jan 2019 18:42:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 58F761002E6;
        Thu, 10 Jan 2019 18:42:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1Vo3JjCo6LEr; Thu, 10 Jan 2019 18:42:03 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8EA851002E4;
        Thu, 10 Jan 2019 18:42:02 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v5 1/7] dt-bindings: olpc_battery: Add XO-1.5 battery
Date:   Thu, 10 Jan 2019 18:39:59 +0100
Message-Id: <20190110174005.1202564-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110174005.1202564-1-lkundrak@v3.sk>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XO-1 and XO-1.5 batteries apparently differ in an ability to report
ambient temperature.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v1:
- Collected Reviewed-by and Acked-by tags

 Documentation/devicetree/bindings/power/supply/olpc_battery.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/olpc_battery.=
txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
index c8901b3992d9..8d87d6b35a98 100644
--- a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
@@ -2,4 +2,4 @@ OLPC battery
 ~~~~~~~~~~~~
=20
 Required properties:
-  - compatible : "olpc,xo1-battery"
+  - compatible : "olpc,xo1-battery" or "olpc,xo1.5-battery"
--=20
2.20.1

