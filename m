Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeEGKZt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:25:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752017AbeEGKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:25:47 -0400
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, jdelvare@suse.com, stewart@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Add support for energy sensors
Date: Mon,  7 May 2018 15:55:35 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18050710-0040-0000-0000-00000455E429
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050710-0041-0000-0000-000020FA1D75
Message-Id: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides support for adding energy sensors to
ibmpowernv-hwmon driver. This patch adds support to read 64bit
sensor values.

Shilpasri G Bhat (3):
  powernv: opal-sensor: Add support to read 64bit sensor values
  hwmon: (ibmpowernv): Add support to read 64 bit sensors
  hwmon: (ibmpowernv) Add energy sensors

 arch/powerpc/include/asm/opal-api.h            |  1 +
 arch/powerpc/include/asm/opal.h                |  2 +
 arch/powerpc/platforms/powernv/opal-sensor.c   | 53 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 drivers/hwmon/ibmpowernv.c                     |  9 +++--
 5 files changed, 63 insertions(+), 3 deletions(-)

-- 
1.8.3.1
