Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDSFat (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:30:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752325AbeDSFas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:30:48 -0400
Date: Thu, 19 Apr 2018 08:30:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 net 0/3] virtio: ctrl buffer fixes
Message-ID: <1524115776-334953-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a couple of fixes related to the virtio control buffer.
Lightly tested on x86 only.

Michael S. Tsirkin (3):
  virtio_net: split out ctrl buffer
  virtio_net: fix adding vids on big-endian
  virtio_net: sparse annotation fix

 drivers/net/virtio_net.c | 68 +++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

-- 
MST
