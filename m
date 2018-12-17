Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A27C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D9020656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbeLQNHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:07:03 -0500
Received: from ozlabs.org ([203.11.71.1]:42267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732604AbeLQNHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:07:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JLyp4dPQz9sCh;
        Tue, 18 Dec 2018 00:06:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
In-Reply-To: <CALxhOnh5a86pBi4rD1YzhVGq7KPs56du9+G8vkt7zVAqbGkLEw@mail.gmail.com>
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org> <20181217080846.GA28424@sathnaga86.in.ibm.com> <877eg8v40t.fsf@concordia.ellerman.id.au> <CALxhOnh5a86pBi4rD1YzhVGq7KPs56du9+G8vkt7zVAqbGkLEw@mail.gmail.com>
Date:   Tue, 18 Dec 2018 00:06:53 +1100
Message-ID: <87ftuwti8i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firoz Khan <firoz.khan@linaro.org> writes:

> Hi Michael,
>
> On Mon, 17 Dec 2018 at 16:01, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> No it's fine if it applies on next.
>>
>> I can also fix up minor merge conflicts if there are any.
>
> Ohh. I already rebased and sent v6.

That's OK.

cheers
