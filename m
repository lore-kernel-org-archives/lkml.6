Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeD3JIY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:08:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753152AbeD3JIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:08:12 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [PATCH v5 12/12] KVM: arm/arm64: Bump VGIC_V3_MAX_CPUS to 512
Date: Mon, 30 Apr 2018 11:07:44 +0200
Message-Id: <1525079264-25533-13-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1525079264-25533-1-git-send-email-eric.auger@redhat.com>
References: <1525079264-25533-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's raise the number of supported vcpus along with
vgic v3 now that HW is looming with more physical CPUs.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>

---

v4 -> v5:
- addded Christoffer's A-b
---
 include/kvm/arm_vgic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index dc55ee8..2eac942 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -28,7 +28,7 @@
 
 #include <linux/irqchip/arm-gic-v4.h>
 
-#define VGIC_V3_MAX_CPUS	255
+#define VGIC_V3_MAX_CPUS	512
 #define VGIC_V2_MAX_CPUS	8
 #define VGIC_NR_IRQS_LEGACY     256
 #define VGIC_NR_SGIS		16
-- 
2.5.5
