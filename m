Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D7EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC362146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfBHNCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:02:55 -0500
Received: from ozlabs.org ([203.11.71.1]:40495 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfBHNCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:02:52 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wwMZ1M8Rz9sPX; Sat,  9 Feb 2019 00:02:47 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8e0f97357533aa5b57b333de47eb008c6072fcac
X-Patchwork-Hint: ignore
In-Reply-To: <20190202130535.2761-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Geoff Levand <geoff@infradead.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Move static keyword at beginning of declaration
Message-Id: <43wwMZ1M8Rz9sPX@ozlabs.org>
Date:   Sat,  9 Feb 2019 00:02:47 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-02-02 at 13:05:35 UTC, Mathieu Malaterre wrote:
> Move the static keyword around to remove the following warnings (W=1):
> 
>   arch/powerpc/platforms/ps3/os-area.c:212:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]
>   arch/powerpc/platforms/ps3/system-bus.c:45:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Acked-by: Geoff Levand <geoff@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8e0f97357533aa5b57b333de47eb008c

cheers
