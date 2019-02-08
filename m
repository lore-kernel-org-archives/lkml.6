Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0D9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321CD20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfBHNCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:02:51 -0500
Received: from ozlabs.org ([203.11.71.1]:54745 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbfBHNCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:02:48 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wwMV203bz9sP0; Sat,  9 Feb 2019 00:02:46 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e5c27ef7a5f204ff2f894f0dd7ed37748a7fa12f
X-Patchwork-Hint: ignore
In-Reply-To: <20190202125427.2309-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: Remove trailing semicolon after curly brace
Message-Id: <43wwMV203bz9sP0@ozlabs.org>
Date:   Sat,  9 Feb 2019 00:02:46 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-02-02 at 12:54:27 UTC, Mathieu Malaterre wrote:
> There is not point in having a trailing semicolon after a closing curly
> brace. Remove it.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e5c27ef7a5f204ff2f894f0dd7ed3774

cheers
