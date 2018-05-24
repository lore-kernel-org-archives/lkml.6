Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968749AbeEXNNi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:13:38 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:20888 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935698AbeEXNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:13:32 -0400
From: Vitaly Andrianov <vitalya@ti.com>
To: <ssantosh@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vitalya@ti.com>, <m-karicheri2@ti.com>
Subject: [PATCH 0/3] Dts nodes for Keystone2 hw_rng driver
Date: Thu, 24 May 2018 09:12:15 -0400
Message-ID: <1527167538-29837-1-git-send-email-vitalya@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds dts nodes for Keystone2 hw_rng driver

Vitaly Andrianov (3):
  ARM: dts: k2hk: add dts node for k2hk hw_rng driver
  ARM: dts: k2l: add dts node for k2l hw_rng driver
  ARM: dts: k2e: add dts node for k2e hw_rng driver

 arch/arm/boot/dts/keystone-k2e-netcp.dtsi  | 20 ++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi  | 20 ++++++++++++++++++++
 3 files changed, 60 insertions(+)

-- 
2.7.4
