Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeFEJWX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:22:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47892 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeFEJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:22:19 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Tony Luck <tony.luck@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paolo Cretaro <paolocretaro@gmail.com>, linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        linux-rtc@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/9] croc_ec: Switch to SPDX identifier
Date: Tue,  5 Jun 2018 11:22:00 +0200
Message-Id: <20180605092209.22887-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This patchset is just to adopt the SPDX license identifier for all
ChromeOS Embedded Controller related drivers. The patches touches
different subsystems but every patch can be picked from their respective
maintainer independently.

Thanks,
 Enric

Enric Balletbo i Serra (9):
  platform/chrome: cros_ec: Switch to SPDX identifier.
  platform/chrome: pstore: Switch to SPDX identifier.
  mfd: cros_ec: Add or fix SPDX-License-Identifier in all files.
  iio: cros_ec: Switch to SPDX identifier.
  rtc: cros-ec: Switch to SPDX identifier.
  Input: cros_ec_keyb - Switch to SPDX identifier.
  pwm: cros-ec: Switch to SPDX identifier.
  extcon: usbc-cros-ec: Switch to SPDX identifier.
  i2c: i2c-cros-ec-tunnel: Switch to SPDX identifier.

 drivers/extcon/extcon-usbc-cros-ec.c          | 20 ++++----------
 drivers/i2c/busses/i2c-cros-ec-tunnel.c       | 14 +++-------
 drivers/iio/accel/cros_ec_accel_legacy.c      | 23 ++++------------
 .../common/cros_ec_sensors/cros_ec_sensors.c  | 24 +++++------------
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 18 +++----------
 .../cros_ec_sensors/cros_ec_sensors_core.h    | 12 ++-------
 drivers/iio/light/cros_ec_light_prox.c        | 18 +++----------
 drivers/iio/pressure/cros_ec_baro.c           | 18 +++----------
 drivers/input/keyboard/cros_ec_keyb.c         | 26 +++---------------
 drivers/mfd/cros_ec.c                         | 27 +++++++------------
 drivers/mfd/cros_ec_dev.c                     | 24 +++++------------
 drivers/mfd/cros_ec_dev.h                     | 16 ++---------
 drivers/mfd/cros_ec_i2c.c                     | 19 ++++---------
 drivers/mfd/cros_ec_spi.c                     | 21 +++++----------
 drivers/platform/chrome/chromeos_pstore.c     | 13 +++------
 drivers/platform/chrome/cros_ec_debugfs.c     | 22 +++------------
 drivers/platform/chrome/cros_ec_lightbar.c    | 22 +++------------
 drivers/platform/chrome/cros_ec_lpc.c         | 26 +++---------------
 drivers/platform/chrome/cros_ec_lpc_mec.c     | 26 +++---------------
 drivers/platform/chrome/cros_ec_lpc_reg.c     | 26 +++---------------
 drivers/platform/chrome/cros_ec_proto.c       | 19 +++----------
 drivers/platform/chrome/cros_ec_sysfs.c       | 22 +++------------
 drivers/platform/chrome/cros_ec_vbc.c         | 24 ++++-------------
 .../platform/chrome/cros_kbd_led_backlight.c  | 19 +++----------
 drivers/pwm/pwm-cros-ec.c                     | 13 +++------
 drivers/rtc/rtc-cros-ec.c                     | 21 ++++-----------
 include/linux/mfd/cros_ec.h                   | 10 +------
 include/linux/mfd/cros_ec_commands.h          | 10 +------
 include/linux/mfd/cros_ec_lpc_mec.h           | 12 ++-------
 include/linux/mfd/cros_ec_lpc_reg.h           | 12 ++-------
 30 files changed, 123 insertions(+), 454 deletions(-)

-- 
2.17.1
