Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE4CC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFA0204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFA0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeI2OX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:23:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50204 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbeI2OX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:23:28 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ODLdnqEmWjkP; Sat, 29 Sep 2018 09:56:00 +0200 (CEST)
Received: from zn.tnic (p200300EC2BD81000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd8:1000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 19C541EC04DF;
        Sat, 29 Sep 2018 09:56:00 +0200 (CEST)
Date:   Sat, 29 Sep 2018 09:56:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH net-next v6 04/23] zinc: ChaCha20 x86_64 implementation
Message-ID: <20180929075601.GA11115@zn.tnic>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-5-Jason@zx2c4.com>
 <CAKv+Gu9aOiYdEzHHrHFHUFK=hNfeS=zEsvMe9OWD8hEdAYkffg@mail.gmail.com>
 <CAHmME9rc5zgN4HhBy0_oq+EbEXdS8nePzA7qW39nocx_y4ay1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9rc5zgN4HhBy0_oq+EbEXdS8nePzA7qW39nocx_y4ay1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 04:01:53AM +0200, Jason A. Donenfeld wrote:
> I was wondering about the ordering of these, actually. I've seen s-o-b
> on top and s-o-b on bottom of the cc list in lots of commits and
> haven't yet divined the One True Position.

Documentation/process/submitting-patches.rst

section 12, first sentence.

The SOB chain needs to clearly express the path of the patch from
author(s) to the upstream kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
