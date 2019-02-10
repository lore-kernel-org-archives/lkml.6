Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC2EC282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1477A20823
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBJWNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 17:13:02 -0500
Received: from ozlabs.org ([203.11.71.1]:37049 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfBJWNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 17:13:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yNTL3wrDz9sCh;
        Mon, 11 Feb 2019 09:12:54 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ccaulfie@redhat.com, Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        cluster-devel <cluster-devel@redhat.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
In-Reply-To: <CABeXuvqpexo4g7xQihKPoOd4ce4rLq0Agy-jYMELYvOAnqmXJA@mail.gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com> <20190202153454.7121-13-deepa.kernel@gmail.com> <87r2clku4j.fsf@concordia.ellerman.id.au> <CABeXuvqpexo4g7xQihKPoOd4ce4rLq0Agy-jYMELYvOAnqmXJA@mail.gmail.com>
Date:   Mon, 11 Feb 2019 09:12:52 +1100
Message-ID: <87o97ji97f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> writes:

>> You touched powerpc in the previous patch but not this one.
>>
>> That's because we use the asm-generic version I assume.
>
> That is correct.
>
>> Would be good to mention in the change log though to avoid any confusion.
>
> I'm not sure how to do that now. It looks like the series has already
> been applied to net-next with a couple of merge conflicts fixed.

That's fine, it's not that important.

cheers
