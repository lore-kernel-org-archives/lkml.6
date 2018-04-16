Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523851844-5-6080017025719579652
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523851844; b=T5li2Ae4hx3sr+QZsJAkZL01XCwGDDwkFmm5ZXFetrlfI+v/ie
    EIHhG9aNF9rIEZv/PEKkL1xzlJBrQlWbhW0x2QHVTJVpRy4ySmAX7zjjJK584E6M
    BMwrFn//+st3y5RYBebqUvGiQfXU0sjjfCGBj9f2hcQAP7FEinJJeYIUPbcIx+51
    TIj0hXXZzxKTQ9FqS+N564BHycDY+8glA96P4Iur1A2j+3CNVBZ0Eu4CF+O+24YQ
    P0Sq23M7pA8hGDix6AE97nzOqwAj1hpydHknv6+mnOC2r9vDAuIt0TbEZB8To3ag
    6IXiINdqX+zqomvOkZLmkWFohv4u+Qmbeyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523851844; bh=A3PEf
    UhSzkH3jgo+WO2NF/a3SgTah5SDmKvvbgUjeq4=; b=fFNhsYjpt5DgRMwpHH8uf
    ajZPoP6WlvP9O5R5xwO6r6nC4vfKvoPh/Hg4QYhMpZfZafNr5x1VF4ssBq3wYo6J
    Uy3wlBifpthDiHOHEHW48Q8VjPLK9owjjLgKPu+yHt5Kw1Ozd5AkvY0VLqRoiBWj
    jI2/kHC1GImBFokzi07UNco7hRAGvvrO+Jwb/jvfGkJHBZWiG3O5YE4QDD30yYYq
    13MiM8IhvRWRgNMEU/YbvdcA9QKQK9Xc4/iTbTWt5Rh92q1OomAjRBuj9Os2NxgP
    cdN50kUy9c5d63W+9k8fS+xo2A/mPq/cIRsO527DsbKJu6jaI+E8TeI26PmQw4D3
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFAZKGo6+FI2OJjiyl9oItOZZ+kWzd8Wk27FEQDNpSwJHtGOLtxNafTEO8WG4onDOSlwHiYOpr0/vuF00lZh2zRMo6wSySWq6BzAM1MPT8KZ9payGGeG
    yvPQQ5sFHNUesaXwQC/AZTXVr+wmER6lD2sNafr5on27VVRrVSqHYvFkkPE4eTgbIEnMB2eFmlwznylXug/UPSZDXLSaicT07UuPg+wg6Kst9r4eqpM/OpWa
    A2733rQ7kLETXYfMvzyXIA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=9cLgPyd7LPRN3kqq6_AA:9
    a=aUYrX1u0RaSG7HJa:21 a=0trOBwbBfrR6HmLk:21 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 20/25] staging: lustre: libcfs: make tolerant to offline CPUs
 and empty NUMA nodes
Date: Mon, 16 Apr 2018 00:10:02 -0400
Message-Id: <1523851807-16573-21-git-send-email-jsimmons@infradead.org>
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

Rework CPU partition code in the way of make it more tolerant to
offline CPUs and empty nodes.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23222
Reviewed-by: Amir Shehata <amir.shehata@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 .../lustre/include/linux/libcfs/linux/linux-cpu.h  |   2 +
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 132 +++++++++------------
 drivers/staging/lustre/lnet/lnet/lib-msg.c         |   2 +
 3 files changed, 60 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
index b3bc4e7..ed4351b 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
@@ -56,6 +56,8 @@ struct cfs_cpu_partition {
 	unsigned int			*cpt_distance;
 	/* spread rotor for NUMA allocator */
 	int				 cpt_spread_rotor;
+	/* NUMA node if cpt_nodemask is empty */
+	int				 cpt_node;
 };
 
 /** descriptor for CPU partitions */
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
index 32ebd0f..80db008 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
@@ -427,8 +427,16 @@ int cfs_cpt_set_cpu(struct cfs_cpt_table *cptab, int cpt, int cpu)
 		return 0;
 	}
 
-	LASSERT(!cpumask_test_cpu(cpu, cptab->ctb_cpumask));
-	LASSERT(!cpumask_test_cpu(cpu, cptab->ctb_parts[cpt].cpt_cpumask));
+	if (cpumask_test_cpu(cpu, cptab->ctb_cpumask)) {
+		CDEBUG(D_INFO, "CPU %d is already in cpumask\n", cpu);
+		return 0;
+	}
+
+	if (cpumask_test_cpu(cpu, cptab->ctb_parts[cpt].cpt_cpumask)) {
+		CDEBUG(D_INFO, "CPU %d is already in partition %d cpumask\n",
+		       cpu, cptab->ctb_cpu2cpt[cpu]);
+		return 0;
+	}
 
 	cfs_cpt_add_cpu(cptab, cpt, cpu);
 	cfs_cpt_add_node(cptab, cpt, cpu_to_node(cpu));
