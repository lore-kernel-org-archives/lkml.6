Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09ADC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960FA2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAYVRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:17:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfAYVRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:17:25 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5646DE3E0A;
        Fri, 25 Jan 2019 21:17:25 +0000 (UTC)
Received: from x1.home (ovpn-116-182.phx2.redhat.com [10.3.116.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1608461520;
        Fri, 25 Jan 2019 21:17:25 +0000 (UTC)
Date:   Fri, 25 Jan 2019 14:17:24 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO fixes for v5.0-rc4
Message-ID: <20190125141724.4e5c446b@x1.home>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 25 Jan 2019 21:17:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v5.0-rc4

for you to fetch changes up to 9a71ac7e15a723e90fc40388b4b92eefaabf747c:

  vfio-pci/nvlink2: Fix ancient gcc warnings (2019-01-23 08:20:43 -0700)

----------------------------------------------------------------
VFIO fixes for v5.0-rc4

 - Cleanup licenses in new files (Thomas Gleixner)

 - Cleanup new compiler warnings (Alexey Kardashevskiy)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      vfio-pci/nvlink2: Fix ancient gcc warnings

Thomas Gleixner (1):
      vfio/pci: Cleanup license mess

 drivers/vfio/pci/trace.h            |  6 +-----
 drivers/vfio/pci/vfio_pci_nvlink2.c | 36 ++++++++++++++++--------------------
 2 files changed, 17 insertions(+), 25 deletions(-)
