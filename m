Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E871AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A2F206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfAJQqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:46:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12437 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfAJQqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:46:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94BD4C0587F9;
        Thu, 10 Jan 2019 16:46:10 +0000 (UTC)
Received: from x1.home (ovpn-116-25.phx2.redhat.com [10.3.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BBC868B2B;
        Thu, 10 Jan 2019 16:46:10 +0000 (UTC)
Date:   Thu, 10 Jan 2019 09:46:09 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO fixes for v5.0-rc2
Message-ID: <20190110094609.36eba080@x1.home>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 10 Jan 2019 16:46:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v5.0-rc2

for you to fetch changes up to 58fec830fc19208354895d9832785505046d6c01:

  vfio/type1: Fix unmap overflow off-by-one (2019-01-08 09:31:28 -0700)

----------------------------------------------------------------
VFIO fixes for v5.0-rc2

 - Fix trace header include path for in-tree builds (Masahiro Yamada)

 - Fix overflow in unmap wrap-around test (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/type1: Fix unmap overflow off-by-one

Masahiro Yamada (1):
      vfio/pci: set TRACE_INCLUDE_PATH to fix the build error

 drivers/vfio/pci/trace.h        | 2 +-
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
