Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08DDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEF720870
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfANJBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:01:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbfANJBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:01:36 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0E8vwWK053653
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:01:35 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q0ntt48qe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:01:34 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Mon, 14 Jan 2019 09:01:31 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 09:01:29 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0E91RD038666260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 09:01:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DCDA52065;
        Mon, 14 Jan 2019 09:01:27 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 04BC05204F;
        Mon, 14 Jan 2019 09:01:25 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Mon, 14 Jan 2019 11:01:25 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joel Nider <joeln@il.ibm.com>
Subject: [PATCH 2/3] docs-rst: update index file with infiniband docs
Date:   Mon, 14 Jan 2019 11:00:50 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547456451-7102-1-git-send-email-joeln@il.ibm.com>
References: <1547456451-7102-1-git-send-email-joeln@il.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011409-4275-0000-0000-000002FEDF5E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011409-4276-0000-0000-0000380CF7B9
Message-Id: <1547456451-7102-3-git-send-email-joeln@il.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link the previously converted Documentation/infiniband/user_verbs.rst
to the main index by creating a new subsystem (Infiniband) under the
root document. This manifests as a new section under "Kernel API
Documentation" in the index.html, as well as a new section in the
table of contents pane.

This has been tested with 'make htmldocs'.
---
 Documentation/conf.py              |  2 ++
 Documentation/index.rst            |  1 +
 Documentation/infiniband/conf.py   | 10 ++++++++++
 Documentation/infiniband/index.rst |  9 +++++++++
 4 files changed, 22 insertions(+)
 create mode 100644 Documentation/infiniband/conf.py
 create mode 100644 Documentation/infiniband/index.rst

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 72647a3..ff71088 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -389,6 +389,8 @@ latex_documents = [
      'ext4 Data Structures and Algorithms', 'ext4 Community', 'manual'),
     ('gpu/index', 'gpu.tex', 'Linux GPU Driver Developer\'s Guide',
      'The kernel development community', 'manual'),
+    ('infiniband/index', 'infiniband.tex', 'Infiniband subsystem',
+     'The kernel development community', 'manual'),
     ('input/index', 'linux-input.tex', 'The Linux input driver subsystem',
      'The kernel development community', 'manual'),
     ('kernel-hacking/index', 'kernel-hacking.tex', 'Unreliable Guide To Hacking The Linux Kernel',
diff --git a/Documentation/index.rst b/Documentation/index.rst
index c858c2e..8d91ea5 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -82,6 +82,7 @@ needed).
    core-api/index
    media/index
    networking/index
+   infiniband/index
    input/index
    gpu/index
    security/index
diff --git a/Documentation/infiniband/conf.py b/Documentation/infiniband/conf.py
new file mode 100644
index 0000000..dc42d33
--- /dev/null
+++ b/Documentation/infiniband/conf.py
@@ -0,0 +1,10 @@
+# -*- coding: utf-8; mode: python -*-
+
+project = "Linux Infiniband Documentation"
+
+tags.add("subproject")
+
+latex_documents = [
+    ('index', 'infiniband.tex', project,
+     'The kernel development community', 'manual'),
+]
diff --git a/Documentation/infiniband/index.rst b/Documentation/infiniband/index.rst
new file mode 100644
index 0000000..2dedc65
--- /dev/null
+++ b/Documentation/infiniband/index.rst
@@ -0,0 +1,9 @@
+Infiniband Documentation
+========================
+
+Contents:
+
+.. toctree::
+   :maxdepth: 1
+
+   user_verbs
-- 
2.7.4

