Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891D5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8E320652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8E320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbeGKN2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:28:39 -0400
Received: from ozlabs.org ([203.11.71.1]:41983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732530AbeGKN2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:28:39 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41Qft95thjzB4MT; Wed, 11 Jul 2018 23:24:17 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 741c5640a15a23a2ec3a0846668a82e8e3b4314d
In-Reply-To: <20180702155621.GA16047@beast>
To:     Kees Cook <keescook@chromium.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc: mpc5200: Remove VLA usage
Message-Id: <41Qft95thjzB4MT@ozlabs.org>
Date:   Wed, 11 Jul 2018 23:24:17 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 15:56:21 UTC, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a stack size large enough for the saved routine and
> adds a sanity check making sure the routine doesn't overflow into the
> 0x600 exception handler.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/741c5640a15a23a2ec3a0846668a82

cheers
