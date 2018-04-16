Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523851826-5-4499112796668742057
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851825; b=h1T7+7Aas45aUHYOzp3oz4iaHncQY40p6OffDZWOx1Y+dxDj+a
    jylUc2tZEVF3idhMy/mQYvJfV/rbdMnO22m+icU6NUTXFiXrxII+pRw+4Mat3tCu
    V7TvaUZVtpswHAH59UjbOW2t58Qatnbru8b2V9D8P5wOxDTHr7r2qary1os5Zeb8
    jy70mUECc2t669wOVqG8mzZbSscpSB9IUJ3H7/rWX+/3y1+hUa+hrsNn3s7TMVte
    p9CxpzoL0UKg85L1y7SCzB1H6MgXlqmrOe5qNpTsEM/SnMmpCI5V3LIo/TagANni
    E2tAXSRDIVbN1hjA4KeZq0Ge3sKhEetqK8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851825; bh=dHX3x
    M4axeSm+vbfumvh8UytQJ/odSNakU6dlYKbjHA=; b=ZOjVvZF7UHAfBY2MqZ+uZ
    kDPpVXRiZTAWQdTt4SzD13Oa+wzZ3QMikXtMnJOTlYr1Mqg1YB2w8g3Yvqn9tExD
    7k8AjLdncmRhNTwvrAlInwkWhHWl5KlsRGL9MUPYqyBEE4g6Y9x95sjO/+DFCJCt
    RjES+nePWaa/QMeHFxJwRcS/enmkPzR8skWqvrp/HXcH4t5uoN1G95AuyyhBMrti
    aAYimNjFQimI2S098RWRbkucvbQEe6zRWG8eiUxlma8JxTMiGkrfyE6olhS7ag73
    jqDD6x4FyUsL3nsdZZcmhueetzPdyhNchUt62Xrc/sxlkbIUMeIdOZcfIcCWmNWG
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPaVhze3BdRqruK729zm+rs0FcCGcWJgD/LQ9966MDHfqhVlIDRJXg1eFb1Gv689icASnSacWhWsTm8F+8OEh0EEbfoJez+zbda/antGgIr0dH9p221L
    1BTdHgcTXYE+UQbZAdUolwQX5KlxChaqRS7KXoxmqBmFXG6sH9LAm65HyyXgJo6Biuy0O4+xQtAuBTCfxwsUhobEoMHazKIjqilzfFdHRzH6dusbJFYI2G5Y
    882+gAQgn80QLNH1PRhWdw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=eJfxgxciAAAA:8 a=HHGDD-5mAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=-s2RG-BQnL5Cj9S9gskA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=xM9caqqi1sUkTy8OJ5Uh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 03/25] staging: lustre: libcfs: implement cfs_cpt_cpumask for
 UMP case
Date: Mon, 16 Apr 2018 00:09:45 -0400
Message-Id: <1523851807-16573-4-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
References: <1523851807-16573-1-git-send-email-jsimmons@infradead.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Amir Shehata <amir.shehata@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Amir Shehata <amir.shehata@intel.com>

The function cfs_cpt_cpumask() exist for SMP systems but when
CONFIG_SMP is disabled it only returns NULL. Fill in this missing
function. Also properly initialize ctb_mask for the UMP
case.

Signed-off-by: Amir Shehata <amir.shehata@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
Reviewed-on: http://review.whamcloud.com/18916
Reviewed-by: Olaf Weber <olaf@sgi.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h | 16 +++++-----------
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c          |  9 +++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
index 1f2cd78..070f8fe 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
@@ -77,10 +77,6 @@
 
 #ifdef CONFIG_SMP
 /**
- * return cpumask of CPU partition \a cpt
- */
-cpumask_var_t *cfs_cpt_cpumask(struct cfs_cpt_table *cptab, int cpt);
-/**
  * print string information of cpt-table
  */
 int cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len);
@@ -89,19 +85,13 @@ struct cfs_cpt_table {
 	/* # of CPU partitions */
 	int			ctb_nparts;
 	/* cpu mask */
-	cpumask_t		ctb_mask;
+	cpumask_var_t		ctb_mask;
 	/* node mask */
 	nodemask_t		ctb_nodemask;
 	/* version */
 	u64			ctb_version;
 };
 
-static inline cpumask_var_t *
-cfs_cpt_cpumask(struct cfs_cpt_table *cptab, int cpt)
-{
-	return NULL;
-}
-
 static inline int
 cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
 {
@@ -133,6 +123,10 @@ struct cfs_cpt_table {
  */
 int cfs_cpt_online(struct cfs_cpt_table *cptab, int cpt);
 /**
+ * return cpumask of CPU partition \a cpt
+ */
+cpumask_var_t *cfs_cpt_cpumask(struct cfs_cpt_table *cptab, int cpt);
+/**
  * return nodemask of CPU partition \a cpt
  */
 nodemask_t *cfs_cpt_nodemask(struct cfs_cpt_table *cptab, int cpt);
diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index 705abf2..5ea294f 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -54,6 +54,9 @@ struct cfs_cpt_table *
 	cptab = kzalloc(sizeof(*cptab), GFP_NOFS);
 	if (cptab) {
 		cptab->ctb_version = CFS_CPU_VERSION_MAGIC;
+		if (!zalloc_cpumask_var(&cptab->ctb_mask, GFP_NOFS))
+			return NULL;
+		cpumask_set_cpu(0, cptab->ctb_mask);
 		node_set(0, cptab->ctb_nodemask);
 		cptab->ctb_nparts  = ncpt;
 	}
@@ -108,6 +111,12 @@ struct cfs_cpt_table *
 }
 EXPORT_SYMBOL(cfs_cpt_online);
 
+cpumask_var_t *cfs_cpt_cpumask(struct cfs_cpt_table *cptab, int cpt)
+{
+	return &cptab->ctb_mask;
+}
+EXPORT_SYMBOL(cfs_cpt_cpumask);
+
 nodemask_t *
 cfs_cpt_nodemask(struct cfs_cpt_table *cptab, int cpt)
 {
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
