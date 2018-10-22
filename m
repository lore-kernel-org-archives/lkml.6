Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D2EC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529D42083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529D42083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeJVRx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:53:27 -0400
Received: from ozlabs.org ([203.11.71.1]:50611 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeJVRx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:53:27 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42drwp1c0Hz9sDF; Mon, 22 Oct 2018 20:35:37 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b38a181c11d0b5e84b40732dbb06cc9d68140d60
In-Reply-To: <af8fe0a5bebd1745ceec07813fa55f1569930f2b.1533151550.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v5, 1/3] powerpc/time: isolate scaled cputime accounting in dedicated functions.
Message-Id: <42drwp1c0Hz9sDF@ozlabs.org>
Date:   Mon, 22 Oct 2018 20:35:37 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 07:53:57 UTC, Christophe Leroy wrote:
> scaled cputime is only meaningfull when the processor has
> SPURR and/or PURR, which means only on PPC64.
> 
> In preparation of the following patch that will remove
> CONFIG_ARCH_HAS_SCALED_CPUTIME on PPC32, this patch moves
> all scaled cputing accounting logic into dedicated functions.
> 
> This patch doesn't change any functionality. It's only code
> reorganisation.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b38a181c11d0b5e84b40732dbb06cc

cheers
