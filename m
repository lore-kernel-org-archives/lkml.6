Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523911866; cv=none;
        d=google.com; s=arc-20160816;
        b=wevcn3BBx2QImEQ9roFnacyE6U1bIk2l7GW1gwOAdSmOW7r8kmdB/4o0cir56sfYu2
         rXAKRg3UXsT5DwTsykbPdPujvlwZlnXwAc5MX0OQA0P1cl7ZI31ssU9cx2tThMgirLUT
         urYi+P/FrGj3RcWWIz20aDR2OtPt/FO93vYB/56n8K6cxRnGuQvIeUuXBW12/KSJUClT
         x7quY3NNmSC1EMupOn/bVJhHvIR1pzfEJYQ3t87/Ji5taajWZvDIfeWJ5xkddnoWTD9O
         ARUoRYQBhOgGsGO85aoIS9Oi0nLBzqPz2eDr6NxK/IaXYIwHVNRsZiUkBIQxdaB09AFe
         w09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=1dWx2lGV6aace7JjWpLcoiKUy/uiZdflLwbNbgCbuag=;
        b=ydzwsKJCDRJscVxuQP5hM8+17A+udpYbZTozfSHfQBEmao1NptNUz7GpNa1he8EfGU
         ma+/dbpLxoXLE4YxdHKEPNXsBwlxO4YmC06stc1g+rOt2j+QpqyXIuTXSsZZJQSwkiyi
         RRHN1zBr6lyziMCd/bYnesK7+bK6rR6WZdT+PUNWPgbYYpiUqzwSgEDevI8FqQ1L7Opt
         6bcIToXaxCNTy0+E6zXmBEGV+LnDkt7dsfSUTyZ5FSE9lV0rNyMUv/mCn7UIG8nbU3D9
         xZbCY3PYHHPZ08UYguOjGznIQc8Sohk9eOME/1za1ULFo9BFFPuxoRoAa/4YIDCW99Nj
         GpZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=AL6G4E9h;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=AL6G4E9h;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49B78BkSsYwlTjsA2Zjc8jzkygf0udjbyU7LRmMbkSWi2qs7N6Z9d4pEUGoxsJ6ZOA9KIKJ+A==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: alexander.shishkin@linux.intel.com,
	gregkh@linuxfoundation.org,
	leo.yan@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: Moving framework and drivers to SPDX identifier
Date: Mon, 16 Apr 2018 14:51:02 -0600
Message-Id: <1523911862-29218-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597937409545454672?=
X-GMAIL-MSGID: =?utf-8?q?1597937409545454672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Moving all kernel side CoreSight framework and drivers to SPDX identifier.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c          | 14 +-------------
 drivers/hwtracing/coresight/coresight-dynamic-replicator.c | 10 +---------
 drivers/hwtracing/coresight/coresight-etb10.c              | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm-cp14.c           | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm-perf.c           | 13 +------------
 drivers/hwtracing/coresight/coresight-etm-perf.h           | 13 +------------
 drivers/hwtracing/coresight/coresight-etm.h                | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c        | 13 +------------
 drivers/hwtracing/coresight/coresight-etm3x.c              | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c        | 13 +------------
 drivers/hwtracing/coresight/coresight-etm4x.c              | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm4x.h              | 13 +++----------
 drivers/hwtracing/coresight/coresight-funnel.c             | 13 +++----------
 drivers/hwtracing/coresight/coresight-priv.h               | 13 +++----------
 drivers/hwtracing/coresight/coresight-replicator.c         | 13 +++----------
 drivers/hwtracing/coresight/coresight-stm.c                | 13 +++----------
 drivers/hwtracing/coresight/coresight-tmc-etf.c            | 13 +------------
 drivers/hwtracing/coresight/coresight-tmc-etr.c            | 13 +------------
 drivers/hwtracing/coresight/coresight-tmc.c                | 10 +---------
 drivers/hwtracing/coresight/coresight-tmc.h                | 13 +------------
 drivers/hwtracing/coresight/coresight-tpiu.c               | 13 +++----------
 drivers/hwtracing/coresight/coresight.c                    | 13 +++----------
 drivers/hwtracing/coresight/of_coresight.c                 | 13 +++----------
 include/linux/coresight-pmu.h                              | 13 +------------
 include/linux/coresight.h                                  | 13 +++----------
 25 files changed, 53 insertions(+), 267 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 9cdb3fbc8c1f..33d2470b0595 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -1,20 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2017 Linaro Limited. All rights reserved.
  *
  * Author: Leo Yan <leo.yan@linaro.org>
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
- *
  */
 #include <linux/amba/bus.h>
 #include <linux/coresight.h>
diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 043da86b0fe9..f6d0571ab9dd 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/amba/bus.h>
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 580cd381adf3..9b6c55523c58 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -1,15 +1,8 @@
-/* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
  * Description: CoreSight Embedded Trace Buffer driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <asm/local.h>
diff --git a/drivers/hwtracing/coresight/coresight-etm-cp14.c b/drivers/hwtracing/coresight/coresight-etm-cp14.c
index 12a220682117..4174a8d355d2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-cp14.c
+++ b/drivers/hwtracing/coresight/coresight-etm-cp14.c
@@ -1,13 +1,6 @@
-/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012, The Linux Foundation. All rights reserved.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 4e5ed6597f2f..677695635211 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
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
 
 #include <linux/coresight.h>
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 3ffc9feb2d64..4197df4faf5e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
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
 
 #ifndef _CORESIGHT_ETM_PERF_H
diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 70b0a248c321..e8b4549e30e2 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -1,13 +1,6 @@
-/* Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
  */
 
 #ifndef _CORESIGHT_CORESIGHT_ETM_H
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 6e547ec6fead..9435c1481f61 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
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
 
 #include <linux/pm_runtime.h>
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 39f42fdd503d..15ed64d51a5b 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -1,15 +1,8 @@
-/* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
  * Description: CoreSight Program Flow Trace driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index d21961710713..4eb8da785ce0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
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
 
 #include <linux/pm_runtime.h>
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index cf364a514c12..9bc04c50d45b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1,13 +1,6 @@
-/* Copyright (c) 2014, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index b3b5ea7b7fb3..b7c4a6f6c6b9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1,13 +1,6 @@
-/* Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
  */
 
 #ifndef _CORESIGHT_CORESIGHT_ETM_H
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 9f8ac0bef853..448145a36675 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -1,15 +1,8 @@
-/* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
  * Description: CoreSight Funnel driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index f1d0e21d8cab..0e5a74dae6a6 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -1,13 +1,6 @@
-/* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  */
 
 #ifndef _CORESIGHT_PRIV_H
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 3756e71cb8f5..8d2eaaab6c2f 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -1,15 +1,8 @@
-/* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
  * Description: CoreSight Replicator driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 15e7ef3891f5..c46c70aec1d5 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -1,16 +1,9 @@
-/* Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
  *
  * Description: CoreSight System Trace Macrocell driver
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Initial implementation by Pratik Patel
  * (C) 2014-2015 Pratik Patel <pratikp@codeaurora.org>
  *
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e2513b786242..61d849b11c26 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright(C) 2016 Linaro Limited. All rights reserved.
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
 
 #include <linux/circ_buf.h>
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index cd8407cb4843..3ce734a75149 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright(C) 2016 Linaro Limited. All rights reserved.
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
 
 #include <linux/circ_buf.h>
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 0ea04f588de0..456f122df74f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2012, The Linux Foundation. All rights reserved.
  *
  * Description: CoreSight Trace Memory Controller driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 8df7a813f537..dfaff077a7fc 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
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
 
 #ifndef _CORESIGHT_TMC_H
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 805f7c2210fe..01b7457fe8fc 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -1,15 +1,8 @@
-/* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
  *
  * Description: CoreSight Trace Port Interface Unit driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 132dfbcd90c1..29e834aab539 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1,13 +1,6 @@
-/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 7c375443ede6..a33a92ebe74b 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -1,13 +1,6 @@
-/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/types.h>
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
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d950dad5056a..c265e0468414 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -1,13 +1,6 @@
-/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012, The Linux Foundation. All rights reserved.
  */
 
 #ifndef _LINUX_CORESIGHT_H
-- 
2.7.4
