Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeCZBsk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 21:48:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35780 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeCZBsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 21:48:38 -0400
X-Google-Smtp-Source: AIpwx4+cKEOa98v+d1y3jj5UUy/OWP60AyasWurkZ/Rqh62tIft/d77oVDKvqL4wSrvYQvWIo8aCLQ==
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
References: <20180325182803.30036-1-avarab@gmail.com>
        <20180325182803.30036-3-avarab@gmail.com>
        <20180325210132.GE74743@genre.crustytoothpaste.net>
Date: Sun, 25 Mar 2018 18:48:35 -0700
In-Reply-To: <20180325210132.GE74743@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 25 Mar 2018 21:01:32 +0000")
Message-ID: <xmqqpo3rehe4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm not sure that this is going to have the effect you want it to have.
> Let me give an example to demonstrate why.
> ...
> In short, I don't think this is going to be especially helpful because
> it won't change the status quo for a lot of senders.  You'd have to
> insert some significant delay in order to get the effect you desire, and
> even then things could still be delivered out of order.

Thanks for explaining it clearly.

In the past on this list those who do not get the store-and-forward
nature of e-mail transport have brought this up a few times, but
this approach fundamentally do not work, at least for the purpose of
forcing ordering of messages at the receiving end.
