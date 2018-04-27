Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932432AbeD0I42 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:56:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34459 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbeD0I40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:56:26 -0400
X-Google-Smtp-Source: AB8JxZr3GKYqfQnu5mfeiDg3PzKE1Moo/x/1NZHIAZ22p1RaVE2aTXEc/Swou9c0k4W7Gg2BLjMoKw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jikos@kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 14:26:08 +0530
Message-Id: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Arvind Yadav (3):
  [PATCH 1/3] ASoC: tlv320dac33: Use gpio_is_valid()
  [PATCH 2/3] ASoC: tpa6130a2: Use gpio_is_valid()
  [PATCH 3/3] ASoC: samsung: Use gpio_is_valid()

 sound/soc/codecs/tlv320dac33.c     | 10 +++++-----
 sound/soc/codecs/tpa6130a2.c       |  8 ++++----
 sound/soc/samsung/s3c24xx_simtec.c | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

-- 
1.9.1
