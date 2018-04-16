Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851852-2-13502637373291676980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851851; b=iI+JPN3r7QUeBwJj4wQyomrVI5ZX5CRxVV04itUQKK1VYOg0O2
    oe67XUCX9J3CFkYEj+6cIS8pYFdjJeBxNv80cmIHo6UZNt9IIpuZ3pjwQUs+9mea
    hSan/ASrGgWZjAVkk5PZFbu1ZslHRyDBYrrYCZDo69PIaZBs6j4unr09NKSuOPIO
    B7RyLfgOJyqN1wBCG4EWvvgRHD6uqkpgW2RCv2kQEsPXVcwQ9BG1PAbVT0JmggFA
    fmtrjxjni0tXFehOntIdCvmAgRQRpX/qwZcnBwnV2qrEPsA/hbZ095IJmaYABanl
    oxZxiIoDqUWoD3NN8eczkm5mfKViPHyPNcEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851851; bh=LJKUe
    k11ygpfWhWqJK5bYbQJ8kggK2h5ORj59+anPCo=; b=HI+IZDWOG3cXIYRfuYZG3
    O3qkstEsNvCpzue2Ao3MmfyW76DLIxeIpbbAlow2NwEpVBtjdr+eMlzfIO37HXsQ
    O8AtK3g/5SVTTV8TqXF8XEiNH4UOfKF3BbHmOfQ70JC+UWwM72IwgKdivJJ2Rfrk
    w13udZbNo8YgTJIk8F3y51zCOT77cb3DPgtQfsjXd6E+Zr1Ao+6P2spY0ecqQ321
    lmMfEjD46KF4/+ZjcXLY5myfRaxuwvIXu2BGwzSLvcBt6hF/pzSRpfjGoVbrRtqQ
    8SiSVtwF46iGuFXIC6scSs5dVQzF/6E8F4IkeYV9eoSIHNgPnXtXl7gUWNpgVB3j
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCL2V3RYIYD7elfgA96/iGVVet+81AyU08wdGpUqW6bcVWcCoH2sXDRxPv6pUN7wWTjU8mNddOTV0O6Su4/UOSOaZoZpNQV/4d47QUMtMMPO194OzFCq
    j4PN961hGig0npLbmFdnWKlthPzfC1xKCmunq3tWmv3qhZfx0KevR+4Dk5XFQN8pdsNSLoNGsGNdz0SOku3sKdgOlG2yykMDLKCUf+mvFpVg91PZP4eswZ8f
    AMNXPP/Qug8OTFN+G5Kpvw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=hjNKKv5mXWO2lh6iyfkA:9
    a=lgGzyI8vu2hGKLPg:21 a=MdIJEhqZYSRnxRl2:21 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 16/25] staging: lustre: libcfs: rename cpumask_var_t variables
 to *_mask
Date: Mon, 16 Apr 2018 00:09:58 -0400
Message-Id: <1523851807-16573-17-git-send-email-jsimmons@infradead.org>
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
Cc: Dmitry Eremin <dmitry.eremin@intel.com>,
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

From: Dmitry Eremin <dmitry.eremin@intel.com>

