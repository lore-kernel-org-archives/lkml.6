Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2DEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7271420862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7271420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbeKHCSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:18:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728027AbeKHCSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:18:36 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA7Ge2XC108041
        for <linux-kernel@vger.kernel.org>; Wed, 7 Nov 2018 11:47:27 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nm0uwrxag-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:47:27 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 7 Nov 2018 16:47:24 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Nov 2018 16:47:22 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA7GlLka8520190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 16:47:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C13C9AE051;
        Wed,  7 Nov 2018 16:47:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ACCEAE04D;
        Wed,  7 Nov 2018 16:47:20 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Nov 2018 16:47:20 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 07 Nov 2018 18:47:19 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 1/2] kernel-doc: kill trailing whitespace
Date:   Wed,  7 Nov 2018 18:47:12 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541609233-14182-1-git-send-email-rppt@linux.ibm.com>
References: <1541609233-14182-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18110716-0020-0000-0000-000002E338C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110716-0021-0000-0000-00002132B74E
Message-Id: <1541609233-14182-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 scripts/kernel-doc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index ffbe901..24d3550 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -361,7 +361,7 @@ my $doc_com = '\s*\*\s*';
 my $doc_com_body = '\s*\* ?';
 my $doc_decl = $doc_com . '(\w+)';
 # @params and a strictly limited set of supported section names
-my $doc_sect = $doc_com . 
+my $doc_sect = $doc_com .
     '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:(.*)';
 my $doc_content = $doc_com_body . '(.*)';
 my $doc_block = $doc_com . 'DOC:\s*(.*)?';
@@ -751,7 +751,7 @@ sub output_blockhead_rst(%) {
 
 #
 # Apply the RST highlights to a sub-block of text.
-#   
+#
 sub highlight_block($) {
     # The dohighlight kludge requires the text be called $contents
     my $contents = shift;
-- 
2.7.4

