Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeCVXAg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:00:36 -0400
Received: from valbonne.lhuard.fr ([88.182.161.122]:49708 "EHLO mail.lhuard.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751715AbeCVXA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:00:28 -0400
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
From: =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH] kvm_config: add CONFIG_VIRTIO_MENU
Date: Thu, 22 Mar 2018 23:53:05 +0100
Message-Id: <20180322225305.10780-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that make kvmconfig enables all the virtio drivers even if it is
preceded by a make allnoconfig.

Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
---
 kernel/configs/kvm_guest.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/configs/kvm_guest.config b/kernel/configs/kvm_guest.config
index 108fecc20fc1..208481d91090 100644
--- a/kernel/configs/kvm_guest.config
+++ b/kernel/configs/kvm_guest.config
@@ -20,6 +20,7 @@ CONFIG_PARAVIRT=y
 CONFIG_KVM_GUEST=y
 CONFIG_S390_GUEST=y
 CONFIG_VIRTIO=y
+CONFIG_VIRTIO_MENU=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_VIRTIO_CONSOLE=y
-- 
2.16.2
