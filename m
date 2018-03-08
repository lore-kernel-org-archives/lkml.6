Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935359AbeCHJOh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:14:37 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:22355 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeCHJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:14:33 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180308091431epoutp0135848cabeda9ae4ad1e2d3ad44a4ab04~Z5x9b2srg2283022830epoutp01W
X-AuditID: b6c32a39-47fff70000000fc5-87-5aa0fef6d239
From: Alim Akhtar <alim.akhtar@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vinholikatti@gmail.com, subhashj@codeaurora.org,
        devicetree@vger.kernel.org, shaik.ameer@samsung.com
Subject: [RFC PATCH] scsi: ufs: Add specific callback for setting DMA mask
Date: Thu, 08 Mar 2018 14:33:46 +0530
Message-id: <1520499826-19352-1-git-send-email-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCmnu63fwuiDB6vN7eYf+Qcq8WqiXkW
        l3fNYbPovr6DzWL58X9MFkce7ma3uLF4J5vFjoVVDhwel/t6mTx2zrrL7vHg0GYWj49Pb7F4
        9G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV8az/1NYC+YLVtzu2MXSwDiDr4uRk0NCwETiTu8s
        dhBbSGAHo8TCRS5djFxA9ndGiX8/LjJ1MXKAFb1tNIGo2cAo8WGKKETND0aJJUsnMYEk2AS0
        Je5O3wJmiwjYSJy/+YAJpIhZYCGjxJ5bJ8A2CAt4SVx/PIURxGYRUJXY+mARG4jNK+Au8fTd
        cUaIi+Qkbp7rZAZplhBoZJOY9XseC0TCRaJ53Q+oImGJV8e3sENcJy1x6agtRDhb4sPxk8wQ
        do3ErIu9bBC2vcSBK3PAxjAL8Em8+9rDCtHKK9HRJgRR4iFxaUcPVKujxO7vi5ggHo6V+Niz
        kGkCo+QCRoZVjGKpBcW56anFhgWmesWJucWleel6yfm5mxjBcahluYPx2DmfQ4wCHIxKPLwH
        fs6PEmJNLCuuzD3EKMHBrCTCy7VsQZQQb0piZVVqUX58UWlOavEhRmkOFiVx3oAAlyghgfTE
        ktTs1NSC1CKYLBMHp1QDo4/5LQPO6f/3rtSxTz4mwLrkHfvj/r63RZa5WxT21mayWJyawLBg
        Zv3DV2kCN8v+lxq4ruW4uj7y6wuzJ2weOe5fnwSl66TM4XiYJRM67/eKy057gh8XHL5+cn61
        0dYzrmrHp6xm6tSY8HxukG4qV8aL6v8nhHQ+Xb4hLRrt+TWASUrO2OX2CyWW4oxEQy3mouJE
        AOlK4Aa/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsVy+t9jQd2v/xZEGbQ0K1jMP3KO1WLVxDyL
        y7vmsFl0X9/BZrH8+D8miyMPd7Nb3Fi8k81ix8IqBw6Py329TB47Z91l93hwaDOLx8ent1g8
        +rasYvT4vEkugC2KyyYlNSezLLVI3y6BK+PZ/ymsBfMFK2537GJpYJzB18XIwSEhYCLxttGk
        i5GLQ0hgHaPE5ker2CGcH4wS7Vf+MnYxcnKwCWhL3J2+hQnEFhGwkTh/8wETSBGzwEJGiZNd
        W8GKhAW8JK4/ngJmswioSmx9sIgNxOYVcJd4+u44WFxCQE7i5rlO5gmMXAsYGVYxSqYWFOem
        5xYbFRjmpZbrFSfmFpfmpesl5+duYgSGybbDWn07GO8viT/EKMDBqMTDK/FnfpQQa2JZcWXu
        IUYJDmYlEV6uZQuihHhTEiurUovy44tKc1KLDzFKc7AoifPezjsWKSSQnliSmp2aWpBaBJNl
        4uCUamDsMFm0cM3jKkld/rP3V1zK/W/oxpJ5neHNxXCuCpmWwGcm67Nfbwg92Wih1MdYLjF7
        Z3LdHr2y6+e4usOidxnZ1EdNTl92oGQW/2PPoveWsQeKWMOcj0425jCcmMH//NvKHJOYtNzC
        yg8Cl9a4OHyZrflrPdvPOWyuq93lt9l8nHpsQbdp+WQlluKMREMt5qLiRADj6r3YDwIAAA==
X-CMS-MailID: 20180308091429epcas1p24da59df5f8872ee4c851898f78dec85b
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180308091429epcas1p24da59df5f8872ee4c851898f78dec85b
X-RootMTR: 20180308091429epcas1p24da59df5f8872ee4c851898f78dec85b
References: <CGME20180308091429epcas1p24da59df5f8872ee4c851898f78dec85b@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently DMA mask for UFS HCI is set by reading CAP register's
[64AS] bit. Some HCI controller like Exynos support 36-bit bus address.
This works perfectly fine with DMA mask set as 64 in case there is no
IOMMU attached to HCI.
In case if HCI is behind an IOMMU, setting DMA mask as 64 bit won't
work as HCI has only 36bit addressing and SMMU has created mapping of
64 bit and as the device truncates the address, its mapping will not
be found by iommu.
To resolve such issues, let the variant driver sets its own DMA mask.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 drivers/scsi/ufs/ufshcd.h | 2 ++
 2 files changed, 5 insertions(+)

I am not sure if there are other ways available to handle such cases.
The IOMMU I am talking about is arm-smmu and it DT binding does not
give much idea about handling such cases.

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a355d98..9a1374e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7781,6 +7781,9 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
  */
 static int ufshcd_set_dma_mask(struct ufs_hba *hba)
 {
+	if (hba->vops && hba->vops->set_dam_mask)
+		return bha->vops->set_dma_mask(hba);
+
 	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
 		if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
 			return 0;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 1332e54..89c6dae 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
  * @resume: called during host controller PM callback
  * @dbg_register_dump: used to dump controller debug information
  * @phy_initialization: used to initialize phys
+ * @set_dma_mask: used to set variant specific DMA mask
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -325,6 +326,7 @@ struct ufs_hba_variant_ops {
 	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
 	void	(*dbg_register_dump)(struct ufs_hba *hba);
 	int	(*phy_initialization)(struct ufs_hba *);
+	int	(*set_dma_mask)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
-- 
2.7.4
