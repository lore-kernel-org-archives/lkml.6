Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeBZMV7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:21:59 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:26550 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752599AbeBZMV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:21:56 -0500
X-IronPort-AV: E=Sophos;i="5.47,396,1515423600";
   d="scan'208";a="272157570"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] arm: Support for Renesas RZ/N1D (R9A06G032)
Date: Mon, 26 Feb 2018 12:18:18 +0000
Message-Id: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the plain basic support for booting a bare
kernel on the RZ/N1D-DB Board. It's been trimmed to the strict
minimum as a 'base', further patches that will add the
rest of the support, pinctrl, clock architecture and quite
a few others.

Michel Pollet (2):
  arm: add basic support for Renesas RZ/N1 boards
  arm: rzn1: Add basic support for RZN1D-DB Board

 Documentation/devicetree/bindings/arm/shmobile.txt |   5 +-
 arch/arm/boot/dts/rzn1.dtsi                        |  94 +++
 arch/arm/boot/dts/rzn1d400-db.dts                  |  25 +
 arch/arm/mach-shmobile/Kconfig                     |   5 +
 arch/arm/mach-shmobile/Makefile                    |   1 +
 arch/arm/mach-shmobile/setup-r9a06g032.c           |  60 ++
 .../dt-bindings/interrupt-controller/rzn1-irq.h    | 137 ++++
 include/dt-bindings/soc/renesas,rzn1-map.h         | 173 +++++
 include/soc/rzn1/sysctrl.h                         | 736 +++++++++++++++++++++
 9 files changed, 1235 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rzn1.dtsi
 create mode 100644 arch/arm/boot/dts/rzn1d400-db.dts
 create mode 100644 arch/arm/mach-shmobile/setup-r9a06g032.c
 create mode 100644 include/dt-bindings/interrupt-controller/rzn1-irq.h
 create mode 100644 include/dt-bindings/soc/renesas,rzn1-map.h
 create mode 100644 include/soc/rzn1/sysctrl.h

-- 
2.7.4
