Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B997C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1576F2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfAVKBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:01:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727601AbfAVKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:01:11 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0M9x8qL114824
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:01:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q60rb8sy3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:01:09 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Tue, 22 Jan 2019 10:01:07 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 10:01:05 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0MA14O552756484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 10:01:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 395F74203F;
        Tue, 22 Jan 2019 10:01:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C03D42049;
        Tue, 22 Jan 2019 10:01:02 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Jan 2019 10:01:02 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Tue, 22 Jan 2019 12:01:01 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Nider <joeln@il.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: add new RDMA/Infiniband documentation
Date:   Tue, 22 Jan 2019 12:00:35 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548151235-386-1-git-send-email-joeln@il.ibm.com>
References: <1548151235-386-1-git-send-email-joeln@il.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012210-0016-0000-0000-00000248B72F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012210-0017-0000-0000-000032A2EDED
Message-Id: <1548151235-386-4-git-send-email-joeln@il.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=785 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RDMA (Infiniband) user verb documentation has been converted to .rst
format, and moved to the Documentation/userspace-api directory. In
addition, a new file is added to Documentation/driver-api with some
details on Infiniband internals. Thus, the MAINTAINERS file must be
updated with the responsibility of the new files.

Signed-off-by: Joel Nider <joeln@il.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cf9c1c..977b83d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7487,6 +7487,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
 S:	Supported
 F:	Documentation/devicetree/bindings/infiniband/
 F:	Documentation/infiniband/
+F:	Documentation/userspace-api/rdma_user_verbs.rst
+F:	Documentation/driver-api/infiniband.rst
 F:	drivers/infiniband/
 F:	include/uapi/linux/if_infiniband.h
 F:	include/uapi/rdma/
-- 
2.7.4

