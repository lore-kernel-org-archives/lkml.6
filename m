Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69722FC619B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FC220861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfATR0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:26:06 -0500
Received: from shell.v3.sk ([90.176.6.54]:47312 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfATR0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:26:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 416CAC9AF5;
        Sun, 20 Jan 2019 18:26:01 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id t9cD5hwL4gzu; Sun, 20 Jan 2019 18:25:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BCCD7C9B0A;
        Sun, 20 Jan 2019 18:25:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OmAW_8lK53oR; Sun, 20 Jan 2019 18:25:51 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9A218C9AB8;
        Sun, 20 Jan 2019 18:25:51 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/6] dt-bindings: display: armada: Rename the binding doc file
Date:   Sun, 20 Jan 2019 18:25:29 +0100
Message-Id: <20190120172534.24617-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190120172534.24617-1-lkundrak@v3.sk>
References: <20190120172534.24617-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's going to document more than just marvell,dove-lcd: more components
of the display subsystems with more compatible strings.

It seems to make sense to organize this the way it is done in
Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../armada/{marvell,dove-lcd.txt =3D> marvell-armada-drm.txt}       | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/display/armada/{marvell,dove-lc=
d.txt =3D> marvell-armada-drm.txt} (100%)

diff --git a/Documentation/devicetree/bindings/display/armada/marvell,dov=
e-lcd.txt b/Documentation/devicetree/bindings/display/armada/marvell-arma=
da-drm.txt
similarity index 100%
rename from Documentation/devicetree/bindings/display/armada/marvell,dove=
-lcd.txt
rename to Documentation/devicetree/bindings/display/armada/marvell-armada=
-drm.txt
--=20
2.20.1

