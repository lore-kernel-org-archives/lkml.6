Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16A6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BC9206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfAMNQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 08:16:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbfAMNQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 08:16:24 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0DDCPwM104671
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 08:16:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pyxb3ubh1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 08:16:22 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Sun, 13 Jan 2019 13:16:20 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 13 Jan 2019 13:16:17 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0DDGHA413435018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Jan 2019 13:16:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEB9FA404D;
        Sun, 13 Jan 2019 13:16:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94CBEA4040;
        Sun, 13 Jan 2019 13:16:15 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 13 Jan 2019 13:16:15 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Sun, 13 Jan 2019 15:16:14 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Nider <joeln@il.ibm.com>
Subject: [PATCH] docs-rst: doc-guide: Minor grammar fixes
Date:   Sun, 13 Jan 2019 15:15:59 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19011313-0012-0000-0000-000002E76A20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011313-0013-0000-0000-0000211E77A4
Message-Id: <1547385359-27927-1-git-send-email-joeln@il.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=604 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901130120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using this guide to learn the new documentation method, I saw
a few phrases that I felt could be improved. These small changes
improve the grammar and choice of words to further enhance the
installation instructions.

Signed-off-by: Joel Nider <joeln@il.ibm.com>
---
 Documentation/doc-guide/sphinx.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 02605ee..e456a4f 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -27,8 +27,8 @@ Sphinx Install
 ==============
 
 The ReST markups currently used by the Documentation/ files are meant to be
-built with ``Sphinx`` version 1.3 or upper. If you're desiring to build
-PDF outputs, it is recommended to use version 1.4.6 or upper.
+built with ``Sphinx`` version 1.3 or higher. If you desire to build
+PDF output, it is recommended to use version 1.4.6 or higher.
 
 There's a script that checks for the Sphinx requirements. Please see
 :ref:`sphinx-pre-install` for further details.
@@ -37,15 +37,15 @@ Most distributions are shipped with Sphinx, but its toolchain is fragile,
 and it is not uncommon that upgrading it or some other Python packages
 on your machine would cause the documentation build to break.
 
-A way to get rid of that is to use a different version than the one shipped
-on your distributions. In order to do that, it is recommended to install
+A way to avoid that is to use a different version than the one shipped
+on your distributions. In order to do so, it is recommended to install
 Sphinx inside a virtual environment, using ``virtualenv-3``
 or ``virtualenv``, depending on how your distribution packaged Python 3.
 
 .. note::
 
    #) Sphinx versions below 1.5 don't work properly with Python's
-      docutils version 0.13.1 or upper. So, if you're willing to use
+      docutils version 0.13.1 or higher. So, if you're willing to use
       those versions, you should run ``pip install 'docutils==0.12'``.
 
    #) It is recommended to use the RTD theme for html output. Depending
@@ -82,7 +82,7 @@ output.
 PDF and LaTeX builds
 --------------------
 
-Such builds are currently supported only with Sphinx versions 1.4 and upper.
+Such builds are currently supported only with Sphinx versions 1.4 and higher.
 
 For PDF and LaTeX output, you'll also need ``XeLaTeX`` version 3.14159265.
 
-- 
2.7.4

