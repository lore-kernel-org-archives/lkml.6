Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1740BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD14020882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD14020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbeGWNi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:57 -0400
Received: from mout.perfora.net ([74.208.4.196]:49737 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbeGWNi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:56 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MgMca-1fKyle18cA-00NicF; Mon, 23 Jul 2018 14:37:48 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 21/26] ARM: tegra: colibri_t30: remove unused nvidia,is-wired property
Date:   Mon, 23 Jul 2018 14:36:52 +0200
Message-Id: <20180723123658.980-22-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:uWQMLszLk+Kjs1Fy83QJiXRoo0LmJK2H8Tx5Er2xjOnBNzZQtwx
 vXH2nUcLcOLyiwJyOO9rSjNdCeBfSVcRvVi4ZY3AlvYmo3zYeJkZAzrEpPDmWu27eEv0j5A
 m5TumnNfry5EGeyeM+LdHJ380j2xCk1u6Hp+0j/vRIYlAlnLz7WEjnN7CcrZbfxCrb2VVy5
 EfrpIsNj0djWU77+GTlKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BoAoL/6Zyhg=:x8oqK7bJ5tlT3kInN88ge4
 4Om8yGMDAHr7+QhQl+wCYP5ZrPRrqDWDj5rr2/X492wS6MnFqts16K0JI6bF+uYwsmPLBwLdK
 LKkJJq9DPjGjNe63DelPYPue7TxQAzzhuY9aqXrl5Q0J3Y/NywV9Naq7G/6BHyAdAYwgKlj60
 xoZ9Iab9en7kCAd70Cb/3UvGAqUDoakhRYFgaGXiwF+cHccWEJFeKS0c+vwBaKJUS5iIpXT7a
 1OcfntU1BKl6cdAE37JMKs3DJt9Eco5pw/UUQpOHu7uOhNFD64kNXW/9KaqUqv/QsebeEfih0
 /Jlp7vi6ekQDqzp+AUN51cpOBZ/wHZVy34vUBl8kF4EdkiBjaQ6Unx1/7IJvcOTkR0oQeiEg3
 jd37TVvUvN7rLgsJY8r8rWyQS8ruwAuCexfeHQWGfkvbYCEDIp/Dg7snVNhX7BXrZULw77vWK
 3AR5e5wKVklzDWKWZukmMppwfMOgTDf7xO7Kcqj9tz8q6IueV41EyismJbAqKfkwcwgEydILY
 8x2yVjCodzu8bVZxTNPONKmtWDZC2xCVHo2f5lN3DaDZ5HnZE5JUTWWQ+Np0de+oKrBUkT/nf
 iYHhoRnwYBddA/OPyQkCiKqa8P482qbCWLCeQbQxBEdeH6bDzjBcOSkEPCIsLrIi+NkYabYLQ
 TLpWikZ/imfbU6dYq+TpvfbY4+JTzVO+rNPYzd8T8F+4Roo977+LnbJdhT/5sqAztqPI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Remove unused nvidia,is-wired property.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 211457ea0b72..e32109475bc8 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -949,7 +949,6 @@
 
 	usb-phy@7d004000 {
 		status = "okay";
-		nvidia,is-wired = <1>;
 		vbus-supply = <&reg_lan_v_bus>;
 	};
 
-- 
2.14.4

