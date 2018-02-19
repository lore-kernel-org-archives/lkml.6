Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeBSNqM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:46:12 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54120 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbeBSNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:46:11 -0500
X-Google-Smtp-Source: AH8x226lo6eijxQkm9qrF/5jmuPVdZr6YmtV6nzqel2CSpl8SCKpzEV2wH3e63nADG91RHxChGFCGg==
From: Neil Armstrong <narmstrong@baylibre.com>
To: broonie@kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: Add support for max9759 Amplifier Driver
Date: Mon, 19 Feb 2018 14:45:56 +0100
Message-Id: <1519047958-22583-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX9759 is a gpio controlled speaker amplifier, this patchset
add the DT Bindings and the corresponding ASoC component driver.

Neil Armstrong (2):
  ASoC: Add DT bindings documentation for max9759 amplifier
  ASoC: max9759: Add Amplifier Driver

 .../devicetree/bindings/sound/maxim,max9759.txt    |  18 ++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/max9759.c                         | 207 +++++++++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt
 create mode 100644 sound/soc/codecs/max9759.c

-- 
2.7.4
