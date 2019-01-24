Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC2C41518
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE30E218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfAXDkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:40:15 -0500
Received: from ozlabs.org ([203.11.71.1]:49687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfAXDkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:40:15 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43lSbK4ch9z9s9h; Thu, 24 Jan 2019 14:40:13 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fae1383b38a105a0454acab19b094c510728fde5
X-Patchwork-Hint: ignore
In-Reply-To: <20190107095720.7538-1-sergey.senozhatsky@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: use a CONSOLE_LOGLEVEL_DEBUG macro
Message-Id: <43lSbK4ch9z9s9h@ozlabs.org>
Date:   Thu, 24 Jan 2019 14:40:13 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 09:57:20 UTC, Sergey Senozhatsky wrote:
> Use a CONSOLE_LOGLEVEL_DEBUG macro for console_loglevel rather
> than a naked number.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fae1383b38a105a0454acab19b094c51

cheers
