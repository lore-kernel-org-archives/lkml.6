Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA31120868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA31120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLAGiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:38:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:46972 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAGiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:38:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 11:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="279426260"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.241.225.27])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2018 11:27:41 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Joshua Kinard <kumba@gentoo.org>,
        linux-mips@linux-mips.org (open list:MIPS)
Subject: [PATCH RFC 01/15] MIPS: replace **** with a hug
Date:   Fri, 30 Nov 2018 11:27:10 -0800
Message-Id: <20181130192737.15053-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to comply with the CoC, replace **** with a hug.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/mips/pci/ops-bridge.c      | 24 ++++++++++++------------
 arch/mips/sgi-ip22/ip22-setup.c |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/pci/ops-bridge.c b/arch/mips/pci/ops-bridge.c
index a1d2c4ae0d1b..c755c4c92fa9 100644
--- a/arch/mips/pci/ops-bridge.c
+++ b/arch/mips/pci/ops-bridge.c
@@ -56,7 +56,7 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at it for real ...
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
@@ -76,7 +76,7 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 oh_my_gawd:
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
@@ -85,7 +85,7 @@ static int pci_conf0_read_config(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
+	 * IOC3 is hugging hugged beyond belief ...  Don't try to access
 	 * anything but 32-bit words ...
 	 */
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
@@ -118,7 +118,7 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at it for real ...
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
@@ -139,7 +139,7 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 oh_my_gawd:
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48)) {
@@ -148,7 +148,7 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
+	 * IOC3 is hugging hugged beyond belief ...  Don't try to access
 	 * anything but 32-bit words ...
 	 */
 	bridge->b_pci_cfg = (busno << 16) | (slot << 11);
@@ -189,7 +189,7 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at it for real ...
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
@@ -213,14 +213,14 @@ static int pci_conf0_write_config(struct pci_bus *bus, unsigned int devfn,
 oh_my_gawd:
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
 	 * generic PCI code a chance to touch the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48))
 		return PCIBIOS_SUCCESSFUL;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
+	 * IOC3 is hugging hugged beyond belief ...  Don't try to access
 	 * anything but 32-bit words ...
 	 */
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
@@ -257,7 +257,7 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
 	 * generic PCI code a chance to look at it for real ...
 	 */
 	if (cf == (PCI_VENDOR_ID_SGI | (PCI_DEVICE_ID_SGI_IOC3 << 16)))
@@ -281,14 +281,14 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 oh_my_gawd:
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't even give the
+	 * IOC3 is hugging hugged beyond belief ...  Don't even give the
 	 * generic PCI code a chance to touch the wrong register.
 	 */
 	if ((where >= 0x14 && where < 0x40) || (where >= 0x48))
 		return PCIBIOS_SUCCESSFUL;
 
 	/*
-	 * IOC3 is fucking fucked beyond belief ...  Don't try to access
+	 * IOC3 is hugging hugged beyond belief ...  Don't try to access
 	 * anything but 32-bit words ...
 	 */
 	addr = &bridge->b_type0_cfg_dev[slot].f[fn].l[where >> 2];
diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
index b69daa02401b..50f04fe491ca 100644
--- a/arch/mips/sgi-ip22/ip22-setup.c
+++ b/arch/mips/sgi-ip22/ip22-setup.c
@@ -36,7 +36,7 @@ void __init plat_mem_setup(void)
 	board_be_init = ip22_be_init;
 
 	/* Init the INDY HPC I/O controller.  Need to call this before
-	 * fucking with the memory controller because it needs to know the
+	 * hugging with the memory controller because it needs to know the
 	 * boardID and whether this is a Guiness or a FullHouse machine.
 	 */
 	sgihpc_init();
-- 
2.19.1

