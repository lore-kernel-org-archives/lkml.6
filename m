Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1629C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A165E20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A165E20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeJAUSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:18:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49222 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbeJAUSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:18:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A81A7A9;
        Mon,  1 Oct 2018 06:40:21 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.Emea.Arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62D0B3F5B7;
        Mon,  1 Oct 2018 06:40:20 -0700 (PDT)
Date:   Mon, 1 Oct 2018 14:40:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     zhong jiang <zhongjiang@huawei.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/2] arm64: remove some extra semicolon
Message-ID: <20181001134017.GF25071@arrakis.emea.arm.com>
References: <1533824441-35661-1-git-send-email-zhongjiang@huawei.com>
 <20180903165934.GK6954@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903165934.GK6954@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 05:59:35PM +0100, Will Deacon wrote:
> On Thu, Aug 09, 2018 at 10:20:39PM +0800, zhong jiang wrote:
> > There are some extra semicolon in arm64 architecture. Just remove them.
> 
> These are trivial but certainly not urgent, so I guess Catalin can pick
> them up for 4.20.
> 
> Will
> 
> > zhong jiang (2):
> >   arm64/kprobes: remove an extra semicolon in arch_prepare_kprobe
> >   arm64:guest: remove some extra semicolon in kvm_target_cpu

I picked up the first patch. I'll leave the second to Marc in case there
are any conflicts with the kvm tree.

In case it got lost in inbox, here's the second patch.

https://lore.kernel.org/lkml/1533824441-35661-3-git-send-email-zhongjiang@huawei.com/raw

-- 
Catalin
