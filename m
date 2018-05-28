Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423245AbeE1LGU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423219AbeE1LGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.16 019/272] ahci: Add PCI ID for Cannon Lake PCH-LP AHCI
Date: Mon, 28 May 2018 12:00:52 +0200
Message-Id: <20180528100242.047094687@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 4544e403eb25552aed7f0ee181a7a506b8800403 upstream.

This one should be using the default LPM policy for mobile chipsets so
add the PCI ID to the driver list of supported revices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -334,6 +334,7 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_mobile }, /* Lynx LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_mobile }, /* Lynx LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_mobile }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_mobile }, /* Cannon Lake PCH-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
