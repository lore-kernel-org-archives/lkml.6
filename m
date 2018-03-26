Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeCZUIz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:08:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35844 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeCZUIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:08:52 -0400
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com
Subject: [PATCH v3 0/4] Ktest: add email support
Date: Mon, 26 Mar 2018 13:08:00 -0700
Message-Id: <1522094884-22718-1-git-send-email-tianyang.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=509
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803260203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set will let users define a mailer, an email address and when to receive
notifications during automated testings. Users need to setup the specified mailer
prior to using this feature.

Tim Tianyang Chen (4):
  Ktest: add email support
  Ktest: add SigInt handling
  Ktest: use dodie for critical falures
  Ktest: add email options to sample.config

 ktest.pl    | 125 +++++++++++++++++++++++++++++++++++++++++++++---------------
 sample.conf |  22 +++++++++++
 2 files changed, 117 insertions(+), 30 deletions(-)

-- 
2.15.1
