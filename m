Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DCFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9745F22522
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F8jByxE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9745F22522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeKBIqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:46:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57754 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeKBIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HJ5k3QlzdEmj+GQC4/fLMMUMGoRO8JTowgk0si9Dr2E=; b=F8jByxE9OyauRHOpqtkIjRYhLE
        FbJ3p7oCcM+w7rU314GtlnLNbWmkedwpwlniMI7KiAkbJh5u4OVnjhcQpp/eaXFfnUkuoNzgUhgIK
        4i+7ctKsur82Trgx3wG2EirbuWWpXfUzC1IsaQI6YS2GQXBimrEJVir+hvu6RLhljn9QaRe39thOw
        IDFvpyjUtp1J4lxY8Lw/J2+bsQqQToHvWjXieC6EbUClyE3PQa0C7XlR2eiq0RG9pjYwk/cNxVlb0
        YCZCkxYh4NGMqbld4c/4lE75RPQlyYhSA62OJT1sxd/mr0/pxJkbYD0oTZS1LxjVQb0eHWSrBTk1o
        0b5vZf6Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIMaG-0000ma-DD; Thu, 01 Nov 2018 23:41:04 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH resend] w1: add missing kernel-doc entry for of_match_table
Message-ID: <60723da5-8ef1-80bf-8b30-95e87173c884@infradead.org>
Date:   Thu, 1 Nov 2018 16:41:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning for missing struct member description:

../include/linux/w1.h:281: warning: Function parameter or member 'of_match_table' not described in 'w1_family'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Evgeniy Polyakov <zbr@ioremap.net>
---
 include/linux/w1.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20181101.orig/include/linux/w1.h
+++ linux-next-20181101/include/linux/w1.h
@@ -266,6 +266,7 @@ struct w1_family_ops {
  * @family_entry:	family linked list
  * @fid:		8 bit family identifier
  * @fops:		operations for this family
+ * @of_match_table:	Open Firmware device matching table
  * @refcnt:		reference counter
  */
 struct w1_family {


