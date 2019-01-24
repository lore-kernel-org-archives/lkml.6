Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F62C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9672184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfAXDki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:40:38 -0500
Received: from ozlabs.org ([203.11.71.1]:59403 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfAXDkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:40:36 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43lSbk0myZz9s55; Thu, 24 Jan 2019 14:40:33 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9bd10b649826774bb5e1e7fb67544e6500e3f005
X-Patchwork-Hint: ignore
In-Reply-To: <20190114201304.10783-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: Allow CPU selection of G4/74xx variant
Message-Id: <43lSbk0myZz9s55@ozlabs.org>
Date:   Thu, 24 Jan 2019 14:40:33 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-14 at 20:13:04 UTC, Mathieu Malaterre wrote:
> GCC supports -mcpu=G4
> 
> This patch gives the opportunity to select ALTIVEC for this variant.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9bd10b649826774bb5e1e7fb67544e65

cheers
