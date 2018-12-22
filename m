Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C33C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2021A4E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392698AbeLVRlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:41:01 -0500
Received: from ozlabs.org ([203.11.71.1]:36957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389743AbeLVRlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:41:00 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSS74Mqz9sNG; Sat, 22 Dec 2018 20:54:32 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c62ce9ef97ba8af4120c766c32e230215dd4df04
X-Patchwork-Hint: ignore
In-Reply-To: <b5b092b3ed537d9d71e0f8763ccd045da05ef40e.1543912653.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: remove remaining bits from CONFIG_APUS
Message-Id: <43MLSS74Mqz9sNG@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:32 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 17:59:15 UTC, Christophe Leroy wrote:
> commit f21f49ea639a ("[POWERPC] Remove the dregs of APUS support from
> arch/powerpc") removed CONFIG_APUS, but forgot to remove the logic
> which adapts tophys() and tovirt() for it.
> 
> This patch removes the last stale pieces.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c62ce9ef97ba8af4120c766c32e230

cheers
