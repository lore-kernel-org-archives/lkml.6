Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeCIC5f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:57:35 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43740 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeCIC5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:57:33 -0500
X-Google-Smtp-Source: AG47ELvA2woftJ7eMnKgRjfMYTI2DpdgcQyOZZ6JUcwp9I6rxMkgzagrzQkBgbIrFV+6gZiASxR/VA==
From: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
To: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vaibhav Murkute <vaibhavmurkute88@gmail.com>
Subject: [PATCH] drivers: vhost: vsock: fixed a brace coding style issue
Date: Fri,  9 Mar 2018 08:26:03 +0530
Message-Id: <20180309025603.4890-1-vaibhavmurkute88@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
---
 drivers/vhost/vsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0d14e2ff19f1..0898dbdbf955 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -61,9 +61,9 @@ static struct vhost_vsock *__vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid) {
+		if (other_cid == guest_cid)
 			return vsock;
-		}
+
 	}
 
 	return NULL;
-- 
2.15.1
