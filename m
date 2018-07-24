Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D44AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7CC20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7CC20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbeGXKeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:34:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46054 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388432AbeGXKee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:34:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E06CA7A9;
        Tue, 24 Jul 2018 02:29:00 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B188B3F237;
        Tue, 24 Jul 2018 02:29:00 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4F1011AE3B5E; Tue, 24 Jul 2018 10:29:00 +0100 (BST)
Date:   Tue, 24 Jul 2018 10:29:00 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Paul Kocialkowski <contact@paulk.fr>,
        Laura Abbott <labbott@redhat.com>,
        Greg Hackmann <ghackmann@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: linux-next: manual merge of the arm64 tree with Linus' tree
Message-ID: <20180724092859.GE19324@arm.com>
References: <20180724085015.029efd54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724085015.029efd54@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Jul 24, 2018 at 08:50:15AM +1000, Stephen Rothwell wrote:
> Today's linux-next merge of the arm64 tree got a conflict in:
> 
>   arch/arm64/Makefile
> 
> between commits:
> 
>   38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
>   2893af07e507 ("arm64: add endianness option to LDFLAGS instead of LD")
>   96f95a17c1cf ("Revert "arm64: Use aarch64elf and aarch64elfb emulation mode variants"")
> 
> from Linus' tree and commit:
> 
>   c931d34ea085 ("arm64: build with baremetal linker target instead of Linux when available")
> 
> from the arm64 tree.
> 
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks; that is the correct resolution.

Will
