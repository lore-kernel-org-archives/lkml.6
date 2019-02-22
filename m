Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23652081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfBVJr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:47:57 -0500
Received: from ozlabs.org ([203.11.71.1]:49869 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfBVJrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:53 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RN711R5z9sNG; Fri, 22 Feb 2019 20:47:50 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fa7b9a805c797b729022029aaa3a2b7c35fff4c6
X-Patchwork-Hint: ignore
In-Reply-To: <59dbb1bc305068dd0fe8e2d5a75c4213e0134549.1549638049.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: tools/selftest/vm: allow choosing mem size and page size in map_hugetlb
Message-Id: <445RN711R5z9sNG@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:50 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 15:02:55 UTC, Christophe Leroy wrote:
> map_hugetlb maps 256Mbytes of memory with default hugepage size.
> 
> This patch allows the user to pass the size and page shift as an
> argument in order to use different size and page size.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fa7b9a805c797b729022029aaa3a2b7c

cheers
