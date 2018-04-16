Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeDPS2m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:28:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34766 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752417AbeDPS2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:28:41 -0400
From: Christoffer Dall <christoffer.dall@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH] MAINTAINERS: Update e-mail address for Christoffer Dall
Date: Mon, 16 Apr 2018 20:28:31 +0200
Message-Id: <20180416182831.4035-1-christoffer.dall@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my e-mail address to a working address.

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..3e9c99d2620b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7738,7 +7738,7 @@ F:	arch/x86/include/asm/svm.h
 F:	arch/x86/kvm/svm.c
 
 KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
-M:	Christoffer Dall <christoffer.dall@linaro.org>
+M:	Christoffer Dall <christoffer.dall@arm.com>
 M:	Marc Zyngier <marc.zyngier@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	kvmarm@lists.cs.columbia.edu
@@ -7752,7 +7752,7 @@ F:	virt/kvm/arm/
 F:	include/kvm/arm_*
 
 KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
-M:	Christoffer Dall <christoffer.dall@linaro.org>
+M:	Christoffer Dall <christoffer.dall@arm.com>
 M:	Marc Zyngier <marc.zyngier@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	kvmarm@lists.cs.columbia.edu
-- 
2.14.2
