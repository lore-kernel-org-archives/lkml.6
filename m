Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C0CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6234821470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6234821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeJDNGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:06:22 -0400
Received: from ozlabs.org ([203.11.71.1]:40043 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbeJDNGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:06:21 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42QjKD27qPz9s7W; Thu,  4 Oct 2018 16:14:38 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 01b9870ea614518d48b6d2c787284b3a7d181a7c
In-Reply-To: <1537690328-77353-1-git-send-email-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [-next] powerpc: Remove duplicated include from pci_32.c
Message-Id: <42QjKD27qPz9s7W@ozlabs.org>
Date:   Thu,  4 Oct 2018 16:14:38 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-23 at 08:12:08 UTC, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/01b9870ea614518d48b6d2c787284b

cheers
