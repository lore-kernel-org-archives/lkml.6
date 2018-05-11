Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeEKKAY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:00:24 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60941 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeEKKAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:00:23 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, geert@glider.be, magnus.damm@gmail.com,
        robh+dt@kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: Draak: Enable HDMI input and VIN4
Date: Fri, 11 May 2018 11:59:59 +0200
Message-Id: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   this series enables HDMI input and VIN4 on R-Car D3 Draak board.

The Draak board has an HDMI input connected to an HDMI decoder that feeds
the VIN capture interface through its parallel video interface.

The series requires the just sent:
[PATCH 0/5] rcar-vin: Add support for digital input on Gen3

and enables image capture operations on D3 Draak board.

The series has been developed on top of media-master tree but applies cleanly
on top of latest renesas-driver.

Geert: would you like a topic branch for this series to be included in
renesas-drivers?

Patches for testing are available at:
git://jmondi.org/linux d3/media-master/driver
git://jmondi.org/linux d3/media-master/dts
git://jmondi.org/linux d3/media-master/test
git://jmondi.org/vin-tests d3

Thanks
    j

Jacopo Mondi (3):
  dt-bindings: media: rcar-vin: Add R8A77995 support
  arm64: dts: renesas: r8a77995: Add VIN4
  arm64: dts: renesas: draak: Describe HDMI input

 .../devicetree/bindings/media/rcar_vin.txt         |  1 +
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 68 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 11 ++++
 3 files changed, 80 insertions(+)

--
2.7.4
