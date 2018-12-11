Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170BAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECA920851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECA920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeLKSGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:06:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:60266 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbeLKSGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:06:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35357B017;
        Tue, 11 Dec 2018 18:06:01 +0000 (UTC)
Date:   Tue, 11 Dec 2018 19:05:47 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bp@alien8.de, richard@nod.at,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, hpa@zytor.com, jdike@addtoit.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size
 linker flag
Message-ID: <20181211180547.GG25994@zn.tnic>
References: <20181206191231.192355-1-ndesaulniers@google.com>
 <tip-f4313ba52f9caccfda6a55f991c84aba6726b88f@git.kernel.org>
 <CAKwvOdmBNvpjiYDdP88c9TZHzqbf-GTcQqPdft+LgJXC+W26Dw@mail.gmail.com>
 <5480353.C3TqP6Wb6x@blindfold>
 <20181211174658.GN27375@zn.tnic>
 <CAKwvOdnkqbxTYudCWH+Q_nuGbpKp8w3_3zHpxe29nirKKPrpsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnkqbxTYudCWH+Q_nuGbpKp8w3_3zHpxe29nirKKPrpsQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 09:53:49AM -0800, Nick Desaulniers wrote:
> Indeed it was.  I'm forced to use Gmail's clients for this work
> account and all that implies (no plain text responses when mobile).

Can't you access it over imap?

> Maybe I can file a bug about this internally...

FWIW, people have looked for ways to report such issues in the past...

But in this particular case, DKIM is pretty good spam protection
mechanism so enabling it is a good idea.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
