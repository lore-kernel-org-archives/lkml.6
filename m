Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF339ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1438C20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1438C20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbeGQN3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:29:43 -0400
Received: from verein.lst.de ([213.95.11.211]:51235 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbeGQN3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:29:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0329A7FDC5; Tue, 17 Jul 2018 14:59:42 +0200 (CEST)
Date:   Tue, 17 Jul 2018 14:59:41 +0200
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
Message-ID: <20180717125941.GA12575@lst.de>
References: <20180708152004.21679-1-hch@lst.de> <20180708152004.21679-5-hch@lst.de> <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com> <e36e6b2c-0984-199e-8c19-3ec54b31c12e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36e6b2c-0984-199e-8c19-3ec54b31c12e@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 11:33:38PM -0700, Randy Dunlap wrote:
> Thanks for noticing that.
> 
> I have tested all $ARCH (except um) with "allmodconfig" and so far, arch/sh/
> is the only one that has a problem.

I'm a little busy right now, I'll got back to fix sh and retest in a few
days hopefully.
