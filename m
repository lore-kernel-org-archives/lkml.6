Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6DF2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfBVJsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:48:20 -0500
Received: from ozlabs.org ([203.11.71.1]:39413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfBVJsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:48:09 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RNS1X6Wz9sP3; Fri, 22 Feb 2019 20:48:08 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 40058337f23f79212f92ed5ef066e90a032905b1
X-Patchwork-Hint: ignore
In-Reply-To: <2fac63e1eb595870a990da51f81ba97c11903c0e.1550745320.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2,01/10] powerpc: simplify BDI switch
Message-Id: <445RNS1X6Wz9sP3@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:48:08 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 10:37:53 UTC, Christophe Leroy wrote:
> There is no reason to re-read each time the pointer at
> location 0xf0 as it is fixed and known.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/40058337f23f79212f92ed5ef066e90a

cheers
