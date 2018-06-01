Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbeFASVU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:21:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:37285 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753369AbeFASVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:21:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="60520275"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Eric Sandeen <sandeen@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Matthew R . Ochs" <mrochs@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: [PATCH linux-next v5 02/13] Documentation: ioctl: Add ioctl numbers for PECI subsystem
Date: Fri,  1 Jun 2018 11:21:12 -0700
Message-Id: <20180601182112.23674-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates ioctl-number.txt to reflect ioctl numbers used
by the PECI subsystem.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: James Feist <james.feist@linux.intel.com>
Cc: Jason M Biils <jason.m.bills@linux.intel.com>
Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
---
 Documentation/ioctl/ioctl-number.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 480c8609dc58..1670ca4072b2 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -322,6 +322,8 @@ Code  Seq#(hex)	Include File		Comments
 0xB3	00	linux/mmc/ioctl.h
 0xB4	00-0F	linux/gpio.h		<mailto:linux-gpio@vger.kernel.org>
 0xB5	00-0F	uapi/linux/rpmsg.h	<mailto:linux-remoteproc@vger.kernel.org>
+0xB6	00-0F	uapi/linux/peci-ioctl.h	PECI subsystem
+					<mailto:jae.hyun.yoo@linux.intel.com>
 0xC0	00-0F	linux/usb/iowarrior.h
 0xCA	00-0F	uapi/misc/cxl.h
 0xCA	10-2F	uapi/misc/ocxl.h
-- 
2.17.0
