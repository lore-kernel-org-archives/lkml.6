Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED509C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C606521908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbeLULDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:03:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:36679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbeLULDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:03:13 -0500
Received: from macchiato.fritz.box ([84.118.159.3]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MRocn-1gyjJu2X85-00Syg4; Fri, 21
 Dec 2018 12:02:39 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] arm64: dts: marvell: mcbin: reserve PSCI area
Date:   Fri, 21 Dec 2018 12:02:33 +0100
Message-Id: <20181221110233.6074-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zRyIB963pI6upUvrodlqGvwwiPZivxiQcJKpCvOeDc5E1GeN502
 L4tENX1yShBjFgFeof4iM9XDwAD6YkCLzvY0IxGx2rIQo0kls4Lv95uRHpv9MW3sSK0vh0S
 /8CMfMwzlGI2xxELF4q3pY7esBkoXLQpFNJXDcgKpJ52kfVd2kCKSMwKtyl6DrJ9HQqcs20
 mCYu7lLjd/Hdps8AzWajg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pzCKXG/0C1E=:ztKAwScMcAlYBo0Be+EsUQ
 zi/5awDiHLHe6cV5fESMSM8eQg9py8X3u9nAaZYsI81HnfRxzEomxFmigqk6FJdvlrEPgh8wn
 jfB5wMOrW/mqrTBWz6im+AZaDPv1TV1c52L7dYEFxuxG+c7FwSNH+wcRCTME0ci0LXuoEAWPo
 +Xbzf5+4Eo6Q6I/aTxZkqkXxnJqZAWD+L+b34XsmQk0H4J6sKF99lOpzuJ3acRvhwCXBJ+ahp
 0o6yxZhrtvULh0+IYsCw1vyUnxax7XhVMEd6IaghAZpqYhOiBvpxTqcemdFcbwj2crAivGcvB
 /c5q8IgTOXfTVEs0LnUsUmkLmfiSsyOLYsj9a6adkDM6cToQWTIAMdg3+4tnGAsElB8UwbPfL
 hDCNYVqxR9jlVhyi+DnAfhjkyy66ljyEn4QcxdKxBXpBBw4pIJqfutEiWfB7hlEeQJOrdJGk/
 x04/QKaXDszitRgiXtzsTKyHsR0vgV5gqiSWxEbYfhiPj4IPc3UfcmK1ztIGQs53XIs65LTDS
 43GdfxYGOBk60VVnwNFnLCz3u8nJZ58YD2RzWTSPkIoGIWMH2V/b28FeEv/WkVYFsFvgurHn1
 MQj3JWpB0ZgkOauwQdWWY172gYjn6UYi38eDQ499UuH/ap4BaaOwNuQJWP1U0erkClUGp1UY6
 rVS8cEBDwshDHJ3VeUW0gGwsL4zPrr1qthVkT/g9yuHhUXjISwXopfWBWjbEXl7rOytmgGF52
 sl/HArBgj7Dc512c4D1jlichHN+/502y9m4Q4to7lMOZ5Y6Is9HJeUaJdO/SlcqS8cBrYWE2X
 I9fzOhhvb0EnNX4+ywyZERP/XRFhc4Knjgxc7hXaXgxXIuB9FNN0hPgecaHyIudyF8PVao3yr
 nRL97Gfq7Uf5A0qNA5lVcQH87PTZ4XzwChWdFddcw8oF+psHtOS3D5gUh1c++s
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
attempt to access it from Linux leads to an immediate crash.

So let's make the same memory reservation as the vendor kernel.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 56fa44860909..18df1a321b52 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -23,6 +23,17 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		psci_reserved: psci-area@4000000 {
+		reg = <0x0 0x4000000 0x0 0x200000>;
+		no-map;
+		};
+	};
+
 	aliases {
 		ethernet0 = &cp0_eth0;
 		ethernet1 = &cp1_eth0;
-- 
2.19.2

