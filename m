Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60637222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395552AbfBNRFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:05:12 -0500
Received: from verein.lst.de ([213.95.11.211]:51900 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732912AbfBNRFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:05:11 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3BA216FA8D; Thu, 14 Feb 2019 18:05:10 +0100 (CET)
Date:   Thu, 14 Feb 2019 18:05:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
Message-ID: <20190214170510.GC32441@lst.de>
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-2-hch@lst.de> <e7a2efe3-f56c-7dfd-6613-dc9229556673@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a2efe3-f56c-7dfd-6613-dc9229556673@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 09:26:19AM +0100, Christophe Leroy wrote:
> Could you also remove the 'config GENERIC_CSUM' item in 
> arch/powerpc/Kconfig ?

All the separate declarations go away later in this series.
