Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CDEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F0020663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F0020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeKZURV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:17:21 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:45166 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZURV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:17:21 -0500
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 4F270200941;
        Mon, 26 Nov 2018 09:23:49 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 0646E201C6; Mon, 26 Nov 2018 09:36:33 +0100 (CET)
Date:   Mon, 26 Nov 2018 09:36:33 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] pcmcia: remove per-arch PCMCIA config entry
Message-ID: <20181126083633.GA10604@light.dominikbrodowski.net>
References: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:15:41PM +0900, Masahiro Yamada wrote:
> Now that all architectures include drivers/pcmcia/Kconfig where
> the PCMCIA config is defined, the PCMCIA config entries in per-arch
> Kconfig files are redundant.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> I will queue this up to my kbuild tree
> along with Christoph's clean-up patch set.

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
