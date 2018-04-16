Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523912016; cv=none;
        d=google.com; s=arc-20160816;
        b=vOE7zlvecnfU4+ETRWCp2eksZK41V9Qlvuls88wTIeic88EbsEkA6c+hE9GSld2TyZ
         G+u2N1nr+g0NGcafISx8jgCwN8S8tiuzk6qEv2Y4sNo20eQelg8EphyUpcYP+gpEiiI9
         njL4xD2fPWVqp0yiiTuBnxaJGlv/BhZsfGnq4wPgv6aIBeFhtUm/u4yOIyylzeQYveWi
         3/hE9sYgoRETS3useyUpddl9Nu9IRkFZBNjRYQdBNKUIBcrHv7pkpgYJ9QVjGaYj46fM
         pQXNHyh7jW+elW2DNDzIugtC7+T4q1CJlVsrVtfXEt1wGWKXGRECZ3Wxjt9jUR1MibL1
         eL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=oKyZsRtdqGdCCBxR58nrOY5LCqgTPu214VikLsFrL0U=;
        b=sPmne3f226Rpf7xbP1d8quTpBOUZrOLf2OvkVjktp/051WC077JOMAXoWL8Laep6b2
         vnVKE5y5QGnhEUO4mbcPotEwGTvxDZn/NYWgmJSdzpfYJ81oR0PyVLaVCnNwWm34MsZd
         bfFihVsBVvFCNZmlSz0yGcF3ZbYGLqSRMW0NSwXFG3+xAXopJkDQPViROIcC03c52ISD
         JQPXQbrhzYCoJgCVV6ucIUj5CqVszGdJGwBIgrRUUETwwP1TIYLBriS4YQPeG6pUJETF
         xs+t68dj/x7ApSZEtZskObXpK85dsqmkO/B8Oom0NSj4dV9e+X5UNppyF+4PS94YsLl1
         AXnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=VIuURp9Z;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=VIuURp9Z;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx48jS28E1RVALG6+BVVZRdwml4y5IPDdK6ajDA4AJX8pj0mRw+bze8lm27pIsqeW+cDzmasb6A==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	jolsa@redhat.com,
	alexander.shishkin@linux.intel.com,
	namhyung@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf tools: coresight: Moving to SPDX identifier
Date: Mon, 16 Apr 2018 14:53:33 -0600
Message-Id: <1523912013-29331-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597937566509126674?=
X-GMAIL-MSGID: =?utf-8?q?1597937566509126674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Moving perf tools CoreSight support to the SPDX identifier.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/include/linux/coresight-pmu.h             | 13 +------------
 tools/perf/arch/arm/util/auxtrace.c             | 13 +------------
 tools/perf/arch/arm/util/cs-etm.c               | 13 +------------
 tools/perf/arch/arm/util/cs-etm.h               | 13 +------------
 tools/perf/arch/arm/util/pmu.c                  | 13 +------------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  3 +--
 tools/perf/util/cs-etm.c                        |  3 +--
 tools/perf/util/cs-etm.h                        | 13 +------------
 8 files changed, 8 insertions(+), 76 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index edfeaba95429..a1a959ba24ff 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _LINUX_CORESIGHT_PMU_H
diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index fa639e3e52ac..1ce6bdbda561 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <stdbool.h>
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 5c655ad4621e..2f595cd73da6 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <api/fs/fs.h>
diff --git a/tools/perf/arch/arm/util/cs-etm.h b/tools/perf/arch/arm/util/cs-etm.h
index 5256741be549..1a12e64f5127 100644
--- a/tools/perf/arch/arm/util/cs-etm.h
+++ b/tools/perf/arch/arm/util/cs-etm.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef INCLUDE__PERF_CS_ETM_H__
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index ac4dffc807b8..e047571e6080 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <string.h>
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 640af88331b4..c8b98fa22997 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * SPDX-License-Identifier: GPL-2.0
- *
  * Copyright(C) 2015-2018 Linaro Limited.
  *
  * Author: Tor Jeremiassen <tor@ti.com>
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1b0d422373be..40020b1ca54f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * SPDX-License-Identifier: GPL-2.0
- *
  * Copyright(C) 2015-2018 Linaro Limited.
  *
  * Author: Tor Jeremiassen <tor@ti.com>
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 5864d5dca616..37f8d48179ca 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -1,18 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef INCLUDE__UTIL_PERF_CS_ETM_H__
-- 
2.7.4
