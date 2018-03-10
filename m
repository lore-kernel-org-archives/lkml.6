Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeCJLFZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 06:05:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37797 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeCJLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 06:05:24 -0500
X-Google-Smtp-Source: AG47ELvgJB+8UlhrhOQygh9YxnKqbAGbwD66e9uF4iAI7t6MLvXa91RpCtxhG0En6MGyp0AmCgVXag==
From: Neil Armstrong <narmstrong@baylibre.com>
To: broonie@kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/2] ASoC: Add support for max9759 Amplifier Driver
Date: Sat, 10 Mar 2018 12:05:14 +0100
Message-Id: <1520679916-13517-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX9759 is a gpio controlled speaker amplifier, this patchset
add the DT Bindings and the corresponding ASoC component driver.

Changes with resend :
 - Add rob ack on bindings

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
