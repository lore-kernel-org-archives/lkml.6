Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE1DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B6621A4E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392686AbeLVRlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:41:00 -0500
Received: from ozlabs.org ([203.11.71.1]:54479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389185AbeLVRlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:41:00 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLT067Jfz9sPK; Sat, 22 Dec 2018 20:55:00 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 584dbc7727a22459dfcb6e4c9faef6467d08ab5e
X-Patchwork-Hint: ignore
In-Reply-To: <af5868beeee3e7b4fe6d252d4adcbcbafc23e73c.1539803874.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/mm: remove unused variable
Message-Id: <43MLT067Jfz9sPK@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:55:00 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-18 at 05:22:06 UTC, Christophe Leroy wrote:
> In file included from ./include/linux/hugetlb.h:445:0,
>                  from arch/powerpc/kernel/setup-common.c:37:
> ./arch/powerpc/include/asm/hugetlb.h: In function âhuge_ptep_clear_flushâ:
> ./arch/powerpc/include/asm/hugetlb.h:154:8: error: variable âpteâ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/584dbc7727a22459dfcb6e4c9faef6

cheers