Because we handle both cpu mask as well as core identifiers it can
easily be confused. To avoid this rename various cpumask_var_t to
have appended *_mask to their names.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23222
Reviewed-by: Amir Shehata <amir.shehata@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 62 +++++++++++-----------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index b985b3d..ae5ff58 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -685,23 +685,23 @@ int cfs_cpt_bind(struct cfs_cpt_table *cptab, int cpt)
  * We always prefer to choose CPU in the same core/socket.
  */
 static int cfs_cpt_choose_ncpus(struct cfs_cpt_table *cptab, int cpt,
-				cpumask_t *node, int number)
+				cpumask_t *node_mask, int number)
 {
-	cpumask_var_t socket;
-	cpumask_var_t core;
+	cpumask_var_t socket_mask;
+	cpumask_var_t core_mask;
 	int rc = 0;
 	int cpu;
 
 	LASSERT(number > 0);
 
-	if (number >= cpumask_weight(node)) {
-		while (!cpumask_empty(node)) {
-			cpu = cpumask_first(node);
+	if (number >= cpumask_weight(node_mask)) {
+		while (!cpumask_empty(node_mask)) {
+			cpu = cpumask_first(node_mask);
 
 			rc = cfs_cpt_set_cpu(cptab, cpt, cpu);
 			if (!rc)
 				return -EINVAL;
-			cpumask_clear_cpu(cpu, node);
+			cpumask_clear_cpu(cpu, node_mask);
 		}
 		return 0;
 	}
@@ -711,34 +711,34 @@ static int cfs_cpt_choose_ncpus(struct cfs_cpt_table *cptab, int cpt,
 	 * As we cannot initialize a cpumask_var_t, we need
 	 * to alloc both before we can risk trying to free either
 	 */
-	if (!zalloc_cpumask_var(&socket, GFP_NOFS))
+	if (!zalloc_cpumask_var(&socket_mask, GFP_NOFS))
 		rc = -ENOMEM;
-	if (!zalloc_cpumask_var(&core, GFP_NOFS))
+	if (!zalloc_cpumask_var(&core_mask, GFP_NOFS))
 		rc = -ENOMEM;
 	if (rc)
 		goto out;
 
-	while (!cpumask_empty(node)) {
-		cpu = cpumask_first(node);
+	while (!cpumask_empty(node_mask)) {
+		cpu = cpumask_first(node_mask);
 
 		/* get cpumask for cores in the same socket */
-		cpumask_copy(socket, topology_core_cpumask(cpu));
-		cpumask_and(socket, socket, node);
+		cpumask_copy(socket_mask, topology_core_cpumask(cpu));
+		cpumask_and(socket_mask, socket_mask, node_mask);
 
-		LASSERT(!cpumask_empty(socket));
+		LASSERT(!cpumask_empty(socket_mask));
 
-		while (!cpumask_empty(socket)) {
+		while (!cpumask_empty(socket_mask)) {
 			int i;
 
 			/* get cpumask for hts in the same core */
-			cpumask_copy(core, topology_sibling_cpumask(cpu));
-			cpumask_and(core, core, node);
+			cpumask_copy(core_mask, topology_sibling_cpumask(cpu));
+			cpumask_and(core_mask, core_mask, node_mask);
 
-			LASSERT(!cpumask_empty(core));
+			LASSERT(!cpumask_empty(core_mask));
 
-			for_each_cpu(i, core) {
-				cpumask_clear_cpu(i, socket);
-				cpumask_clear_cpu(i, node);
+			for_each_cpu(i, core_mask) {
+				cpumask_clear_cpu(i, socket_mask);
+				cpumask_clear_cpu(i, node_mask);
 
 				rc = cfs_cpt_set_cpu(cptab, cpt, i);
 				if (!rc) {
@@ -749,13 +749,13 @@ static int cfs_cpt_choose_ncpus(struct cfs_cpt_table *cptab, int cpt,
 				if (!--number)
 					goto out;
 			}
-			cpu = cpumask_first(socket);
+			cpu = cpumask_first(socket_mask);
 		}
 	}
 
 out:
-	free_cpumask_var(socket);
-	free_cpumask_var(core);
+	free_cpumask_var(socket_mask);
+	free_cpumask_var(core_mask);
 	return rc;
 }
 
@@ -806,7 +806,7 @@ static int cfs_cpt_num_estimate(void)
 static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 {
 	struct cfs_cpt_table *cptab = NULL;
-	cpumask_var_t mask;
+	cpumask_var_t node_mask;
 	int cpt = 0;
 	int num;
 	int rc;
@@ -839,15 +839,15 @@ static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 		goto failed;
 	}
 
-	if (!zalloc_cpumask_var(&mask, GFP_NOFS)) {
+	if (!zalloc_cpumask_var(&node_mask, GFP_NOFS)) {
 		CERROR("Failed to allocate scratch cpumask\n");
 		goto failed;
 	}
 
 	for_each_online_node(i) {
-		cpumask_copy(mask, cpumask_of_node(i));
+		cpumask_copy(node_mask, cpumask_of_node(i));
 
-		while (!cpumask_empty(mask)) {
+		while (!cpumask_empty(node_mask)) {
 			struct cfs_cpu_partition *part;
 			int n;
 
@@ -864,7 +864,7 @@ static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 			n = num - cpumask_weight(part->cpt_cpumask);
 			LASSERT(n > 0);
 
-			rc = cfs_cpt_choose_ncpus(cptab, cpt, mask, n);
+			rc = cfs_cpt_choose_ncpus(cptab, cpt, node_mask, n);
 			if (rc < 0)
 				goto failed_mask;
 
@@ -882,12 +882,12 @@ static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 		goto failed_mask;
 	}
 
-	free_cpumask_var(mask);
+	free_cpumask_var(node_mask);
 
 	return cptab;
 
 failed_mask:
-	free_cpumask_var(mask);
+	free_cpumask_var(node_mask);
 failed:
 	CERROR("Failed to setup CPU-partition-table with %d CPU-partitions, online HW nodes: %d, HW cpus: %d.\n",
 	       ncpt, num_online_nodes(), num_online_cpus());
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
