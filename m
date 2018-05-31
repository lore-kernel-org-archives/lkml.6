Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754596AbeEaU0R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:26:17 -0400
Received: from vern.gendns.com ([206.190.152.46]:41415 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754522AbeEaU0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:26:14 -0400
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: LEGO MINDSTORMS EV3 Bluetooth support
Date: Thu, 31 May 2018 15:25:47 -0500
Message-Id: <20180531202549.11255-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds Bluetooth support to LEGO MINDSTORMS EV3.

The pwm-clock depends on the common clock framework, so this requires the
recent davinci common clock series to switch to the common clock framework
before it will actually work.

David Lechner (2):
  ARM: dts: da850-lego-ev3: Add Bluetooth nodes
  ARM: davinci_all_defconfig: Enable Bluetooth

 arch/arm/boot/dts/da850-lego-ev3.dts   | 82 ++++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig |  9 +++
 2 files changed, 91 insertions(+)

-- 
2.17.0
