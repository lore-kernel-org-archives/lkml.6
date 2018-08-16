Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E2AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA052147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA052147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392280AbeHPTSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:18:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727878AbeHPTSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:18:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3995DBB430;
        Thu, 16 Aug 2018 16:18:36 +0000 (UTC)
Received: from t450s.home (ovpn-120-10.rdu2.redhat.com [10.10.120.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3C2610C1F;
        Thu, 16 Aug 2018 16:18:35 +0000 (UTC)
Date:   Thu, 16 Aug 2018 10:18:35 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v4.19-rc1
Message-ID: <20180816101835.08c91d7a@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 16 Aug 2018 16:18:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 16 Aug 2018 16:18:36 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'alex.williamson@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 1ffaddd029c867d134a1dde39f540dcc8c52e274:

  Linux 4.18-rc8 (2018-08-05 12:37:41 -0700)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v4.19-rc1

for you to fetch changes up to 0dd0e297f0ec780b6b3484ba38b27d18c8ca7af9:

  vfio-pci: Disable binding to PFs with SR-IOV enabled (2018-08-06 12:23:19 -0600)

----------------------------------------------------------------
VFIO updates for v4.19

 - Mark switch fall throughs (Gustavo A. R. Silva)

 - Disable binding SR-IOV enabled PFs (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      vfio-pci: Disable binding to PFs with SR-IOV enabled

Gustavo A. R. Silva (1):
      vfio: Mark expected switch fall-throughs

 drivers/vfio/pci/vfio_pci.c     | 15 ++++++++++++++-
 drivers/vfio/vfio_iommu_type1.c |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)
