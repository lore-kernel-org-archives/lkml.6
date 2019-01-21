Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ACDC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048D220861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfAUT4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:56:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728011AbfAUT4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:56:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LJsjug081421
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 14:56:41 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5htwpgca-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 14:56:40 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 21 Jan 2019 19:56:39 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 19:56:37 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LJuaE020250800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 19:56:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF2E0AE060;
        Mon, 21 Jan 2019 19:56:35 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E807AE05C;
        Mon, 21 Jan 2019 19:56:35 +0000 (GMT)
Received: from oc6728276242.ibm.com (unknown [9.85.171.190])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jan 2019 19:56:35 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, joel@jms.id.au, tglx@linutronix.de,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] occ: FSI and hwmon: Fix license headers
Date:   Mon, 21 Jan 2019 13:56:30 -0600
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19012119-0052-0000-0000-0000037BE1B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010449; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01149804; UDB=6.00599143; IPR=6.00930129;
 MB=3.00025225; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-21 19:56:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012119-0053-0000-0000-00005F8CCBD4
Message-Id: <1548100592-50383-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=658 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Source files for the FSI OCC and OCC hwmon drivers had a combination of bad
license information and missing IBM copyright. Correct the licenses.

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

