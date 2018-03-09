Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeCIGum (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:50:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750926AbeCIGul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:50:41 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: glider@google.com, dvyukov@google.com
Subject: [PATCH net 0/3] Several fixes for vhost_net ptr_ring usage
Date: Fri,  9 Mar 2018 14:50:31 +0800
Message-Id: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This small series try to fix several bugs of ptr_ring usage in
vhost_net. Please review.

Thanks

Alexander Potapenko (1):
  vhost_net: initialize rx_ring in vhost_net_open()

Jason Wang (2):
  vhost_net: keep private_data and rx_ring synced
  vhost_net: examine pointer types during un-producing

 drivers/net/tun.c      | 3 ++-
 drivers/vhost/net.c    | 8 +++++---
 include/linux/if_tun.h | 4 ++++
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.7.4
