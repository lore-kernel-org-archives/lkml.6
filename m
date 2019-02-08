Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354F0C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117212146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfBHNCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:02:42 -0500
Received: from ozlabs.org ([203.11.71.1]:37915 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfBHNCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:02:39 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wwMJ3LnGz9sNg; Sat,  9 Feb 2019 00:02:35 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 75f8a37580b64f87c223fbd08db6b2f79129864a
X-Patchwork-Hint: ignore
In-Reply-To: <20190128161136.GA2266@hp-pavilion-15-notebook-pc-brajeswar>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, arnd@arndb.de, anton@ozlabs.org,
        aneesh.kumar@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     sabyasachi.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        jrdr.linux@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: powerpc/kernel/time: Remove duplicate header
Message-Id: <43wwMJ3LnGz9sNg@ozlabs.org>
Date:   Sat,  9 Feb 2019 00:02:35 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 16:11:36 UTC, Brajeswar Ghosh wrote:
> Remove linux/rtc.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/75f8a37580b64f87c223fbd08db6b2f7

cheers
