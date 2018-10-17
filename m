Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDB1ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BA22087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BA22087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeJREKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:10:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeJREKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:10:22 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCsBh-0006Dn-6e; Wed, 17 Oct 2018 22:13:01 +0200
Date:   Wed, 17 Oct 2018 22:13:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 1/3] kbuild: Add -Wshadow to sparse
Message-ID: <20181017201300.4er4t3lef7gabgps@linutronix.de>
References: <20181017170554.18841-1-bigeasy@linutronix.de>
 <20181017170554.18841-2-bigeasy@linutronix.de>
 <20181017192501.3yqfq77q2n4xdq7l@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181017192501.3yqfq77q2n4xdq7l@ltop.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-17 21:25:02 [+0200], Luc Van Oostenryck wrote:
> Hi,
Hi,

> I made a quick test and I saw it would add a lot of noise because of
> (valid) warnings coming from macros using a statement expression
> redeclaring variables like '__u', 'tmp', ...
> 
> BTW, as far as I can see, sparse never had it enabled by default.

I must have seen those warnings with C=1 _years_ ago otherwise I
wouldn't know about that feature. Or it was enabled by the check process
and got disabled but I can't find evidence for it.

> Kind regards,
> -- Luc Van Oostenryck

Sebastian
