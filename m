Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A5CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D421820844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfBFTdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:33:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBFTdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:33:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BF742D7F8;
        Wed,  6 Feb 2019 19:33:01 +0000 (UTC)
Received: from redhat.com (ovpn-120-196.rdu2.redhat.com [10.10.120.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 45A337C826;
        Wed,  6 Feb 2019 19:32:57 +0000 (UTC)
Date:   Wed, 6 Feb 2019 14:32:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, tiwei.bie@intel.com
Subject: [PULL] virtio: fixes
Message-ID: <20190206143256-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 06 Feb 2019 19:33:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 9c0644ee4aa8792f1e60a2b014b4710faaddafeb:

  virtio: drop internal struct from UAPI (2019-02-05 15:29:48 -0500)

----------------------------------------------------------------
virtio: fixes

A small fix for a uapi header, and a fix for VDPA for non-x86 guests.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      virtio: drop internal struct from UAPI

Tiwei Bie (1):
      virtio: support VIRTIO_F_ORDER_PLATFORM

 drivers/virtio/virtio_ring.c       | 15 ++++++++++++++-
 include/uapi/linux/virtio_config.h |  6 ++++++
 include/uapi/linux/virtio_ring.h   | 10 ----------
 3 files changed, 20 insertions(+), 11 deletions(-)
