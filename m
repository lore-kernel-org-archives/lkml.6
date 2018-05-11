Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEKT06 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:26:58 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:48445 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEKT04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:26:56 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <ssantosh@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux-next PATCH 0/4] Enable network driver on K2G ICE and GP EVMs
Date: Fri, 11 May 2018 15:29:08 -0400
Message-ID: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that NetCP driver patches for K2G SoC is merged to linux-next master
this series add patches to enable network driver on K2G ICE and GP EVMs.

Thanks

Applied the patches on top of latest linux-next master, built kernel and
booted up on both EVMs. The logs are below

K2G GP EVM: https://pastebin.ubuntu.com/p/ycZDnZXYPx/
K2G ICE EVM: https://pastebin.ubuntu.com/p/bdCpzgdrXr/

Murali Karicheri (4):
  ARM: dts: k2g: add dt bindings to support network driver
  ARM: dts: keystone-k2g-evm: Enable netcp network driver
  ARM: dts: keystone-k2g-ice: Enable netcp network driver
  ARM: keystone: k2g: enable micrel and dp83867 phys

 arch/arm/boot/dts/keystone-k2g-evm.dts    |  53 +++++++++++
 arch/arm/boot/dts/keystone-k2g-ice.dts    |  59 ++++++++++++
 arch/arm/boot/dts/keystone-k2g-netcp.dtsi | 147 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi       |  13 +++
 arch/arm/configs/keystone_defconfig       |   2 +
 5 files changed, 274 insertions(+)
 create mode 100644 arch/arm/boot/dts/keystone-k2g-netcp.dtsi

-- 
1.9.1
