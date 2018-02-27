Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeB0WwC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:52:02 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:34684 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeB0WwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:52:00 -0500
X-Google-Smtp-Source: AG47ELuTWoce3YgBlbEzjgwVhEEe7vNfAgSegJwFiMvrmaqAA5X1Nhzfue3L1xv096NQ+lGKb4CYng==
From: Matt Porter <mporter@konsulko.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] TDA7419 audio processor driver
Date: Tue, 27 Feb 2018 17:51:26 -0500
Message-Id: <20180227225128.17815-1-mporter@konsulko.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an ASoC component driver for the ST TDA7419 audio
processor which is commonly used in automotive audio applications.
The datasheet can be found at
http://www.st.com/resource/en/datasheet/tda7419.pdf

Matt Porter (2):
  ASoC: add tda7419 audio processor binding
  ASoC: add tda7419 audio processor driver

 .../devicetree/bindings/sound/tda7419.txt          |  15 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda7419.c                         | 571 +++++++++++++++++++++
 4 files changed, 594 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt
 create mode 100644 sound/soc/codecs/tda7419.c

-- 
2.11.0
