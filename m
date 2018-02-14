Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030290AbeBNOKe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:10:34 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:46891 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030291AbeBNOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:10:29 -0500
X-Google-Smtp-Source: AH8x227gfKgsngWjM1SwCzRokbDR7ePBhOWWcHltws46IIa4kxsb8pgpEeUf9pN+XsJyLHU6Rm4sZw==
From: Philipp Rossak <embed3d@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v2 0/2] Fix broken bananapi m2 devicetree/regulators
Date: Wed, 14 Feb 2018 15:10:23 +0100
Message-Id: <20180214141025.22171-1-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchseries fixes the bananapi m1 devicetree, to be able to boot again.
The first two patches update/improve the devicetree and the last patch adds
all missing regulators.

Regards,
Philipp

Changes since v1:
	* squashed commit 1 and 3
	* fix wrong mmc regulator

Philipp Rossak (2):
  arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
  arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators

 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 63 ++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

-- 
2.11.0
