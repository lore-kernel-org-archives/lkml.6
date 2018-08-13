Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B62C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1056C21746
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1056C21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeHMOEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:04:51 -0400
Received: from ozlabs.org ([203.11.71.1]:54039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbeHMOEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:04:50 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptcz6lYyz9sCQ; Mon, 13 Aug 2018 21:22:59 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a9bf5c8a271b9a954709b7ada1bd258f5cadf7ff
In-Reply-To: <20180430145558.4308-11-npiggin@gmail.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [10/15] tty: hvc: use mutex instead of spinlock for hvc_structs lock
Message-Id: <41ptcz6lYyz9sCQ@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:22:59 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-30 at 14:55:53 UTC, Nicholas Piggin wrote:
> This allows hvc operations to sleep under the lock.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a9bf5c8a271b9a954709b7ada1bd25

cheers
