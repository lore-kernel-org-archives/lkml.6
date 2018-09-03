Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802EDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8AC20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8AC20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeICVUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:20:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59122 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbeICVUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:20:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4A5E18A;
        Mon,  3 Sep 2018 09:59:21 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8621D3F5BC;
        Mon,  3 Sep 2018 09:59:21 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 450D61AE3046; Mon,  3 Sep 2018 17:59:35 +0100 (BST)
Date:   Mon, 3 Sep 2018 17:59:35 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     zhong jiang <zhongjiang@huawei.com>, catalin.marinas@arm.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: remove some extra semicolon
Message-ID: <20180903165934.GK6954@arm.com>
References: <1533824441-35661-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533824441-35661-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 10:20:39PM +0800, zhong jiang wrote:
> There are some extra semicolon in arm64 architecture. Just remove them.

These are trivial but certainly not urgent, so I guess Catalin can pick
them up for 4.20.

Will

> zhong jiang (2):
>   arm64/kprobes: remove an extra semicolon in arch_prepare_kprobe
>   arm64:guest: remove some extra semicolon in kvm_target_cpu
> 
>  arch/arm64/kernel/probes/kprobes.c | 2 +-
>  arch/arm64/kvm/guest.c             | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 1.7.12.4
> 
