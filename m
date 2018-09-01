Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F47C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F7620843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F7620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIARRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:43 -0400
Received: from mout.perfora.net ([74.208.4.196]:37925 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeIARRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:43 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MXoiP-1gRpMF0jup-00Wnof; Sat, 01 Sep 2018 15:05:36 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 11/19] ARM: tegra: apalis-tk1: add toradex,apalis-tk1-v1.2 compatible
Date:   Sat,  1 Sep 2018 15:04:56 +0200
Message-Id: <20180901130504.14318-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:HNKWECbJbq87zeBcFzB9H/Ay+4YdxVSi8fiVw9aCaOCBjueih8U
 M4UqSpkE5suJzH+7YC1oGX8CWfkBA4cXRw7OSJKgezQbXocsKPlXquhYUkcoHOkIRYm/eTH
 iD5mbSrw1OVPdBwX1NmuXyuYX5ywzLfPpGF8QZzpCkkt26ulR8kOw91ex94mdFemT2hd8JT
 xTpW8vVbEeeKYe/rNRLHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wm9C72MJqms=:EF9agwJNv7g5oCpyrP4KWF
 0dxEPqZRbxdj1ZPTpCaZbni+y1m0Rx7ZiAX/c14H5RORT8pU5jqx43sAZdbgitTfuQHpoVe2M
 Ycca0r3ZE4py3kq5dM0xw4UtoVnK1Cp2AyIf8RQgWLHy6aK7Q2inq0Km6ottkrT3b/9U/C3JJ
 N6Pa6bajkYm+RrmfTedf9gTSLkF7SakZ1TeEeLNBQnlWDdAerFvm435ZvT7D/hhOsJvjskKbi
 Y4j8cW3VdCPzk7RV/LJUiH6QDB7fMgljmMk6b81+lRnMHe8cLXuEbNiLJ9Gt6eI77MtBDWmnY
 FkcM7kyJbQfY4D+sio/kH5DV3eQu5kbzF0aV1xThwlQHIi+K4FZ0jCBNbbmBtcnSqXFGnlBYL
 V4Wu3ZOcibk6VjlaFYJCw4A29xy+pC2Z72NfaAyA3sbzdQFPaU4r/SkSlYYi/xL8JO2p7Mkn4
 H9AURZVKW51lyaU1j4vhZO/u6Ci8wxNvPMZ8bnTKnly0b6ga5WYdp7Cx/g/DuXNJwPHTRcro0
 WOJnfDRU8CLgPm0Tjcqn5kByULBR7SJ+bKcX3O5WABpdRU9O6H7BLKQYq5mh4zHFb4AnVq7Jp
 M3ub6h/VZXKH4Xbngx3cIo3RFJkwE5y61i9b5C8jWXBEctbzLjf9sdSh36R03SnU5e6PwhkU1
 J7XF/EBN9P9+dGj+Qa0Z0JeWj0bQ57jJhUihtq70e7GwJZNPxGrkXrtx26nNHopKJuN0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add toradex,apalis-tk1-v1.2 compatible.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v2:
- Add Rob's reviewed-by.

 Documentation/devicetree/bindings/arm/tegra.txt | 2 ++
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index 1073a5e66122..1c90cb32da19 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -51,6 +51,8 @@ board-specific compatible values:
   toradex,apalis_t30-v1.1-eval
   toradex,apalis-tk1
   toradex,apalis-tk1-eval
+  toradex,apalis-tk1-v1.2
+  toradex,apalis-tk1-v1.2-eval
   toradex,colibri_t20-512
   toradex,colibri_t30
   toradex,colibri_t30-eval-v3
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index aafaf2c3e195..89783fe76f65 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -11,7 +11,8 @@
 / {
 	model = "Toradex Apalis TK1 on Apalis Evaluation Board";
 	compatible = "toradex,apalis-tk1-v1.2-eval", "toradex,apalis-tk1-eval",
-		     "toradex,apalis-tk1", "nvidia,tegra124";
+		     "toradex,apalis-tk1-v1.2", "toradex,apalis-tk1",
+		     "nvidia,tegra124";
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-- 
2.14.4

