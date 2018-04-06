Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeDFWR1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:17:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59482 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeDFWR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:17:26 -0400
From: Tim Tianyang Chen <tianyang.chen@oracle.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, dhaval.giani@oracle.com,
        tim.tianyang.chen@alumni.upenn.edu,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [PATCH v3 0/4] ktest: add email support
Date: Fri,  6 Apr 2018 15:17:01 -0700
Message-Id: <1523053025-12424-1-git-send-email-tianyang.chen@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=655
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804060222
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set will let users define a mailer, an email address and when to receive
notifications during automated testings. Users need to setup the specified mailer
prior to using this feature.

Tim Tianyang Chen (4):
  ktest: add email support
  ktest: add SigInt handling
  ktest: use dodie for critical falures
  ktest: add email options to sample.config

 tools/testing/ktest/ktest.pl    | 125 ++++++++++++++++++++++++++++++----------
 tools/testing/ktest/sample.conf |  22 +++++++
 2 files changed, 117 insertions(+), 30 deletions(-)

-- 
1.8.3.1
