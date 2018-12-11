Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D636C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9F82081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9F82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeLKKQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:16:24 -0500
Received: from foss.arm.com ([217.140.101.70]:43448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKKQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:16:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C19015AD;
        Tue, 11 Dec 2018 02:16:23 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C53D3F6A8;
        Tue, 11 Dec 2018 02:16:22 -0800 (PST)
Date:   Tue, 11 Dec 2018 10:16:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20181211101619.GA35824@arrakis.emea.arm.com>
References: <20181211085257.6e689038@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211085257.6e689038@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 08:52:57AM +1100, Stephen Rothwell wrote:
> Today's linux-next merge of the arm64 tree got conflicts in:
> 
>   Documentation/arm64/silicon-errata.txt
>   arch/arm64/Kconfig
> 
> between commit:
> 
>   ce8c80c536da ("arm64: Add workaround for Cortex-A76 erratum 1286807")
> 
> from Linus' tree and commit:
> 
>   a457b0f7f50d ("arm64: Add configuration/documentation for Cortex-A76 erratum 1165522")
> 
> from the arm64 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

It looks fine. Thanks Stephen.

-- 
Catalin
