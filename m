Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A064C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D802082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D802082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeLEN1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:27:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48574 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEN1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:27:14 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gUXCg-00034K-Uk; Wed, 05 Dec 2018 14:27:03 +0100
Date:   Wed, 5 Dec 2018 14:27:02 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: MPX is broken for 32bit programs on a 64bit host
Message-ID: <20181205132702.tsp5eifft2tyjz2q@linutronix.de>
References: <20181129141746.5p5ed7c6rip5qswp@linutronix.de>
 <a13a2de5-64c9-f3c3-4a4a-2af3aa7378f9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a13a2de5-64c9-f3c3-4a4a-2af3aa7378f9@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-29 09:13:04 [-0800], Dave Hansen wrote:
> On 11/29/18 6:17 AM, Sebastian Andrzej Siewior wrote:
> > This is broken since v4.12-rc1. This is known [1] since April this year.
> > Should I send a removal patch for MPX or is someone actually going to
> > fix this? Or do we wait for gcc-9 to be released?
> 
> I've got a git tree prepared to do MPX removal.  I'll send a pull
> request for 4.21 (or whatever we call it).

Cold you please do it soon? I saw it on k.o. and it collides with my FPU
patches. I think that the MPX removal will be routed via the TIP tree.
So once it is there (and waiting for the merge window to open), I could
rebase my things on top of it (I doubt that it will be the other way
around).

Sebastian
