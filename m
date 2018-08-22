Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D0AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B90A206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B90A206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeHVQdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:33:06 -0400
Received: from verein.lst.de ([213.95.11.211]:35287 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbeHVQdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:33:06 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9CD3168EF1; Wed, 22 Aug 2018 15:09:58 +0200 (CEST)
Date:   Wed, 22 Aug 2018 15:09:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org, hch@lst.de,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH] y2038: provide aliases for compat helpers
Message-ID: <20180822130958.GB28149@lst.de>
References: <20180821203329.2089473-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821203329.2089473-1-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 10:33:00PM +0200, Arnd Bergmann wrote:
> As part of the system call rework for 64-bit time_t, we are restructuring
> the way that compat syscalls deal with 32-bit time_t, reusing the
> implementation for 32-bit architectures. Christoph Hellwig suggested
> a rename of the associated types and interfaces to avoid the confusing
> usage of the 'compat' prefix for 32-bit architectures.
> 
> To prepare for doing that in linux-4.20, this adds a set of macros
> that lets us convert subsystems separately to the new names and
> avoid some of the nastier merge conflicts.

Looks fine to me:

Acked-by: Christoph Hellwig <hch@lst.de>
