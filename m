Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934722086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfBUJSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:18:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726639AbfBUJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:18:11 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1L96Oro037469
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:18:10 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qsrrmsp8n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:18:09 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bblock@linux.ibm.com>;
        Thu, 21 Feb 2019 09:18:08 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 09:18:05 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1L9I3sn28246220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 09:18:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ED2DAE056;
        Thu, 21 Feb 2019 09:18:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ADB3AE051;
        Thu, 21 Feb 2019 09:18:03 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.145.59.126])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Feb 2019 09:18:03 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.91)
        (envelope-from <bblock@linux.ibm.com>)
        id 1gwkUU-0006fs-Oo; Thu, 21 Feb 2019 10:18:02 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Benjamin Block <bblock@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/2] scsi: whitespace cleanup in scsi_scan.c
Date:   Thu, 21 Feb 2019 10:18:01 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <c5bd5a82d1250471822cbf5891ea1866166cd9e6.1550740533.git.bblock@linux.ibm.com>
References: <20190220184847.24640-1-bblock@linux.ibm.com> <c5bd5a82d1250471822cbf5891ea1866166cd9e6.1550740533.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022109-0016-0000-0000-0000025917CE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022109-0017-0000-0000-000032B3665E
Message-Id: <b6078c66923536b3086a8b9ca528ac0711ae8139.1550740533.git.bblock@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed during editing that vim would remove some trailing spaces.

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/scsi/scsi_scan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 53380e07b40e..7e1a6c3dd42c 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -108,7 +108,7 @@ MODULE_PARM_DESC(scan, "sync, async, manual, or none. "
 static unsigned int scsi_inq_timeout = SCSI_TIMEOUT/HZ + 18;
 
 module_param_named(inq_timeout, scsi_inq_timeout, uint, S_IRUGO|S_IWUSR);
-MODULE_PARM_DESC(inq_timeout, 
+MODULE_PARM_DESC(inq_timeout,
 		 "Timeout (in seconds) waiting for devices to answer INQUIRY."
 		 " Default is 20. Some devices may need more; most need less.");
 
@@ -604,7 +604,7 @@ static int scsi_probe_lun(struct scsi_device *sdev, unsigned char *inq_result,
 			 * not-ready to ready transition [asc/ascq=0x28/0x0]
 			 * or power-on, reset [asc/ascq=0x29/0x0], continue.
 			 * INQUIRY should not yield UNIT_ATTENTION
-			 * but many buggy devices do so anyway. 
+			 * but many buggy devices do so anyway.
 			 */
 			if (driver_byte(result) == DRIVER_SENSE &&
 			    scsi_sense_valid(&sshdr)) {
@@ -850,7 +850,7 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 	 * Don't set the device offline here; rather let the upper
 	 * level drivers eval the PQ to decide whether they should
 	 * attach. So remove ((inq_result[0] >> 5) & 7) == 1 check.
-	 */ 
+	 */
 
 	sdev->inq_periph_qual = (inq_result[0] >> 5) & 7;
 	sdev->lockable = sdev->removable;
@@ -994,7 +994,7 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 }
 
 #ifdef CONFIG_SCSI_LOGGING
-/** 
+/**
  * scsi_inq_str - print INQUIRY data from min to max index, strip trailing whitespace
  * @buf:   Output buffer with at least end-first+1 bytes of space
  * @inq:   Inquiry buffer (input)
@@ -1495,7 +1495,7 @@ EXPORT_SYMBOL(__scsi_add_device);
 int scsi_add_device(struct Scsi_Host *host, uint channel,
 		    uint target, u64 lun)
 {
-	struct scsi_device *sdev = 
+	struct scsi_device *sdev =
 		__scsi_add_device(host, channel, target, lun, NULL);
 	if (IS_ERR(sdev))
 		return PTR_ERR(sdev);
-- 
2.20.1

