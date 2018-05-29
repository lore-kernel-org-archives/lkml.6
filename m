Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeE2KOI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:14:08 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:32946 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932866AbeE2KOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:14:05 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com,
        linux@roeck-us.net, avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] hwmon: Add NPCM7xx PWM driver support
Date: Tue, 29 May 2018 13:02:19 +0300
Message-Id: <1527588141-18639-1-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds Pulse Width Modulation (PWM) support 
for the Nuvoton NPCM7xx Baseboard Management Controller (BMC).

The NPCM7xx PWM controller can support 8 PWM output ports.

The hwmon driver provides sysfs entries through which the user can 
configure and get the duty cycle between 0 (disable the specific PWM) 
to 255 of particular PWM output port.

The NPCM7xx PWM driver tested on NPCM750 evaluation board.

Tomer Maimon (2):
  dt-binding: hwmon: Add NPCM7xx PWM documentation
  hwmon: npcm-pwm: add NPCM7xx PWM driver

 .../devicetree/bindings/hwmon/npcm7xx-pwm.txt      |  25 ++
 drivers/hwmon/Kconfig                              |   6 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/npcm7xx-pwm.c                        | 363 +++++++++++++++++++++
 4 files changed, 395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/npcm7xx-pwm.txt
 create mode 100644 drivers/hwmon/npcm7xx-pwm.c

-- 
2.14.1
