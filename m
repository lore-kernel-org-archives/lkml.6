Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0998EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CE520817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CE520817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeK0FFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:05:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40344 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0FFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:05:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D8CC814E908FE;
        Mon, 26 Nov 2018 10:00:49 -0800 (PST)
Date:   Mon, 26 Nov 2018 10:00:46 -0800 (PST)
Message-Id: <20181126.100046.860156356512347227.davem@davemloft.net>
To:     andrew.murray@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, will.deacon@arm.com,
        mark.rutland@arm.com, benh@kernel.crashing.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, linux-s390@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH v2 16/20] sparc: perf/core: advertise PMU exclusion
 capability
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1543230756-15319-17-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
        <1543230756-15319-17-git-send-email-andrew.murray@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 26 Nov 2018 10:00:50 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:32 +0000

> The SPARC PMU has the capability to exclude events based on context
>  - let's advertise that we support the PERF_PMU_CAP_EXCLUDE
> capability to ensure that perf doesn't prevent us from handling
> events where any exclusion flags are set.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
