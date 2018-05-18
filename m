Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZoHLVtwq7Sgupk4IrFIGn7HZzJxHnFyoIHTm+krUGYUUe5NAvuQoSX7IW7XwCYwJ3h3VQk0
ARC-Seal: i=1; a=rsa-sha256; t=1526606469; cv=none;
        d=google.com; s=arc-20160816;
        b=I4gH2jeR5miIPgPbAJnNlJSkWa35zWB9bTuuFUOlUCkQgCq75O2nCUy8/MtbD3AtKd
         zX31lgLbKL/ChfYiTdZAKYWWVMfY2h6h/FJH2J3y+8+hGmeSTU4IY6Kca2yHyp9h1YKn
         EKKfBJCuH0TRb/lJVpcLJ9NuRkT8SN1e/Rx0nyPoYpFEmWMMf01GlQ6SVWQQ8/E5QhHr
         lv4n7EzjJIk110byY5NJ3LJcaVfI1p2bO7Rn4d3HYjmw8NWu/5Wq1GFwEqT5T4h4y8fK
         Nz0KvJZdpNDU6a1QR0QUZ6Dsw5jXJilPfCwJ2yGcDFrI2ZWUdhj5M+QIcEF3k0ejTck0
         +lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=1nsEQo3NH4qaYd86P45h7XmoamFOCPs5PMQVRBUFuGc=;
        b=Cq/9cMcmFXSUe5npFUo+bBVbFeuRtsu/kxn9puSg+D+Ylv0nhgeO5MJkK6PqzkOjBJ
         XL/xEnCzDWQCnLGftJXV9o+YVzNbp/esW7Yl0rOnegaLabh7RphhYgRxgyIi8traAjIG
         ++S8DBmphFI/+43TMcvWQN9dPzjoCea3bRyPqDRUYMY7MS+DdJFIa0IHIGXKrUG7PBcq
         E2zwGWtRlLlWvmCGTgqlTFXc08M+19igOootUNIa6vvrwvXkzAUg8tQchSSFQBDmrx71
         8OHi8OgOAEVrAzWwihKW+M4zoQY/SdR0oWNQG2DA5qHwRBlVrKmA38o3jKFzU/C+25S0
         ENMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
From: Kim Phillips <kim.phillips@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>,
	Todd Kjos <tkjos@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH 5/6] coresight: populate MODULE_AUTHOR, DESCRIPTION, and LICENSEs
Date: Thu, 17 May 2018 20:20:23 -0500
Message-Id: <20180518012024.22645-5-kim.phillips@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518012024.22645-1-kim.phillips@arm.com>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600762905490701914?=
X-GMAIL-MSGID: =?utf-8?q?1600762905490701914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Necessary prior to enabling to be built as modules.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/coresight-dynamic-replicator.c | 4 ++++
 drivers/hwtracing/coresight/coresight-etb10.c              | 5 +++++
 drivers/hwtracing/coresight/coresight-etm-cp14.c           | 4 ++++
 drivers/hwtracing/coresight/coresight-etm-perf.c           | 4 ++++
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c        | 5 +++++
 drivers/hwtracing/coresight/coresight-etm3x.c              | 5 +++++
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c        | 4 ++++
 drivers/hwtracing/coresight/coresight-etm4x.c              | 5 +++++
 drivers/hwtracing/coresight/coresight-funnel.c             | 4 ++++
 drivers/hwtracing/coresight/coresight-replicator.c         | 5 +++++
 drivers/hwtracing/coresight/coresight-stm.c                | 4 ++++
 drivers/hwtracing/coresight/coresight-tmc-etf.c            | 4 ++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c            | 4 ++++
 drivers/hwtracing/coresight/coresight-tmc.c                | 4 ++++
 drivers/hwtracing/coresight/coresight-tpiu.c               | 5 +++++
 drivers/hwtracing/coresight/coresight.c                    | 4 ++++
 16 files changed, 70 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index f6d0571ab9dd..fc742215ab05 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -210,3 +210,7 @@ static struct amba_driver replicator_driver = {
 	.id_table	= replicator_ids,
 };
 builtin_amba_driver(replicator_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("ARM Coresight Dynamic Replicator Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 9b6c55523c58..a3dac5a8b37c 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -758,3 +758,8 @@ static struct amba_driver etb_driver = {
 	.id_table	= etb_ids,
 };
 builtin_amba_driver(etb_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Embedded Trace Buffer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm-cp14.c b/drivers/hwtracing/coresight/coresight-etm-cp14.c
index 4174a8d355d2..68ca423aa088 100644
--- a/drivers/hwtracing/coresight/coresight-etm-cp14.c
+++ b/drivers/hwtracing/coresight/coresight-etm-cp14.c
@@ -582,3 +582,7 @@ int etm_writel_cp14(u32 reg, u32 val)
 
 	return 0;
 }
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight ETM CP14 driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 677695635211..ad0ef8d27111 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -494,3 +494,7 @@ static int __init etm_perf_init(void)
 	return ret;
 }
 device_initcall(etm_perf_init);
+
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight tracer perf driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 75487b3fad86..91a2a23143d8 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -1294,3 +1294,8 @@ const struct attribute_group *coresight_etm_groups[] = {
 	&coresight_etm_mgmt_group,
 	NULL,
 };
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace sysfs driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 7c74263c333d..7ca73a15c735 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -935,3 +935,8 @@ static struct amba_driver etm_driver = {
 	.id_table	= etm_ids,
 };
 builtin_amba_driver(etm_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a0365e23678e..577a38673444 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2173,3 +2173,7 @@ const struct attribute_group *coresight_etmv4_groups[] = {
 	&coresight_etmv4_trcidr_group,
 	NULL,
 };
+
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace v4 sysfs driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 9bc04c50d45b..ba10f5302a55 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1073,3 +1073,8 @@ static struct amba_driver etm4x_driver = {
 	.id_table	= etm4_ids,
 };
 builtin_amba_driver(etm4x_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace v4 driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 448145a36675..1e497a75b956 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -261,3 +261,7 @@ static struct amba_driver funnel_driver = {
 	.id_table	= funnel_ids,
 };
 builtin_amba_driver(funnel_driver);
+
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("ARM Coresight Funnel Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 8d2eaaab6c2f..9ef539893eaa 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -154,3 +154,8 @@ static struct platform_driver replicator_driver = {
 	},
 };
 builtin_platform_driver(replicator_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("ARM Coresight Replicator Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index c46c70aec1d5..30eae52a8757 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -934,3 +934,7 @@ static struct amba_driver stm_driver = {
 };
 
 builtin_amba_driver(stm_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight System Trace Macrocell driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 61d849b11c26..94cd6c00fcc9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -617,3 +617,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 
 	return 0;
 }
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller ETB/ETF mode driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 02f747afa2ba..e612896e92a7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -330,3 +330,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 
 	return 0;
 }
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller ETR mode driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 456f122df74f..176a5aeab20e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -463,3 +463,7 @@ static struct amba_driver tmc_driver = {
 	.id_table	= tmc_ids,
 };
 builtin_amba_driver(tmc_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 01b7457fe8fc..f3b154e150b3 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -218,3 +218,8 @@ static struct amba_driver tpiu_driver = {
 	.id_table	= tpiu_ids,
 };
 builtin_amba_driver(tpiu_driver);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight TPIU (Trace Port Interface Unit) driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 0cbc2948defc..406899f316e4 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1041,3 +1041,7 @@ void coresight_unregister(struct coresight_device *csdev)
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
+
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("ARM Coresight Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