@@ -497,8 +505,10 @@ void cfs_cpt_unset_cpumask(struct cfs_cpt_table *cptab, int cpt,
 {
 	int cpu;
 
-	for_each_cpu(cpu, mask)
-		cfs_cpt_unset_cpu(cptab, cpt, cpu);
+	for_each_cpu(cpu, mask) {
+		cfs_cpt_del_cpu(cptab, cpt, cpu);
+		cfs_cpt_del_node(cptab, cpt, cpu_to_node(cpu));
+	}
 }
 EXPORT_SYMBOL(cfs_cpt_unset_cpumask);
 
@@ -549,10 +559,8 @@ int cfs_cpt_set_nodemask(struct cfs_cpt_table *cptab, int cpt,
 {
 	int node;
 
-	for_each_node_mask(node, *mask) {
-		if (!cfs_cpt_set_node(cptab, cpt, node))
-			return 0;
-	}
+	for_each_node_mask(node, *mask)
+		cfs_cpt_set_node(cptab, cpt, node);
 
 	return 1;
 }
@@ -573,7 +581,7 @@ int cfs_cpt_spread_node(struct cfs_cpt_table *cptab, int cpt)
 	nodemask_t *mask;
 	int weight;
 	int rotor;
-	int node;
+	int node = 0;
 
 	/* convert CPU partition ID to HW node id */
 
@@ -583,20 +591,20 @@ int cfs_cpt_spread_node(struct cfs_cpt_table *cptab, int cpt)
 	} else {
 		mask = cptab->ctb_parts[cpt].cpt_nodemask;
 		rotor = cptab->ctb_parts[cpt].cpt_spread_rotor++;
+		node  = cptab->ctb_parts[cpt].cpt_node;
 	}
 
 	weight = nodes_weight(*mask);
-	LASSERT(weight > 0);
-
-	rotor %= weight;
+	if (weight > 0) {
+		rotor %= weight;
 
-	for_each_node_mask(node, *mask) {
-		if (!rotor--)
-			return node;
+		for_each_node_mask(node, *mask) {
+			if (!rotor--)
+				return node;
+		}
 	}
 
-	LBUG();
-	return 0;
+	return node;
 }
 EXPORT_SYMBOL(cfs_cpt_spread_node);
 
@@ -689,17 +697,21 @@ static int cfs_cpt_choose_ncpus(struct cfs_cpt_table *cptab, int cpt,
 	cpumask_var_t core_mask;
 	int rc = 0;
 	int cpu;
+	int i;
 
 	LASSERT(number > 0);
 
 	if (number >= cpumask_weight(node_mask)) {
 		while (!cpumask_empty(node_mask)) {
 			cpu = cpumask_first(node_mask);
+			cpumask_clear_cpu(cpu, node_mask);
+
+			if (!cpu_online(cpu))
+				continue;
 
 			rc = cfs_cpt_set_cpu(cptab, cpt, cpu);
 			if (!rc)
 				return -EINVAL;
-			cpumask_clear_cpu(cpu, node_mask);
 		}
 		return 0;
 	}
@@ -720,24 +732,19 @@ static int cfs_cpt_choose_ncpus(struct cfs_cpt_table *cptab, int cpt,
 		cpu = cpumask_first(node_mask);
 
 		/* get cpumask for cores in the same socket */
-		cpumask_copy(socket_mask, topology_core_cpumask(cpu));
-		cpumask_and(socket_mask, socket_mask, node_mask);
-
-		LASSERT(!cpumask_empty(socket_mask));
-
+		cpumask_and(socket_mask, topology_core_cpumask(cpu), node_mask);
 		while (!cpumask_empty(socket_mask)) {
-			int i;
-
 			/* get cpumask for hts in the same core */
-			cpumask_copy(core_mask, topology_sibling_cpumask(cpu));
-			cpumask_and(core_mask, core_mask, node_mask);
-
-			LASSERT(!cpumask_empty(core_mask));
+			cpumask_and(core_mask, topology_sibling_cpumask(cpu),
+				    node_mask);
 
 			for_each_cpu(i, core_mask) {
 				cpumask_clear_cpu(i, socket_mask);
 				cpumask_clear_cpu(i, node_mask);
 
+				if (!cpu_online(i))
+					continue;
+
 				rc = cfs_cpt_set_cpu(cptab, cpt, i);
 				if (!rc) {
 					rc = -EINVAL;
@@ -806,23 +813,18 @@ static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 	struct cfs_cpt_table *cptab = NULL;
 	cpumask_var_t node_mask;
 	int cpt = 0;
+	int node;
 	int num;
-	int rc;
-	int i;
+	int rem;
+	int rc = 0;
 
-	rc = cfs_cpt_num_estimate();
+	num = cfs_cpt_num_estimate();
 	if (ncpt <= 0)
-		ncpt = rc;
+		ncpt = num;
 
-	if (ncpt > num_online_cpus() || ncpt > 4 * rc) {
+	if (ncpt > num_online_cpus() || ncpt > 4 * num) {
 		CWARN("CPU partition number %d is larger than suggested value (%d), your system may have performance issue or run out of memory while under pressure\n",
-		      ncpt, rc);
-	}
-
-	if (num_online_cpus() % ncpt) {
-		CERROR("CPU number %d is not multiple of cpu_npartition %d, please try different cpu_npartitions value or set pattern string by cpu_pattern=STRING\n",
-		       (int)num_online_cpus(), ncpt);
-		goto failed;
+		      ncpt, num);
 	}
 
 	cptab = cfs_cpt_table_alloc(ncpt);
@@ -831,55 +833,33 @@ static struct cfs_cpt_table *cfs_cpt_table_create(int ncpt)
 		goto failed;
 	}
 
-	num = num_online_cpus() / ncpt;
-	if (!num) {
-		CERROR("CPU changed while setting CPU partition\n");
-		goto failed;
-	}
-
 	if (!zalloc_cpumask_var(&node_mask, GFP_NOFS)) {
 		CERROR("Failed to allocate scratch cpumask\n");
 		goto failed;
 	}
 
-	for_each_online_node(i) {
-		cpumask_copy(node_mask, cpumask_of_node(i));
-
-		while (!cpumask_empty(node_mask)) {
-			struct cfs_cpu_partition *part;
-			int n;
-
-			/*
-			 * Each emulated NUMA node has all allowed CPUs in
-			 * the mask.
-			 * End loop when all partitions have assigned CPUs.
-			 */
-			if (cpt == ncpt)
-				break;
-
-			part = &cptab->ctb_parts[cpt];
+	num = num_online_cpus() / ncpt;
+	rem = num_online_cpus() % ncpt;
+	for_each_online_node(node) {
+		cpumask_copy(node_mask, cpumask_of_node(node));
 
-			n = num - cpumask_weight(part->cpt_cpumask);
-			LASSERT(n > 0);
+		while (cpt < ncpt && !cpumask_empty(node_mask)) {
+			struct cfs_cpu_partition *part = &cptab->ctb_parts[cpt];
+			int ncpu = cpumask_weight(part->cpt_cpumask);
 
-			rc = cfs_cpt_choose_ncpus(cptab, cpt, node_mask, n);
+			rc = cfs_cpt_choose_ncpus(cptab, cpt, node_mask,
+						  num - ncpu);
 			if (rc < 0)
 				goto failed_mask;
 
-			LASSERT(num >= cpumask_weight(part->cpt_cpumask));
-			if (num == cpumask_weight(part->cpt_cpumask))
+			ncpu = cpumask_weight(part->cpt_cpumask);
+			if (ncpu == num + !!(rem > 0)) {
 				cpt++;
+				rem--;
+			}
 		}
 	}
 
-	if (cpt != ncpt ||
-	    num != cpumask_weight(cptab->ctb_parts[ncpt - 1].cpt_cpumask)) {
-		CERROR("Expect %d(%d) CPU partitions but got %d(%d), CPU hotplug/unplug while setting?\n",
-		       cptab->ctb_nparts, num, cpt,
-		       cpumask_weight(cptab->ctb_parts[ncpt - 1].cpt_cpumask));
-		goto failed_mask;
-	}
-
 	free_cpumask_var(node_mask);
 
 	return cptab;
diff --git a/drivers/staging/lustre/lnet/lnet/lib-msg.c b/drivers/staging/lustre/lnet/lnet/lib-msg.c
index 0091273..27bdefa 100644
--- a/drivers/staging/lustre/lnet/lnet/lib-msg.c
+++ b/drivers/staging/lustre/lnet/lnet/lib-msg.c
@@ -568,6 +568,8 @@
 
 	/* number of CPUs */
 	container->msc_nfinalizers = cfs_cpt_weight(lnet_cpt_table(), cpt);
+	if (container->msc_nfinalizers == 0)
+		container->msc_nfinalizers = 1;
 
 	container->msc_finalizers = kvzalloc_cpt(container->msc_nfinalizers *
 						 sizeof(*container->msc_finalizers),
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
