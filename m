Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4927EC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B721738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7B721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeHMOGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:06:05 -0400
Received: from ozlabs.org ([203.11.71.1]:51401 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbeHMOEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:49 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptcy5T89z9sBJ; Mon, 13 Aug 2018 21:22:58 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: eab00a208eb63d863b6cc0a03f68b4424ef5add8
In-Reply-To: <20180404200836.27446-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,03/19] powerpc: Move `path` variable inside DEBUG_PROM
Message-Id: <41ptcy5T89z9sBJ@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:22:58 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 20:08:35 UTC, Mathieu Malaterre wrote:
> Add gcc attribute unused for two variables. Fix warnings treated as errors
> with W=1:
> 
>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set but not used [-Werror=unused-but-set-variable]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eab00a208eb63d863b6cc0a03f68b4

cheers
