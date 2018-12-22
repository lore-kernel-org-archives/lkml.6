Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDFCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61C32146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbeLVRCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:02:55 -0500
Received: from ozlabs.org ([203.11.71.1]:37777 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731742AbeLVRBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:02 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLT746r8z9sPn; Sat, 22 Dec 2018 20:55:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e93ba1b7eb5b188c749052df7af1c90821c5f320
X-Patchwork-Hint: ignore
In-Reply-To: <6d1eb005328a8a4608fbed8628e04f493b1c6ce2.1542389250.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/book3s/32: fix number of bats in p/v_block_mapped()
Message-Id: <43MLT746r8z9sPn@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:55:06 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 17:27:42 UTC, Christophe Leroy wrote:
> This patch fixes the loop in p_block_mapped() and v_block_mapped()
> to scan the entire bat_addrs[] array.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e93ba1b7eb5b188c749052df7af1c9

cheers
