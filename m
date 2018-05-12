Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbeELB3D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 21:29:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37600 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELB3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 21:29:02 -0400
X-Google-Smtp-Source: AB8JxZqafV+2FgV/SmURdu7PxcPLgYnv1HfavrorWP/6W8Emas6O2GripDJfAf7KHoeykU+IassYsw==
Date: Fri, 11 May 2018 18:29:00 -0700
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com
Subject: [PATCH] rcu: trace: Remove Startedleaf from trace events comment
Message-ID: <20180512012900.GA183767@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the gp_seq clean up, the Startleaf condition doesn't occur
anymore. Remove it from the comment in the trace event file.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index ce9d1a1cac78..6d8dd04912d2 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -91,7 +91,6 @@ TRACE_EVENT(rcu_grace_period,
  *
  * "Startleaf": Request a grace period based on leaf-node data.
  * "Prestarted": Someone beat us to the request
- * "Startedleaf": Leaf-node start proved sufficient.
  * "Startedleafroot": Leaf-node start proved sufficient after checking root.
  * "Startedroot": Requested a nocb grace period based on root-node data.
  * "NoGPkthread": The RCU grace-period kthread has not yet started.
-- 
2.17.0.441.gb46fe60e1d-goog
