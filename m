Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B06C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D632121770
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D632121770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeHUEik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:38:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725732AbeHUEij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:38:39 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7L1IrNH001756
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 21:20:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m04x77nbv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 21:20:42 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Mon, 20 Aug 2018 19:20:41 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Aug 2018 19:20:39 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7L1KcNu10027442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Aug 2018 18:20:38 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E06BBE058;
        Mon, 20 Aug 2018 19:20:38 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD394BE04F;
        Mon, 20 Aug 2018 19:20:36 -0600 (MDT)
Received: from oc6857751186.ibm.com (unknown [9.85.215.154])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Aug 2018 19:20:36 -0600 (MDT)
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        nfont@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH] MAINTAINERS: add maintainer entries for RPA pci hotplug drivers
Date:   Mon, 20 Aug 2018 18:20:31 -0700
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18082101-8235-0000-0000-00000DEDFCC5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009582; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01076499; UDB=6.00554940; IPR=6.00856469;
 MB=3.00022835; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-21 01:20:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082101-8236-0000-0000-00004258FB57
Message-Id: <1534814431-20112-1-git-send-email-tyreld@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=253 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself as maintiner of the IBM RPA hotplug modules located in
drivers/pci/hotplug directory. These modules provide kernel interfaces
for support of Dynamic Logical Partitioning (DLPAR) of Logical and
Physical IO slots, and hotplug of physical PCI slots of a PHB on
RPA-compliant ppc64 platforms (pseries).

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5df1b36..7b5dc3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6984,6 +6984,20 @@ F:	drivers/crypto/vmx/aes*
 F:	drivers/crypto/vmx/ghash*
 F:	drivers/crypto/vmx/ppc-xlate.pl
 
+IBM Power PCI Hotplug Driver for RPA-compliant PPC64 platform
+M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+L:	linux-pci@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	drivers/pci/hotplug/rpaphp*
+
+IBM Power IO DLPAR Driver for RPA-compliant PPC64 platform
+M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+L:	linux-pci@vger.kernel.org
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	drivers/pci/hotplug/rpadlpar*
+
 IBM ServeRAID RAID DRIVER
 S:	Orphan
 F:	drivers/scsi/ips.*
-- 
1.8.3.1

