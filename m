Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DDFC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039F220989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039F220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLGNHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:07:16 -0500
Received: from ozlabs.org ([203.11.71.1]:60717 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeLGNHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:07:14 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43BCRg312Mz9s55; Sat,  8 Dec 2018 00:07:10 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f99e33f12490d03e34e1b9cb1b3e3a8beff34ae5
X-Patchwork-Hint: ignore
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [1/7] drivers/cpufreq: change CONFIG_6xx to CONFIG_PPC_BOOK3S_32
Message-Id: <43BCRg312Mz9s55@ozlabs.org>
Date:   Sat,  8 Dec 2018 00:07:10 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-17 at 10:24:54 UTC, Christophe Leroy wrote:
> Today, powerpc has three CONFIG labels which means exactly the same:
> - CONFIG_6xx
> - CONFIG_PPC_BOOK3S_32
> - CONFIG_PPC_STD_MMU_32
> 
> By consistency with PPC64, CONFIG_PPC_BOOK3S_32 is the preferred one.
> Using a label with includes _PPC_ also makes it clearer that it is
> linked to powerpc.
> 
> In preparation of the removal of CONFIG_6xx, this patch replaces it
> by CONFIG_PPC_BOOK3S_32
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f99e33f12490d03e34e1b9cb1b3e3a

cheers
