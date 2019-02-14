Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EB6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5748E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436857AbfBNIyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:54:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:35180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387827AbfBNIyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:54:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 958DDAFCA;
        Thu, 14 Feb 2019 08:54:18 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
References: <20190213174005.28785-1-hch@lst.de>
        <20190213174005.28785-2-hch@lst.de>
X-Yow:  With YOU, I can be MYSELF..  We don't NEED Dan Rather..
Date:   Thu, 14 Feb 2019 09:54:17 +0100
In-Reply-To: <20190213174005.28785-2-hch@lst.de> (Christoph Hellwig's message
        of "Wed, 13 Feb 2019 18:39:55 +0100")
Message-ID: <mvma7iyrbra.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13 2019, Christoph Hellwig <hch@lst.de> wrote:

> __KERNEL__ is never not defined for non-uapi headers, and GENERIC_CSUM

"... never not ... non-..."  That's a bit too negative, I think.  :-)

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
