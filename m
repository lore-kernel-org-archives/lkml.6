Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F271ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D1D2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D1D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeJSKz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:55:28 -0400
Received: from ozlabs.org ([203.11.71.1]:51555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeJSKz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:55:28 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42br5n5GTQzB4N5; Fri, 19 Oct 2018 13:51:25 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bd03fd84a53ac9ddaeb0a0fc4c4c9836e12f3ab9
In-Reply-To: <52facff7ae5377f1f0d023917dddb588350a7028.1539589080.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/traps: remove redundant in_interrupt panic in die()
Message-Id: <42br5n5GTQzB4N5@ozlabs.org>
Date:   Fri, 19 Oct 2018 13:51:25 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 07:38:10 UTC, Christophe Leroy wrote:
> do_exit() already includes a test to panic() is in_interrupt()
> 
> This patch removes powerpc one which is redundant.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bd03fd84a53ac9ddaeb0a0fc4c4c98

cheers
