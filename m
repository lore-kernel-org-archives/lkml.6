Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0340DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F41206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfBKHEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:04:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbfBKHEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:04:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1B6x2rh123244
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:04:42 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qk33jjxg2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:04:41 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 11 Feb 2019 07:04:39 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Feb 2019 07:04:38 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1B74bUw65732852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 07:04:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33C0E52052;
        Mon, 11 Feb 2019 07:04:37 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.44.247])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 01E245204E;
        Mon, 11 Feb 2019 07:04:36 +0000 (GMT)
Date:   Mon, 11 Feb 2019 08:04:36 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for 5.0 #3
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19021107-0028-0000-0000-000003470502
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021107-0029-0000-0000-000024051EB8
Message-Id: <20190211080436.13c3504f@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull s390 fixes for 5.0-rc7

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.0-3

for you to fetch changes up to 614db26954ff08fa8e92b04100e31ebc04b817cf:

  Revert "s390/pci: remove bit_lock usage in interrupt handler" (2019-02-07 11:56:29 +0100)

----------------------------------------------------------------
s390 update with bug fixes for 5.0-rc6

 - Fix specification exception on z196 during ap probe

 - A fix for suspend-to-disk, the VMAP stack patch broke the
   swsusp_arch_suspend function

 - The EMC CKD ioctl of the dasd driver needs an additional size
   check for user space data

 - Revert an incorrect patch for the PCI base code that removed
   a bit lock that turned out to be required after all

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/zcrypt: fix specification exception on z196 during ap probe

Martin Schwidefsky (1):
      s390/suspend: fix stack setup in swsusp_arch_suspend

Sebastian Ott (1):
      Revert "s390/pci: remove bit_lock usage in interrupt handler"

Stefan Haberland (1):
      s390/dasd: fix using offset into zero size array error

 arch/s390/kernel/swsusp.S      | 4 ++--
 arch/s390/pci/pci.c            | 4 +++-
 drivers/s390/block/dasd_eckd.c | 8 ++++++++
 drivers/s390/crypto/ap_bus.c   | 3 ++-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/swsusp.S b/arch/s390/kernel/swsusp.S
index 537f97f..b6796e6 100644
--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -30,10 +30,10 @@
 	.section .text
 ENTRY(swsusp_arch_suspend)
 	lg	%r1,__LC_NODAT_STACK
-	aghi	%r1,-STACK_FRAME_OVERHEAD
 	stmg	%r6,%r15,__SF_GPRS(%r1)
+	aghi	%r1,-STACK_FRAME_OVERHEAD
 	stg	%r15,__SF_BACKCHAIN(%r1)
-	lgr	%r1,%r15
+	lgr	%r15,%r1
 
 	/* Store FPU registers */
 	brasl	%r14,save_fpu_regs
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index a966d7b..4266a4d 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -382,7 +382,9 @@ static void zpci_irq_handler(struct airq_struct *airq)
 			if (ai == -1UL)
 				break;
 			inc_irq_stat(IRQIO_MSI);
+			airq_iv_lock(aibv, ai);
 			generic_handle_irq(airq_iv_get_data(aibv, ai));
+			airq_iv_unlock(aibv, ai);
 		}
 	}
 }
@@ -408,7 +410,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	zdev->aisb = aisb;
 
 	/* Create adapter interrupt vector */
-	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA);
+	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA | AIRQ_IV_BITLOCK);
 	if (!zdev->aibv)
 		return -ENOMEM;
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 4e7b55a..6e294b4 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4469,6 +4469,14 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 		usrparm.psf_data &= 0x7fffffffULL;
 		usrparm.rssd_result &= 0x7fffffffULL;
 	}
+	/* at least 2 bytes are accessed and should be allocated */
+	if (usrparm.psf_data_len < 2) {
+		DBF_DEV_EVENT(DBF_WARNING, device,
+			      "Symmetrix ioctl invalid data length %d",
+			      usrparm.psf_data_len);
+		rc = -EINVAL;
+		goto out;
+	}
 	/* alloc I/O data area */
 	psf_data = kzalloc(usrparm.psf_data_len, GFP_KERNEL | GFP_DMA);
 	rssd_result = kzalloc(usrparm.rssd_result_len, GFP_KERNEL | GFP_DMA);
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 48ea000..5a69974 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -248,7 +248,8 @@ static inline int ap_test_config(unsigned int *field, unsigned int nr)
 static inline int ap_test_config_card_id(unsigned int id)
 {
 	if (!ap_configuration)	/* QCI not supported */
-		return 1;
+		/* only ids 0...3F may be probed */
+		return id < 0x40 ? 1 : 0;
 	return ap_test_config(ap_configuration->apm, id);
 }
 

