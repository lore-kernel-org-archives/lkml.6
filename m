Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeBTOy4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:54:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752116AbeBTOyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:54:53 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] doc-guide: kernel-doc: add comment about formatting verification
Date: Tue, 20 Feb 2018 16:54:44 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18022014-0040-0000-0000-00000435A4D8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022014-0041-0000-0000-000020D7B578
Message-Id: <1519138484-29023-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no automated checking for kernel-doc comments except
running 'kernel-doc -v -none <filename>'. Mention the possibility to run
kernel-doc to verify formatting of the comments in the kernel-doc guide.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/doc-guide/kernel-doc.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index c6c3297..bb5ed6d 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -44,6 +44,12 @@ that somebody changing the code will also change the documentation. The
 overview kernel-doc comments may be placed anywhere at the top indentation
 level.
 
+Running the ``kernel-doc`` tool with increased verbosity and without actual
+output generation may be used to verify proper formating of the
+documentation comments. For example::
+
+	scripts/kernel-doc -v -none drivers/foo/bar.c
+
 Function documentation
 ----------------------
 
-- 
2.7.4
