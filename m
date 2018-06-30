Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B7AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFBB24916
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 14:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFBB24916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeF3OzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 10:55:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751155AbeF3OzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 10:55:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5UErVjo124339
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jx5v4t9dy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:55:18 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 30 Jun 2018 15:55:16 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 15:55:13 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5UEtCbv30081120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 14:55:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EF645204F;
        Sat, 30 Jun 2018 15:55:00 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.205.240])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 80B5E52050;
        Sat, 30 Jun 2018 15:54:58 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Sat, 30 Jun 2018 17:55:10 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 01/11] mm/bootmem: drop duplicated kernel-doc comments
Date:   Sat, 30 Jun 2018 17:54:56 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18063014-0016-0000-0000-000001E1E349
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063014-0017-0000-0000-0000323632AA
Message-Id: <1530370506-21751-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts of the bootmem interfaces are duplicated in nobootmem.c along with
the kernel-doc comments. There is no point to keep two copies of the
comments, so let's drop the bootmem.c copy.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/bootmem.c | 102 -----------------------------------------------------------
 1 file changed, 102 deletions(-)

diff --git a/mm/bootmem.c b/mm/bootmem.c
index 9e19798..42ab0da 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -143,15 +143,6 @@ unsigned long __init init_bootmem(unsigned long start, unsigned long pages)
 	return init_bootmem_core(NODE_DATA(0)->bdata, start, 0, pages);
 }
 
-/*
- * free_bootmem_late - free bootmem pages directly to page allocator
- * @addr: starting physical address of the range
- * @size: size of the range in bytes
- *
- * This is only useful when the bootmem allocator has already been torn
- * down, but we are still initializing the system.  Pages are given directly
- * to the page allocator, no bootmem metadata is updated because it is gone.
- */
 void __init free_bootmem_late(unsigned long physaddr, unsigned long size)
 {
 	unsigned long cursor, end;
@@ -264,11 +255,6 @@ void __init reset_all_zones_managed_pages(void)
 	reset_managed_pages_done = 1;
 }
 
-/**
- * free_all_bootmem - release free pages to the buddy allocator
- *
- * Returns the number of pages actually released.
- */
 unsigned long __init free_all_bootmem(void)
 {
 	unsigned long total_pages = 0;
@@ -385,16 +371,6 @@ static int __init mark_bootmem(unsigned long start, unsigned long end,
 	BUG();
 }
 
-/**
- * free_bootmem_node - mark a page range as usable
- * @pgdat: node the range resides on
- * @physaddr: starting address of the range
- * @size: size of the range in bytes
- *
- * Partial pages will be considered reserved and left as they are.
- *
- * The range must reside completely on the specified node.
- */
 void __init free_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
 			      unsigned long size)
 {
@@ -408,15 +384,6 @@ void __init free_bootmem_node(pg_data_t *pgdat, unsigned long physaddr,
 	mark_bootmem_node(pgdat->bdata, start, end, 0, 0);
 }
 
-/**
- * free_bootmem - mark a page range as usable
- * @physaddr: starting physical address of the range
- * @size: size of the range in bytes
- *
- * Partial pages will be considered reserved and left as they are.
- *
- * The range must be contiguous but may span node boundaries.
- */
 void __init free_bootmem(unsigned long physaddr, unsigned long size)
 {
 	unsigned long start, end;
@@ -646,19 +613,6 @@ static void * __init ___alloc_bootmem_nopanic(unsigned long size,
 	return NULL;
 }
 
-/**
- * __alloc_bootmem_nopanic - allocate boot memory without panicking
- * @size: size of the request in bytes
- * @align: alignment of the region
- * @goal: preferred starting address of the region
- *
- * The goal is dropped if it can not be satisfied and the allocation will
- * fall back to memory below @goal.
- *
- * Allocation may happen on any node in the system.
- *
- * Returns NULL on failure.
- */
 void * __init __alloc_bootmem_nopanic(unsigned long size, unsigned long align,
 					unsigned long goal)
 {
@@ -682,19 +636,6 @@ static void * __init ___alloc_bootmem(unsigned long size, unsigned long align,
 	return NULL;
 }
 
-/**
- * __alloc_bootmem - allocate boot memory
- * @size: size of the request in bytes
- * @align: alignment of the region
- * @goal: preferred starting address of the region
- *
- * The goal is dropped if it can not be satisfied and the allocation will
- * fall back to memory below @goal.
- *
- * Allocation may happen on any node in the system.
- *
- * The function panics if the request can not be satisfied.
- */
 void * __init __alloc_bootmem(unsigned long size, unsigned long align,
 			      unsigned long goal)
 {
@@ -754,21 +695,6 @@ void * __init ___alloc_bootmem_node(pg_data_t *pgdat, unsigned long size,
 	return NULL;
 }
 
-/**
- * __alloc_bootmem_node - allocate boot memory from a specific node
- * @pgdat: node to allocate from
- * @size: size of the request in bytes
- * @align: alignment of the region
- * @goal: preferred starting address of the region
- *
- * The goal is dropped if it can not be satisfied and the allocation will
- * fall back to memory below @goal.
- *
- * Allocation may fall back to any node in the system if the specified node
- * can not hold the requested memory.
- *
- * The function panics if the request can not be satisfied.
- */
 void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size,
 				   unsigned long align, unsigned long goal)
 {
@@ -807,19 +733,6 @@ void * __init __alloc_bootmem_node_high(pg_data_t *pgdat, unsigned long size,
 
 }
 
-/**
- * __alloc_bootmem_low - allocate low boot memory
- * @size: size of the request in bytes
- * @align: alignment of the region
- * @goal: preferred starting address of the region
- *
- * The goal is dropped if it can not be satisfied and the allocation will
- * fall back to memory below @goal.
- *
- * Allocation may happen on any node in the system.
- *
- * The function panics if the request can not be satisfied.
- */
 void * __init __alloc_bootmem_low(unsigned long size, unsigned long align,
 				  unsigned long goal)
 {
@@ -834,21 +747,6 @@ void * __init __alloc_bootmem_low_nopanic(unsigned long size,
 					ARCH_LOW_ADDRESS_LIMIT);
 }
 
-/**
- * __alloc_bootmem_low_node - allocate low boot memory from a specific node
- * @pgdat: node to allocate from
- * @size: size of the request in bytes
- * @align: alignment of the region
- * @goal: preferred starting address of the region
- *
- * The goal is dropped if it can not be satisfied and the allocation will
- * fall back to memory below @goal.
- *
- * Allocation may fall back to any node in the system if the specified node
- * can not hold the requested memory.
- *
- * The function panics if the request can not be satisfied.
- */
 void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, unsigned long size,
 				       unsigned long align, unsigned long goal)
 {
-- 
2.7.4

