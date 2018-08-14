Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B22C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884EE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884EE2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbeHNFnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:43:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbeHNFny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:43:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 113352125A4E2;
        Tue, 14 Aug 2018 10:58:46 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Tue, 14 Aug 2018 10:58:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tony.luck@intel.com>, <fenghua.yu@intel.com>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <oleg@redhat.com>, <rppt@linux.vnet.ibm.com>,
        <dhowells@redhat.com>, <akpm@linux-foundation.org>,
        <viro@zeniv.linux.org.uk>
CC:     <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/2] Use ARRAY_SIZE to replace its implementation
Date:   Tue, 14 Aug 2018 10:46:52 +0800
Message-ID: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue is detected with the help of Coccinelle.

zhong jiang (2):
  ia64: Use ARRAY_SIZE to replace its implementation
  powerpc: Use ARRAY_SIZE to replace its implementation

 arch/ia64/kernel/perfmon.c  |  2 +-
 arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

-- 
1.7.12.4

