Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE62C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4DA240B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4DA240B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeGFB5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:57:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753614AbeGFB5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:57:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w661rVDX089772
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 21:57:53 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1s3uvca4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 21:57:53 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bjsdjshi@linux.ibm.com>;
        Thu, 5 Jul 2018 21:57:52 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 21:57:49 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w661vlId5505314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 01:57:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C381A112062;
        Thu,  5 Jul 2018 21:57:39 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B199E112063;
        Thu,  5 Jul 2018 21:57:38 -0400 (EDT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 21:57:38 -0400 (EDT)
From:   Dong Jia Shi <bjsdjshi@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     cohuck@redhat.com, borntraeger@de.ibm.com, legumen@foxmail.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com,
        Dong Jia Shi <bjsdjshi@linux.ibm.com>
Subject: [PATCH 1/1] MAINTAINERS: Remove myself as maintainer
Date:   Fri,  6 Jul 2018 03:57:43 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18070601-0064-0000-0000-00000325FCBB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009316; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057165; UDB=6.00542366; IPR=6.00835085;
 MB=3.00022015; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-06 01:57:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070601-0065-0000-0000-000039D60F6B
Message-Id: <20180706015743.41810-1-bjsdjshi@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=488 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am leaving IBM and will move on to other working area,
so remove myself as a vfio-ccw maintainer.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>

---
I've enjoyed working with you guys. Hope to meet you in future,
until then, thank you for all your coach and help, please take
care, and farewell.

[I've send you my private contact data. :]

--
Dong Jia
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07d1576fc766..e52eb9312f2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12398,7 +12398,6 @@ F:	drivers/pci/hotplug/s390_pci_hpc.c
 
 S390 VFIO-CCW DRIVER
 M:	Cornelia Huck <cohuck@redhat.com>
-M:	Dong Jia Shi <bjsdjshi@linux.ibm.com>
 M:	Halil Pasic <pasic@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
-- 
2.16.4

