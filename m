Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeDFNIb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:08:31 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33361 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeDFNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:08:30 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        laurent.pinchart@ideasonboard.com, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge
Date: Fri,  6 Apr 2018 15:08:05 +0200
Message-Id: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   this series enables HDMI display on V3M Eagle board.

The series is based on Geert's "renesas-drivers-2018-04-03-v4.16" with
THC63LVD1024 driver on top (cfr. my in review series:
"[PATCH v7 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge")

This series includes some preliminary work from Sergei and Niklas. I have
reworked the two final patches from Niklas to enable DU first, add the LVDS
decoder node, and finally add the ADV7511W chip and enable HDMI output.

A branch for testing is available at:
git://jmondi.org/linux v3m/renesas-drivers-2018-04-03-v4.16/v7-eagle-dts

Thanks
   j

Jacopo Mondi (2):
  arm64: dts: renesas: eagle: Enable DU
  arm64: dts: renesas: eagle: Add LVDS decoder

Niklas Söderlund (2):
  arm64: dts: renesas: r8a77970: add the LVDS instance
  arm64: dts: renesas: eagle: Add ADV7511W and HDMI output

Sergei Shtylyov (3):
  arm64: dts: renesas: r8a77970: add FCPVD support
  arm64: dts: renesas: r8a77970: add VSPD support
  arm64: dts: renesas: r8a77970: add DU support

 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 89 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77970.dtsi      | 73 +++++++++++++++++++++
 2 files changed, 162 insertions(+)

--
2.7.4
