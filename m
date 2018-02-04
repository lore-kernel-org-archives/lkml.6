Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeBDP1U (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 10:27:20 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46754 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeBDP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 10:27:16 -0500
X-Google-Smtp-Source: AH8x227/vmG7l0aY1tECiKF6W7pv29TbNbCd4BBNe5yRFisxrb5Xj/eTUCltCSqXQAQ6NijWtsjwhET39oIa0U24oi4=
MIME-Version: 1.0
From: Kangmin Park <l4stpr0gr4m@gmail.com>
Date: Mon, 5 Feb 2018 00:27:15 +0900
Message-ID: <CAKW4uUwZdgyJ7Xzyx4SCKhC3R4Er_aSGSSRxg=go2tRQfzSveg@mail.gmail.com>
Subject: [PATCH] Fix a misspelling in kernel/cpu.c
To: trivial@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch to fix a typo in kernel/cpu.c
Fix 'synchronsization' to 'synchronization'

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
Cc: Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 53f7dc6..9a1ee53 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1336,7 +1336,7 @@ static struct cpuhp_step cpuhp_ap_states[] = {
  .teardown.single = smpcfd_dying_cpu,
  },
  /* Entry state on starting. Interrupts enabled from here on. Transient
- * state for synchronsization */
+ * state for synchronization */
  [CPUHP_AP_ONLINE] = {
  .name = "ap:online",
  },
