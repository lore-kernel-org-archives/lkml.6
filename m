Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D85CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4502B2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4502B2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeH1MwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:52:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55570 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbeH1MwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:52:10 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5VBf1axGpcu1; Tue, 28 Aug 2018 11:01:12 +0200 (CEST)
Received: from nazgul.tnic (46-10-68-224.ip.btc-net.bg [46.10.68.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 250D61EC02DD;
        Tue, 28 Aug 2018 11:01:02 +0200 (CEST)
Date:   Tue, 28 Aug 2018 10:59:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tim Small <tim@buttersideup.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: Remove the i82443bxgx_edac driver
Message-ID: <20180828085903.GA32231@nazgul.tnic>
References: <20180810141520.8993-1-tiwai@suse.de>
 <20180815155752.GC28669@nazgul.tnic>
 <s5hh8jv62lk.wl-tiwai@suse.de>
 <20180815161205.GD28669@nazgul.tnic>
 <20180827164535.GB22318@nazgul.tnic>
 <56b161bc-9b5e-63c9-b815-8b3ff8214887@buttersideup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56b161bc-9b5e-63c9-b815-8b3ff8214887@buttersideup.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:30:23PM +0100, Tim Small wrote:
> On that basis, I don't see a problem with removing it, but if there's a
> preference for me to fix it, (and if I still have some old hardware
> somewhere that I can test it on), I'll be happy to do that instead.

Well, if you don't have the hardware anymore, fixing it would be moot
and the only thing we can do is remove it. So, the question is, do you
still have a functioning box and you want to waste your time with it?

I mean, this is pentium III, it probably takes forever to build the
latest kernel on it and if it were me, I'd simply buy new hardware.
Because IMO, it is not worth the energy to even power such ancient crap
and waste money on the electricity it is going to consume...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
