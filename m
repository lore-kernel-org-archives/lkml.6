Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935218AbeBMNCG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:02:06 -0500
Received: from mx.socionext.com ([202.248.49.38]:19014 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935077AbeBMNCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:02:04 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: alsa-devel@alsa-project.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v3 0/3] add UniPhier audio nodes
Date: Tue, 13 Feb 2018 22:01:53 +0900
Message-Id: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds device-tree nodes for Socionext audio system
for UniPhier LD11/LD20 SoCs. This one enables I2S output for
Line-In, Line-Out, S/PDIF output and compress audio output.

Katsuhiro Suzuki (3):
  arm64: dts: uniphier: add sound node for UniPhier
  arm64: dts: uniphier: add speaker out for UniPhier LD11/LD20 boards
  arm64: dts: uniphier: add compress audio out for UniPhier LD11/LD20

 .../boot/dts/socionext/uniphier-ld11-global.dts    | 62 ++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 92 +++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 62 ++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 96 ++++++++++++++++++++++
 4 files changed, 312 insertions(+)

-- 
2.15.1
