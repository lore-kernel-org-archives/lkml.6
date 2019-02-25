Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DECD2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="I35irzBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfBYTTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:19:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43714 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfBYTTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:19:03 -0500
Received: from zn.tnic (p200300EC2BC68000EC11815BDBFEF01F.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:8000:ec11:815b:dbfe:f01f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 697471EC0253;
        Mon, 25 Feb 2019 20:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551122342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CecoRhjY1y1Lgmp+KOcsfpL/MZ4XKoBhWcWio5w2y6s=;
        b=I35irzBliGZLLhqfTL6UDjzpE68rI5j74VIXqvaG9BxV0KA46Q+sKdpt3r+vj2zb2+8sbM
        NVTrq3I79Wochk5070ZIaZR96LnuY0XZBYnvrrO4uw+oND5b6ki+YvX3dgT9kvw+TQpGa6
        Jdqb5D93/HtGpI4CkyvhXIfg+7hdeYc=
Date:   Mon, 25 Feb 2019 20:18:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/uaccess: Dont evaluate argument inside AC region
Message-ID: <20190225191859.GH26145@zn.tnic>
References: <20190225124330.613028745@infradead.org>
 <20190225125231.845656645@infradead.org>
 <CALCETrWQpG2aOxxeoNXUPD-A7h3j4NSTqoN+vN9Nr2E_Fo19zg@mail.gmail.com>
 <CAHk-=wiNTe91hQEspL-1+49uH6bOWrS=n+iwVQtmY54cqYB5Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNTe91hQEspL-1+49uH6bOWrS=n+iwVQtmY54cqYB5Ag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:09:53AM -0800, Linus Torvalds wrote:
> Ack. Even if it does seem to get the whitespace wrong and not align
> things ;)

It is the top commit so fixed up and added your ACK. :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
