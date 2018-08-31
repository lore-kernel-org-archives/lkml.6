Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B9DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72A32083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72A32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeHaMHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:07:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727233AbeHaMHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:07:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C9E87DAC2;
        Fri, 31 Aug 2018 08:01:25 +0000 (UTC)
Received: from 192.168.1.3 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A2A710876A;
        Fri, 31 Aug 2018 08:01:22 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     jglisse@redhat.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH] docs/vm/hmm.rst: Add missed space
Date:   Fri, 31 Aug 2018 16:01:19 +0800
Message-Id: <20180831080119.6522-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 31 Aug 2018 08:01:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 31 Aug 2018 08:01:25 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This space missing caused the colour scheme in vim editor messy
after that line. Add it to fix.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/vm/hmm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index cdf3911582c8..63e8d44c4fba 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -194,7 +194,7 @@ use either::
                       unsigned long start,
                       unsigned long end,
                       hmm_pfn_t *pfns);
- int hmm_vma_fault(struct vm_area_struct *vma,
+  int hmm_vma_fault(struct vm_area_struct *vma,
                    struct hmm_range *range,
                    unsigned long start,
                    unsigned long end,
-- 
2.13.6

