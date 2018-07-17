Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B72ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C9120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C9120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbeGQNaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:30:18 -0400
Received: from verein.lst.de ([213.95.11.211]:51246 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbeGQNaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:30:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4AB957FDC5; Tue, 17 Jul 2018 15:00:16 +0200 (CEST)
Date:   Tue, 17 Jul 2018 15:00:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] kconfig: include common Kconfig files from
        top-level Kconfig
Message-ID: <20180717130016.GB12575@lst.de>
References: <20180708152004.21679-1-hch@lst.de> <20180708152004.21679-5-hch@lst.de> <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com> <e36e6b2c-0984-199e-8c19-3ec54b31c12e@infradead.org> <7d4e0925-3d6b-7698-1ef3-4c66500d8507@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d4e0925-3d6b-7698-1ef3-4c66500d8507@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:42:54PM -0700, Randy Dunlap wrote:
> Well, there are 3 $ARCH-es that have an arch/$ARCH/mm/Kconfig file:
> arm, sh, and unicore32.
> 
> We can either merge those into arch/$ARCH/Kconfig or we can source
> arch/$ARCH/mm/Kconfig for all $ARCH (where most of these files will be
> empty).
> 
> Christoph, thoughts/ideas?

I'd say lets keep them for now, not good reason to change any of
this stuff.
