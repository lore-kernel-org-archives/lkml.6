Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7379C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B0820685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B0820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeJaOjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:39:35 -0400
Received: from ozlabs.org ([203.11.71.1]:48123 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeJaOjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:39:35 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42lHLC2mhbz9sNB; Wed, 31 Oct 2018 16:42:59 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 709cf19c5749308603ffa12557d8bd152a926783
In-Reply-To: <231cb98301edd62a0e9f444044ef6ab535733da6.1539931702.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v6,08/20] powerpc/8xx: Use patch_site for perf counters setup
Message-Id: <42lHLC2mhbz9sNB@ozlabs.org>
Date:   Wed, 31 Oct 2018 16:42:59 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-19 at 06:55:08 UTC, Christophe Leroy wrote:
> The 8xx TLB miss routines are patched when (de)activating
> perf counters.
> 
> This patch uses the new patch_site functionality in order
> to get a better code readability and avoid a label mess when
> dumping the code with 'objdump -d'
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/709cf19c5749308603ffa12557d8bd

cheers
