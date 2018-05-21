Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeEUIfP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:35:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751088AbeEUIfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:35:12 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] Fix several issues of virtio-net mergeable XDP
Date: Mon, 21 May 2018 16:35:02 +0800
Message-Id: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Please review the patches that tries to fix sevreal issues of
virtio-net mergeable XDP.

Thanks

Jason Wang (4):
  virtio-net: correctly redirect linearized packet
  virtio-net: correctly transmit XDP buff after linearizing
  virtio-net: reset num_buf to 1 after linearizing packet
  virito-net: fix leaking page for gso packet during mergeable XDP

 drivers/net/virtio_net.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.7.4
