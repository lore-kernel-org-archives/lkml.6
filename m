Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE247C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DF0218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAYMGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:06:19 -0500
Received: from foss.arm.com ([217.140.101.70]:46164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAYMGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:06:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CFC4EBD;
        Fri, 25 Jan 2019 04:06:18 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0C93F5AF;
        Fri, 25 Jan 2019 04:06:17 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:06:16 +0100
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/3] KVM: arm/arm64: trivial header path sanitization
Message-ID: <20190125120616.GB18654@e113682-lin.lund.arm.com>
References: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 04:57:27PM +0900, Masahiro Yamada wrote:
> My main motivation is to get rid of crappy header search path manipulation
> from Kbuild core.
> 
> Before that, I want to finish as many cleanup works as possible.
> 
> If you are interested in the big picture of this work,
> the full patch set is available at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test

Changes appear fine to me:

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
