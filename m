Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeBDRys (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:54:48 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33968 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeBDRym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:54:42 -0500
X-Google-Smtp-Source: AH8x226BMXXxxepl47a4nSmTgvcXkwGv0zm85SnMMkQTNq6aCLgGuQrIlLX+eNhZ/+9XT6BquorLPw==
From: Jagan Teki <jagannadh.teki@gmail.com>
X-Google-Original-From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 0/7] ARM: dts: imx6q: engicam LVDS panel changes
Date: Sun,  4 Feb 2018 23:19:24 +0530
Message-Id: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series adda LVDS panel attributes on panel drivers instead of defining
them in dts nodes, and also added new icorem6 engicam boards.

Jagan Teki (7):
  drm/panel: simple: add support for Ampire AM-800480AYTZQW-00H
  ARM: dts: imx6q-icore: Switch LVDS timings from panel-simple
  ARM: dts: imx6dl-icore: Add LVDS node
  drm/panel: simple: Add support for KEO TX31D200VM0BAA
  ARM: dts: imx6q-icore-ofcap12: Switch LVDS timings from panel-simple
  ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 7
    initial support
  ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit
    support

 .../display/panel/ampire,am-800480aytzqw-00h.txt   | 25 +++++++++
 .../bindings/display/panel/koe,tx31d200vm0baa.txt  | 25 +++++++++
 arch/arm/boot/dts/Makefile                         |  2 +
 arch/arm/boot/dts/imx6dl-icore.dts                 | 28 ++++++++++
 arch/arm/boot/dts/imx6q-icore-mipi.dts             | 25 +++++++++
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts          | 31 ++++++-----
 arch/arm/boot/dts/imx6q-icore-ofcap7.dts           | 65 ++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-icore.dts                  | 31 ++++++-----
 arch/arm/boot/dts/imx6qdl-icore.dtsi               | 25 ++++++++-
 drivers/gpu/drm/panel/panel-simple.c               | 54 ++++++++++++++++++
 10 files changed, 282 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
 create mode 100644 arch/arm/boot/dts/imx6q-icore-mipi.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap7.dts

-- 
2.7.4
