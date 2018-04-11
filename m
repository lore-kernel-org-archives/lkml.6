Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934845AbeDKTKU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:10:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756888AbeDKTKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:10:17 -0400
Date: Wed, 11 Apr 2018 22:10:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.helman@oracle.com, mst@redhat.com
Subject: [PULL] virtio: feature pull
Message-ID: <20180411212644-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dc32bb678e103afbcfa4d814489af0566307f528:

  vhost: add vsock compat ioctl (2018-03-20 03:17:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6c64fe7f2adcee21d7c4247f1ec021fd18428fc4:

  virtio_balloon: export hugetlb page allocation counts (2018-04-10 21:23:55 +0300)

----------------------------------------------------------------
virtio: feature

This adds reporting hugepage stats to virtio-balloon.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jonathan Helman (1):
      virtio_balloon: export hugetlb page allocation counts

 drivers/virtio/virtio_balloon.c     | 6 ++++++
 include/uapi/linux/virtio_balloon.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)
