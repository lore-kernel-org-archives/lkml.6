Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C82DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714BF206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfBWRjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:39:48 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:42359 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfBWRjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 12:39:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D41F8FB06;
        Sat, 23 Feb 2019 18:39:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jOsphWJCBcG8; Sat, 23 Feb 2019 18:39:44 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 16AFE414A0; Sat, 23 Feb 2019 18:39:44 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] drm/panel: Support Rocktech jh057n00900 DSI panel
Date:   Sat, 23 Feb 2019 18:39:41 +0100
Message-Id: <cover.1550943220.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a 5.5" 720x1440 TFT LCD MIPI DSI panel with built in touchscreen and
backlight as found in the Librem 5 devkit.

These patches are against linux next as of 2019-02-08.


Guido Günther (3):
  dt-bindings: Add vendor prefix for ROCKTECH DISPLAYS LIMITED
  dt-bindings: Add Rocktech jh057n00900 panel bindings
  drm/panel: Add Rocktech jh057n00900 panel driver

 .../display/panel/rocktech,jh057n00900.txt    |  18 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-rocktech-jh057n00900.c    | 414 ++++++++++++++++++
 5 files changed, 446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
 create mode 100644 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c

-- 
2.20.1

