Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013CDC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FC5206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FC5206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeI2ESP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:18:15 -0400
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:54128 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbeI2ESO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:18:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D0196181D340F;
        Fri, 28 Sep 2018 21:52:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: frogs99_504ef09951230
X-Filterd-Recvd-Size: 1919
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:52:31 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Manoj N . Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R . Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) SCSI DRIVER'
Date:   Fri, 28 Sep 2018 14:52:30 -0700
Message-Id: <20180928215230.29127-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	3964	CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) SCSI DRIVER
	3965	M:	Manoj N. Kumar <manoj@linux.vnet.ibm.com>
	3966	M:	Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
	3967	M:	Uma Krishnan <ukrishn@linux.vnet.ibm.com>
	3968	L:	linux-scsi@vger.kernel.org
	3969	S:	Supported
	3970	F:	drivers/scsi/cxlflash/
-->	3971	F:	include/uapi/scsi/cxlflash_ioctls.h
	3972	F:	Documentation/powerpc/cxlflash.txt

Commit that introduced this:

commit 11f43ae7735a04994ef3c33295d386ef4e5529b7
 Author: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
 Date:   Wed Oct 21 15:15:22 2015 -0500
 
     MAINTAINERS: Add cxlflash driver
     
     Add stanza for cxlflash SCSI driver.
     
     Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
     Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
     Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
     Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
     Signed-off-by: James Bottomley <JBottomley@Odin.com>
 
  MAINTAINERS | 9 +++++++++
  1 file changed, 9 insertions(+)

No commit with include/uapi/scsi/cxlflash_ioctls.h found

