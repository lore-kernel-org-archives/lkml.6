Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B43C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9367920989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9367920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbeLGNHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:07:02 -0500
Received: from ozlabs.org ([203.11.71.1]:38379 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGNG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:06:59 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43BCRP2m7Sz9s47; Sat,  8 Dec 2018 00:06:57 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7c91efce1608325634494b25ff6491320208e457
X-Patchwork-Hint: ignore
In-Reply-To: <c8395ae44e636a36443283f438c9572dc8c26a09.1543858630.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v4] powerpc/mm: dump block address translation on book3s/32
Message-Id: <43BCRP2m7Sz9s47@ozlabs.org>
Date:   Sat,  8 Dec 2018 00:06:57 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 17:40:25 UTC, Christophe Leroy wrote:
> This patch adds a debugfs file to dump block address translation:
> 
> ~# cat /sys/kernel/debug/powerpc/block_address_translation
> ---[ Instruction Block Address Translations ]---
> 0:         -
> 1:         -
> 2: 0xc0000000-0xcfffffff 0x00000000 Kernel EXEC coherent
> 3: 0xd0000000-0xdfffffff 0x10000000 Kernel EXEC coherent
> 4:         -
> 5:         -
> 6:         -
> 7:         -
> 
> ---[ Data Block Address Translations ]---
> 0:         -
> 1:         -
> 2: 0xc0000000-0xcfffffff 0x00000000 Kernel RW coherent
> 3: 0xd0000000-0xdfffffff 0x10000000 Kernel RW coherent
> 4:         -
> 5:         -
> 6:         -
> 7:         -
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7c91efce1608325634494b25ff6491

cheers
