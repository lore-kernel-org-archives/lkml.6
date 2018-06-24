Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CCEC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315C824EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315C824EBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeFXLe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:34:28 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52538 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeFXLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:34:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 0771C28CCB;
        Sun, 24 Jun 2018 07:34:23 -0400 (EDT)
Date:   Sun, 24 Jun 2018 21:35:18 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver
 problems
In-Reply-To: <cover.1528885172.git.fthain@telegraphics.com.au>
Message-ID: <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018, I wrote:

> Finn Thain (12):
>   macintosh/via-pmu: Fix section mismatch warning
>   macintosh/via-pmu: Add missing mmio accessors
>   macintosh/via-pmu: Don't clear shift register interrupt flag twice
>   macintosh/via-pmu: Enhance state machine with new 'uninitialized'
>     state
>   macintosh/via-pmu: Replace via pointer with via1 and via2 pointers
>   macintosh/via-pmu: Add support for m68k PowerBooks
>   macintosh/via-pmu: Make CONFIG_PPC_PMAC Kconfig deps explicit
>   macintosh/via-pmu68k: Don't load driver on unsupported hardware
>   macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
>   macintosh: Use common code to access RTC
>   macintosh/via-pmu: Clean up interrupt statistics
>   macintosh/via-pmu: Disambiguate interrupt statistics
> 

Patch 10/12 ("macintosh: Use common code to access RTC") conflicts with 
Arnd's RTC work, but the rest of this series can still be reviewed and 
merged as-is.

I will rewrite patch 10/12 after Arnd's fixes and this series have all 
made their way through both powerpc and m68k trees, and submit it 
separately.

Thanks.

-- 
