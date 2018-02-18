Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeBRRCf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:02:35 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33954 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeBRRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:02:32 -0500
X-Google-Smtp-Source: AH8x227qT2dzZ7YiKfq56Z+W0098fiDp1kv00MA24roolyNddo6jY+EadGqEb58iz4aEKQCHLIdoKQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Enable Video Decoder on Tegra30
Date: Sun, 18 Feb 2018 20:01:44 +0300
Message-Id: <cover.1518973069.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VDE on Terga30 is compatible with VDE on Tegra20, hence the 'tegra-vde'
driver works fine on Terga30. Let's add missing DT nodes to expose Video
Decoder Engine on Terga30.

Dmitry Osipenko (2):
  ARM: dts: tegra30: Add IRAM node
  ARM: dts: tegra30: Add video decoder node

 arch/arm/boot/dts/tegra30.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.16.1
