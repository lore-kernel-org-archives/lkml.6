Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEPPwQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:52:16 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:40019 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeEPPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:52:15 -0400
X-Google-Smtp-Source: AB8JxZqvLnYlJY2NipvcfUJmXAaZVlq9POnhAbQLkrGWr2EFahiSR5T9F62yivcHgDWYKuAok4ek8A==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM64: dts: meson-axg: i2c clean-up
Date: Wed, 16 May 2018 17:52:01 +0200
Message-Id: <20180516155203.24922-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes a few problems found in the i2c nodes of
amlogic's meson-axg paltform.

Jerome Brunet (2):
  ARM64: dts: meson-axg: clean-up i2c nodes
  ARM64: dts: meson-axg: remove incorrect i2c ao clock

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 42 ++++++++++++++----------------
 1 file changed, 19 insertions(+), 23 deletions(-)

-- 
2.14.3
