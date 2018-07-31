Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84264C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4257220844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4257220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeGaSCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:02:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60106 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbeGaSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:02:17 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkXOU-0007j1-CD; Tue, 31 Jul 2018 18:21:07 +0200
Date:   Tue, 31 Jul 2018 18:21:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     zhong jiang <zhongjiang@huawei.com>
cc:     longman@redhat.com, yang.shi@linux.alibaba.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/sg_pool,debugobjects: remove unnecessary null check
 when free the object
In-Reply-To: <1533052519-34372-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <alpine.DEB.2.21.1807311820180.1610@nanos.tec.linutronix.de>
References: <1533052519-34372-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018, zhong jiang wrote:

> kmem_cache_destroy/mempool_destroy has taken null check into account.
> so remove the redundant check.

Please split the patch so they can be applied independently by the relevant
maintainers.

Thanks,

	tglx
