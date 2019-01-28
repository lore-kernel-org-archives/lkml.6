Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07453C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50CF2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbfA1QnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:43:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389049AbfA1QXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:32 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SGJQgS110140
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:23:31 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qa49ab8tm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:23:31 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 28 Jan 2019 16:23:30 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 16:23:27 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SGNQd425624780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 16:23:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22C20B2065;
        Mon, 28 Jan 2019 16:23:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A4FAB206A;
        Mon, 28 Jan 2019 16:23:25 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 16:23:25 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux@roeck-us.net, joel@jms.id.au,
        jdelvare@suse.com, tglx@linutronix.de,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] occ: FSI and hwmon: Fix license headers
Date:   Mon, 28 Jan 2019 10:23:22 -0600
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19012816-0064-0000-0000-0000039F04B5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010493; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153048; UDB=6.00601113; IPR=6.00933410;
 MB=3.00025324; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 16:23:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012816-0065-0000-0000-00003C351A79
Message-Id: <1548692604-9899-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=762 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.vnet.ibm.com>

Source files for the FSI OCC and OCC hwmon drivers had a combination of bad
license information and missing IBM copyright. Correct the licenses.

Changes since v1:
 - correct header comment style

Eddie James (2):
  hwmon (occ): Fix license headers
  fsi: occ: Fix license header

 drivers/fsi/fsi-occ.c      |  3 ++-
 drivers/hwmon/occ/common.c |  3 ++-
 drivers/hwmon/occ/common.h |  3 ++-
 drivers/hwmon/occ/p8_i2c.c |  3 ++-
 drivers/hwmon/occ/p9_sbe.c |  3 ++-
 drivers/hwmon/occ/sysfs.c  | 13 ++-----------
 6 files changed, 12 insertions(+), 16 deletions(-)

-- 
1.8.3.1

