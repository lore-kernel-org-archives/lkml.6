Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF63DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F1021A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404799AbeLVRBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:06 -0500
Received: from ozlabs.org ([203.11.71.1]:37977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392419AbeLVRBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:04 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLT40b0qz9sPg; Sat, 22 Dec 2018 20:55:03 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 45090c26614fe991d9d5a2cd08e65c4d6680549a
X-Patchwork-Hint: ignore
In-Reply-To: <e63d9ac8ef6e83fc243d8910d7c789e111e48580.1541784640.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/9] powerpc: simplify patch_instruction_site() and patch_branch_site()
Message-Id: <43MLT40b0qz9sPg@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:55:03 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-09 at 17:33:15 UTC, Christophe Leroy wrote:
> Using patch_site_addr() helper, patch_instruction_site() and
> patch_branch_site() can be simplified and inlined.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45090c26614fe991d9d5a2cd08e65c

cheers
