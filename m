Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CA8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFA22086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfANJBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:01:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbfANJBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:01:39 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0E8w3Fa123155
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:01:38 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q0kw2qy60-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:01:38 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <joeln@il.ibm.com>;
        Mon, 14 Jan 2019 09:01:36 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 09:01:33 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0E91VlW58720506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 09:01:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF1994C04E;
        Mon, 14 Jan 2019 09:01:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1450E4C052;
        Mon, 14 Jan 2019 09:01:30 +0000 (GMT)
Received: from tal (unknown [9.148.32.96])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Jan 2019 09:01:29 +0000 (GMT)
Received: by tal (sSMTP sendmail emulation); Mon, 14 Jan 2019 11:01:29 +0200
From:   Joel Nider <joeln@il.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joel Nider <joeln@il.ibm.com>
Subject: [PATCH 3/3] docs-rst: infiniband: update verbs API details
Date:   Mon, 14 Jan 2019 11:00:51 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547456451-7102-1-git-send-email-joeln@il.ibm.com>
References: <1547456451-7102-1-git-send-email-joeln@il.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011409-0016-0000-0000-000002452746
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011409-0017-0000-0000-0000329F3717
Message-Id: <1547456451-7102-4-git-send-email-joeln@il.ibm.com>
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

It is important to understand the existing framework when implementing
a new verb. The majority of existing API functions are implemented using
the write syscall, but this has been superceded by the ioctl syscall
for new commands. This patch updates the documentation regarding how
to go about implementing a new verb, focusing on the new ioctl
interface.

The documentation is far from complete, but this is a good step in the
right direction. Future patches can add more detail according to need.
Also, the interface is still undergoing substantial changes so an
effort was made to document only the stable parts so as to avoid
incorrect information since documentation changes tend to lag behind
code changes.

Signed-off-by: Joel Nider <joeln@il.ibm.com>
---
 Documentation/infiniband/user_verbs.rst | 69 ++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/infiniband/user_verbs.rst b/Documentation/infiniband/user_verbs.rst
index ffc4aec..f0c7cd3 100644
--- a/Documentation/infiniband/user_verbs.rst
+++ b/Documentation/infiniband/user_verbs.rst
@@ -21,12 +21,79 @@ devices.  Fast path operations are typically performed by writing
 directly to hardware registers mmap()ed into userspace, with no
 system call or context switch into the kernel.
 
-Commands are sent to the kernel via write()s on these device files.
+There are currently two methods for executing commands in the kernel: write() and ioctl().
+Older commands are sent to the kernel via write()s on the device files
+mentioned earlier. New commands must use the ioctl() method. For completeness,
+both mechanisms are described here.
+
+The interface between userspace and kernel is kept in sync by checking the
+version number. In the kernel, it is defined by IB_USER_VERBS_ABI_VERSION
+(in include/uapi/rdma/ib_user_verbs.h).
+
+Write system call
+-----------------
 The ABI is defined in drivers/infiniband/include/ib_user_verbs.h.
 The structs for commands that require a response from the kernel
 contain a 64-bit field used to pass a pointer to an output buffer.
 Status is returned to userspace as the return value of the write()
 system call.
+The entry point to the kernel is the ib_uverbs_write() function, which is
+invoked as a response to the 'write' system call. The requested function is
+looked up from an array called uverbs_cmd_table which contains function pointers
+to the various command handlers.
+
+Write Command Handlers
+~~~~~~~~~~~~~~~~~~~~~~
+These command handler functions are declared
+with the IB_VERBS_DECLARE_CMD macro in drivers/infiniband/core/uverbs.h. There
+are also extended commands, which are kept in a similar manner in the
+uverbs_ex_cmd_table. The extended commands use 64-bit values in the command
+header, as opposed to the 32-bit values used in the regular command table.
+
+
+Ioctl system call
+-----------------
+The entry point for the 'ioctl' system call is the ib_uverbs_ioctl() function.
+Unlike write(), ioctl() accepts a 'cmd' parameter, which must have the value
+defined by RDMA_VERBS_IOCTL. More documentation regarding the ioctl numbering
+scheme can be found in: Documentation/ioctl/ioctl-number.txt. The
+command-specific information is passed as a pointer in the 'arg' parameter,
+which is cast as a 'struct ib_uverbs_ioctl_hdr*'.
+
+The way command handler functions (methods) are looked up is more complicated
+than the array index used for write(). Here, the ib_uverbs_cmd_verbs() function
+uses a radix tree to search for the correct command handler. If the lookup
+succeeds, the method is invoked by ib_uverbs_run_method().
+
+Ioctl Command Handlers
+~~~~~~~~~~~~~~~~~~~~~~
+Command handlers (also known as 'methods') for ioctl are declared with the
+UVERBS_HANDLER macro. The handler is registered for use by the
+DECLARE_UVERBS_NAMED_METHOD macro, which binds the name of the handler with its
+attributes. By convention, the methods are implemented in files named with the
+prefix 'uverbs_std_types_'.
+
+Each method can accept a set of parameters called attributes. There are 6
+types of attributes: idr, fd, pointer, enum, const and flags. The idr attribute
+declares an indirect (translated) handle for the method, and
+specifies the object that the method will act upon. The first attribute should
+be a handle to the uobj (ib_uobject) which contains private data. There may be
+0 or more
+additional attributes, including other handles. The 'pointer' attribute must be
+specified as 'in' or 'out', depending on if it is an input from userspace, or
+meant to return a value to userspace.
+
+The method also needs to be bound to an object, which is done with the
+DECLARE_UVERBS_NAMED_OBJECT macro. This macro takes a variable
+number of methods and stores them in an array attached to the object.
+
+Objects are declared using DECLARE_UVERBS_NAMED_OBJECT macro. Most of the
+objects (including pd, mw, cq, etc.) are defined in uverbs_std_types.c,
+and the remaining objects are declared in files that are prefixed with the
+name 'uverbs_std_types_'.
+
+Objects trees are declared using the DECLARE_UVERBS_OBJECT_TREE macro. This
+combines all of the objects.
 
 Resource management
 ===================
-- 
2.7.4

