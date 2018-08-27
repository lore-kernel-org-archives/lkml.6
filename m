Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0C7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A142087A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A142087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeH0ShO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:37:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46570 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeH0ShO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:37:14 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fAQt1Xkl16Kz; Mon, 27 Aug 2018 16:49:59 +0200 (CEST)
Received: from nazgul.tnic (46-10-68-224.ip.btc-net.bg [46.10.68.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33F751EC01F6;
        Mon, 27 Aug 2018 16:49:59 +0200 (CEST)
Date:   Mon, 27 Aug 2018 16:50:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jacek Tomaka <jacekt@dug.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: Re: [PATCH] x86/microcode: allow non-root reading of microcode
 version and processor flags
Message-ID: <20180827145022.GA22318@nazgul.tnic>
References: <20180825035039.14409-1-jacekt@dugeo.com>
 <20180827075248.GB18175@nazgul.tnic>
 <CAKVxXCX9H_LvNVayNxBq5NPLDWLAothi_Y2+my+2qN7srfH=mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKVxXCX9H_LvNVayNxBq5NPLDWLAothi_Y2+my+2qN7srfH=mA@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 04:05:35PM +0800, Jacek Tomaka wrote:
> On Mon, Aug 27, 2018 at 3:52 PM, Borislav Petkov <bp@alien8.de> wrote:
> 
> > Your From: is Jacek Tomaka <jacekt@dugeo.com> and your SOB is different.
> > Which one should I use?
> Please use my SOB: Jacek Tomaka <jacek.tomaka@poczta.fm>
> 
> > (Having a single email address for both is easier...)
> Sorry about the trouble.

No worries, applied.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
