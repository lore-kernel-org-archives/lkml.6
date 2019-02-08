Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F6DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D625020844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBHNDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:03:09 -0500
Received: from ozlabs.org ([203.11.71.1]:51921 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfBHNCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:02:34 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wwMD5XkNz9sML; Sat,  9 Feb 2019 00:02:32 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 45a202a3fefc6ee7b19b1222bfb5b0679ce31996
X-Patchwork-Hint: ignore
In-Reply-To: <5c40aafc.1c69fb81.a0ba0.67a7@mx.google.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>, arnd@arndb.de,
        benh@kernel.crashing.org, paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        jrdr.linux@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: powerpc/cell: Remove duplicate header
Message-Id: <43wwMD5XkNz9sML@ozlabs.org>
Date:   Sat,  9 Feb 2019 00:02:31 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 16:19:05 UTC, Sabyasachi Gupta wrote:
> Remove linux/syscalls.h which is included more than once
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45a202a3fefc6ee7b19b1222bfb5b067

cheers
