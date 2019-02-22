Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1579DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A242086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfBVJrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:47:48 -0500
Received: from ozlabs.org ([203.11.71.1]:57077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfBVJrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:47 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RN11yyGz9sN1; Fri, 22 Feb 2019 20:47:45 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6b9166f0786e6f24da9fb198bcf70ce131c88ee1
X-Patchwork-Hint: ignore
In-Reply-To: <da718ce0da4303de0197b46570680843a188f216.1548851096.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/32: Fix CONFIG_VIRT_CPU_ACCOUNTING_NATIVE for 40x/booke
Message-Id: <445RN11yyGz9sN1@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:45 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-31 at 10:10:31 UTC, Christophe Leroy wrote:
> 40x/booke have another path to reach 3f from transfer_to_handler,
> make sure it also calls ACCOUNT_CPU_USER_ENTRY() when
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6b9166f0786e6f24da9fb198bcf70ce1

cheers
