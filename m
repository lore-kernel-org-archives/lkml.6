Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DC2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AA720644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AA720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJKQB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:01:56 -0400
Received: from ozlabs.org ([203.11.71.1]:47055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeJKQB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:01:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42W46h4fHVz9sj4; Thu, 11 Oct 2018 19:35:40 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bad96de8d31ba65dc26645af5550135315ea0b19
In-Reply-To: <1538374224-3742-1-git-send-email-yamada.masahiro@socionext.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: powerpc: remove leftover code of old GCC version checks
Message-Id: <42W46h4fHVz9sj4@ozlabs.org>
Date:   Thu, 11 Oct 2018 19:35:40 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-01 at 06:10:24 UTC, Masahiro Yamada wrote:
> Clean up the leftover of commit f2910f0e6835 ("powerpc: remove old
> GCC version checks").
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bad96de8d31ba65dc26645af555013

cheers
