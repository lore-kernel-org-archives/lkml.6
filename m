Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeDPKiN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:38:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42061 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbeDPKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:38:11 -0400
X-Google-Smtp-Source: AIpwx4+JcHOxeHUEKfF5cN6rp5v2qXQWS9ESqOh+Ob11i+NSBvU7fyd7s7y0EfV51EcTAxdDM62hOA==
Date: Mon, 16 Apr 2018 11:38:07 +0100
From: Lee Jones <lee.jones@linaro.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Backlight for v4.17
Message-ID: <20180416103807.opecjcesd3j26ujv@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Enjoy!

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/mfd-next-4.17

for you to fetch changes up to ea388d6cffd43d353f9c2b3d711953e7525c7d97:

  pwm-backlight: Add support for PWM delays proprieties. (2018-04-03 10:15:54 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Provide helpers to enable/disable backlight
   - Provide standard and devres versions OF find helpers

 - New Drivers
   - Add support for the Zodiac Inflight Innovations RAVE Supervisory Processor

 - New Functionality
   - Allow pwm-on/pwm-off delay to be specified via DT

 - Bug Fixes
   - Fix ordering of the power {en,dis}able and PWM {en,dis}able signals

----------------------------------------------------------------
Andrey Smirnov (2):
      backlight: Add RAVE SP backlight driver
      dt-bindings: backlight: Add binding for RAVE SP backlight driver

Enric Balletbo i Serra (3):
      pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.
      dt-bindings: pwm-backlight: Add PWM delay proprieties.
      pwm-backlight: Add support for PWM delays proprieties.

Lee Jones (1):
      Merge branch 'ib-backlight-drm-4.17' into ibs-for-backlight-merged

Meghana Madhyastha (3):
      video: backlight: Add helpers to enable and disable backlight
      video: backlight: Add of_find_backlight helper in backlight.c
      video: backlight: Add devres versions of of_find_backlight

 .../bindings/leds/backlight/pwm-backlight.txt      |  6 ++
 .../leds/backlight/zii,rave-sp-backlight.txt       | 23 ++++++
 drivers/video/backlight/Kconfig                    |  6 ++
 drivers/video/backlight/Makefile                   |  1 +
 drivers/video/backlight/backlight.c                | 73 +++++++++++++++++++
 drivers/video/backlight/pwm_bl.c                   | 28 ++++++--
 drivers/video/backlight/rave-sp-backlight.c        | 82 ++++++++++++++++++++++
 include/linux/backlight.h                          | 58 +++++++++++++++
 include/linux/mfd/rave-sp.h                        |  1 +
 include/linux/pwm_backlight.h                      |  2 +
 10 files changed, 276 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
 create mode 100644 drivers/video/backlight/rave-sp-backlight.c
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
