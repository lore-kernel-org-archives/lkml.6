Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A8CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDAB20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDAB20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeGUP7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 11:59:01 -0400
Received: from foss.arm.com ([217.140.101.70]:46574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbeGUP7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 11:59:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2BE18A;
        Sat, 21 Jul 2018 08:05:58 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41733F778;
        Sat, 21 Jul 2018 08:05:57 -0700 (PDT)
Date:   Sat, 21 Jul 2018 16:05:53 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoffer Dall <cdall@cs.columbia.edu>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the kvm-arm
 tree
Message-ID: <20180721160553.3cd29fe0@why.wild-wind.fr.eu.org>
In-Reply-To: <20180722003152.447551b1@canb.auug.org.au>
References: <20180722003152.447551b1@canb.auug.org.au>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jul 2018 00:31:52 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

Hi Stephen,

> Hi all,
> 
> Commit
> 
>   9904b113fb90 ("KVM: arm/arm64: Fix vgic init race")
> 
> is missing a Signed-off-by from its committer.

Thanks for spotting this. Now fixed and pushed out again.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.
