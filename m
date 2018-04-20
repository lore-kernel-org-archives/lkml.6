Return-Path: <acme@kernel.org>
X-Google-Smtp-Source: AIpwx4/B3kGwSNisNWfUsxX/GsdaYOF4NNGzMqwLbRHPG+FbKNDH518QDpk++OCypLSSJ467prKR
ARC-Seal: i=1; a=rsa-sha256; t=1524234826; cv=none;
        d=google.com; s=arc-20160816;
        b=lL4NGEIB9yE+lqpXoJMwEXqWtWVpxkOYASesLskcQZzRErmAy8YEcAzKHHc2etKCf1
         l2lM1tCsw0TmMG81kpxdPvLyt/iwx4BE11d7Bay+5qZ3zCnMMZB9aHZSit8bb3/EqUyX
         xx+363ibTZsjai/p3cGIJ8WURf3yto3gyyZnUnZYdnFp+PhDNZWGQuvzQTcxQjS2FrqM
         rmn+W5sV51ABjOKTWEn0qWRhKSDsaAQTSyDl3u5t7hgcP+27IdejC8/hRlbh1XLPH8vD
         baw/sfDPI/HNoaqlGS8wL7LmFBVrDSXwfde553vVqdEHP+WPyzQEHMV4uoI8+EKd58NR
         AQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=FmLgtAm794KkapOslqZbhD1ct5m+GjRQVHWkwhFRflo=;
        b=D1jcKQcONSx8SpK1soUFBMnMVLd2lsN7jeK+IymLsYQ+6kBa3epFcpxUTmJpJvuD7y
         QkBV1h9dXN/J0v+g6UmVF+s8ICFL7inXDul/60/Si6ZgsWwHRXPnbG6Er8AP7chC6u6k
         D1aS++pywyMzgZCl7JAcjWqPBaFT3AEbtiZFeEdAOsdpNaGMLUXVtvVkl88aDY3jsApY
         5T3Mc0uREgPJOU8TFU8I44jr7NfX0+vqb5xZEmkH3ZYL3xk1pK+3t8o3nxO6c6lOj+yF
         wqWK6XTW6BCE/zI1uDrgyb0EdTjWogXq+1/cuwE8GDHjtkqnLPzjZA7JSVi5jcbWSP0O
         9Ieg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of acme@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=acme@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of acme@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=acme@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911D6217D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/17] coresight: Move to SPDX identifier
Date: Fri, 20 Apr 2018 11:32:27 -0300
Message-Id: <20180420143227.16030-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598276057981436359?=
X-GMAIL-MSGID: =?utf-8?q?1598276057981436359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Move CoreSight headers to the SPDX identifier.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1524089118-27595-1-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/coresight-pmu.h                   | 13 +------------
 tools/include/linux/coresight-pmu.h             | 13 +------------
 tools/perf/arch/arm/util/auxtrace.c             | 13 +------------
 tools/perf/arch/arm/util/cs-etm.c               | 13 +------------
 tools/perf/arch/arm/util/cs-etm.h               | 13 +------------
 tools/perf/arch/arm/util/pmu.c                  | 13 +------------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  3 +--
 tools/perf/util/cs-etm.c                        |  3 +--
 tools/perf/util/cs-etm.h                        | 13 +------------
 9 files changed, 9 insertions(+), 88 deletions(-)

diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index edfeaba95429..a1a959ba24ff 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
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
2.14.3
