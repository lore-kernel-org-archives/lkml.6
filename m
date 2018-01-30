Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeA3U6p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:58:45 -0500
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:37878 "EHLO
        1.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbeA3U6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:58:44 -0500
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v6 05/11] PCI: Add vendor ID for Cadence
Date: Tue, 30 Jan 2018 21:56:53 +0100
Message-Id: <2e97970574b6526739805a59a6f59649946bb1c7.1517343502.git.cyrille.pitchen@free-electrons.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
References: <cover.1517343502.git.cyrille.pitchen@free-electrons.com>
X-Ovh-Tracer-Id: 15889262437752526849
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 25
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrtddtgdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucgotffhvedqqdfjughrqdfuuhhsphgvtghtqdhlohifucdlhedmnegotffhvedqqdfjughrqdfuuhhsphgvtghtucdlvddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new PCI vendor ID for Cadence.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ab20dc5db423..eb13e84e1fef 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2381,6 +2381,8 @@
 
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
+#define PCI_VENDOR_ID_CDNS		0x17cd
+
 #define PCI_VENDOR_ID_ARECA		0x17d3
 #define PCI_DEVICE_ID_ARECA_1110	0x1110
 #define PCI_DEVICE_ID_ARECA_1120	0x1120
-- 
2.11.0
