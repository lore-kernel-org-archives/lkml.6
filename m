Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C368C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1382089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1382089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeJASNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:13:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53590 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbeJASNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:13:10 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qfMCtacp8smO; Mon,  1 Oct 2018 13:35:48 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BFD211EC0322;
        Mon,  1 Oct 2018 13:35:48 +0200 (CEST)
Date:   Mon, 1 Oct 2018 13:35:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH resend] x86, asm: Use CC_SET()/CC_OUT() for
 __cmpxchg_double
Message-ID: <20181001113551.GB7269@zn.tnic>
References: <CAFULd4YdvwwhXWHqqPsGk5+TLG71ozgSscTZNsqmrm+Jzg941w@mail.gmail.com>
 <20181001102803.GA7269@zn.tnic>
 <CAFULd4bEtskY+waRvp4kCt-pBmp=W9SQKVpnQ6fsYC=qaOb8Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4bEtskY+waRvp4kCt-pBmp=W9SQKVpnQ6fsYC=qaOb8Qg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 01:03:47PM +0200, Uros Bizjak wrote:
> Looks like gmail forward mangled whitespace. The original, archived at
> Patchwork [1] passes checkpatch without problems.
> 
> [1] https://mail.google.com/mail/u/0/#inbox/LXphbRLrghxkrJptDWnbbJcrVBkBsRQgcnbtRLjbGSq

This is a gmail link *into* your inbox?!?!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
