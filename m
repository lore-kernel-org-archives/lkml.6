Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A3C282C4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6E12184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfAXDlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:41:08 -0500
Received: from ozlabs.org ([203.11.71.1]:36637 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfAXDkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:40:20 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43lSbQ2mcFz9sN6; Thu, 24 Jan 2019 14:40:17 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8acb88682cc00a41a677c2455a7c992d78e43035
X-Patchwork-Hint: ignore
In-Reply-To: <fc763a05d2b9dbe2cb6124d97ab9a0fe9e3e5350.1546960038.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/ipic: drop unused functions
Message-Id: <43lSbQ2mcFz9sN6@ozlabs.org>
Date:   Thu, 24 Jan 2019 14:40:17 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 15:08:00 UTC, Christophe Leroy wrote:
> ipic_set_highest_priority(), ipic_enable_mcp() and ipic_disable_mcp()
> are unused. This patch drops them.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8acb88682cc00a41a677c2455a7c992d

cheers
