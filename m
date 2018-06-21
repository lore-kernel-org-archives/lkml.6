Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1F5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1A521C3B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1A521C3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeFUTkJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:40:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:43499 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932686AbeFUTkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:40:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 12:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="50872295"
Received: from maru.jf.intel.com ([10.54.51.80])
  by orsmga007.jf.intel.com with ESMTP; 21 Jun 2018 12:40:06 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew R . Ochs" <mrochs@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: [PATCH linux-next v6 02/13] Documentation: ioctl: Add ioctl numbers for PECI subsystem
Date:   Thu, 21 Jun 2018 12:40:05 -0700
Message-Id: <20180621194005.20687-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
References: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
2.17.1

