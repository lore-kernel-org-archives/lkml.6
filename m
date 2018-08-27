Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B197C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7EC208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7EC208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeH0LiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:38:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58398 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbeH0LiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:38:22 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b3IbUJ14wlTV; Mon, 27 Aug 2018 09:52:34 +0200 (CEST)
Received: from nazgul.tnic (79-100-101-223.ip.btc-net.bg [79.100.101.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 037FE1EC00F4;
        Mon, 27 Aug 2018 09:52:33 +0200 (CEST)
Date:   Mon, 27 Aug 2018 09:52:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacek Tomaka <jacekt@dugeo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: Re: [PATCH] x86/microcode: allow non-root reading of microcode
 version and processor flags
Message-ID: <20180827075248.GB18175@nazgul.tnic>
References: <20180825035039.14409-1-jacekt@dugeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180825035039.14409-1-jacekt@dugeo.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 11:50:39AM +0800, Jacek Tomaka wrote:
> /sys/devices/system/cpu/cpuX/microcode
> 
> Before:
> -r-------- processor_flags
> -r-------- version
> 
> After:
> -r--r--r-- processor_flags
> -r--r--r-- version
> 
> Microcode version has been already readable for non root users via
> /proc/cpuinfo. However it is easier to access it from
> /sys/devices/system/cpu/cpuX/microcode/version
> 
> Reported-by: Tim Burgess <timb@dug.com>
> Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>

Your From: is Jacek Tomaka <jacekt@dugeo.com> and your SOB is different.
Which one should I use?

(Having a single email address for both is easier...)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
