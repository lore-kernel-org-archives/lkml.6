Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BB8C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE30D20842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfAMQPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 11:15:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:40503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfAMQPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 11:15:23 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBIAz-1gahfo0DrR-00AGtc; Sun, 13
 Jan 2019 17:15:05 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: a64: Fix a typo
Date:   Sun, 13 Jan 2019 17:14:13 +0100
Message-Id: <20190113161413.14654-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CK/EgY7EQx0Q4QI163sRiEttrNT3KpYgbe/wDTjbcIbVQ2v6VFf
 3YYkR2Nw5dDEFGuxwdm0eZ/5fgtF4ryRV1TYQLCR7UN8q4yWQs7qFo+13/5B/bzL9KqImum
 2rmMnGZ8FoyL+bbMq0xNiYqhBDp5ukT7IWXRdxN2rDnYx/RIbJer7SP6s7SGfAUaYZMEvKP
 UzjP3blBT5m+ucMx0LzTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k4EH+YnfaTw=:wtJgbtrL8NI1HOf9ahbVVc
 jjKpRWQiDFNheW+WHtFGZiqy4UvipEXbP77li/AbciTu2F7zVOtvw8EqTzIwRAFlnY5IRVh9j
 MRIZmpmhmB3YyfVGGvwxBfpfJzdARM4Bqx1hoKcpYrm+5uhUC5fv7hWgTgZo3XiWzGhNoCaVY
 tGLhXOxfoXC6o4VwcCo6i5KfZOACn9IhQwMaxyt+bcyxHATEUqqumq37lJkw7uJn1ZqcXDO0U
 uAYE70fKuvif0roa11XrPnQdRq0P0r89BVc8V9c/tNxFT3blizJQSxiNPbAgyGIWumXFaBjfd
 LpjAHUmg+mxF06UMhodm9QimsYPqcrLmfESXTgrzEgsO/kWNIClNKkgJ+77gRg/CVcO6Yo1IG
 oBBRtTyqS+3nV4YFqhbR5J84cApliXLuBkXsAAsM5ZhZuixfNKDByOoHP8yphPfVapdzCEMM1
 t7odH6RFSeHN7BCz8+rOjrvxk26GVBiTkvzO30v4agC7QbLG18q5OI3dh9ASf5ayFAX9gcE07
 nNBL779ZDqZCIGGzlVLI1zoF/bRykcco6Pt94a+0r00Z+pfkfntr0rUBow3ELCzcWAyPaaNEP
 tMyRfsw2KMpWT0w6zMiCGT7uBzhIGcMXeLdM3ElFP0vIA7BkbHYPG05B4tOFNq/BKMKsNDJlA
 gn4t7KPjy6mu921Y4PnrihRJyI+6so2ueG0SEBTqHxI+b1kfdPL7TCs29b3xz9NTLZYQSeJRN
 XZycmvLptAIwx2AwjCjKjqBg3G+aFWpc7OkFwyru8uIhUpWYMHzeR5G7ZLXPLksK88C9seXN8
 BHurpniVkb89ZKomPZ6a9nAw2yIeCR8O8Y24l1GsDgFRYB7GHQ10HOOxj8sIi+vBr9KHCoY3i
 6U2SBXamkODvET6VN2HguFhF2nIaJu8azP5WfA/+Y+v+eWWncD7gS5mkKMWUi9vr3P2ZirBjz
 W/ws8sTV0aQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This typo inverted the meaning of the comment, but the rest of the
comment and the code reveal that the regulator in question needs to be
on at all times.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index c455b24dd079..f9eede0a8bd3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -239,7 +239,7 @@
 };
 
 /*
- * The A64 chip cannot work without this regulator off, although
+ * The A64 chip cannot work with this regulator off, although
  * it seems to be only driving the AR100 core.
  * Maybe we don't still know well about CPUs domain.
  */
-- 
2.20.1

