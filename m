Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbeDXMRO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:17:14 -0400
Received: from genki.is ([159.203.135.224]:33756 "EHLO genki.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756171AbeDXMMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:12:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 genki.is 8A91E406B6
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
From: Genki Sky <sky@genki.is>
In-Reply-To: <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
Cc: David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com>
 <2580c734d38041e984215ccc522a4f2d@genki.is>
 <cef78d739d29410cb73072e9792598a7@genki.is>
 <CALAqxLWmcmiOgbH1Ri+Ki-OGFvgzRzRDzX3FZdUhcqu1OoCWiA@mail.gmail.com>
 <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
Message-ID: <24d89dd95ab246e98562a14be05a602e@genki.is>
User-Agent: alot
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
Date: Tue, 24 Apr 2018 08:11:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3OCHKCn031694

Sorry to have been the bearer of bad news :(. Again, I just have my
user hat on here. It does seem like this unifying would have been nice
to have. And even, more compliant with the POSIX definition of
MONOTONIC...

On that note, maybe it is still worth introducing MONOTONIC_ACTIVE,
but just as an alias for MONOTONIC for now. It's also more
self-documenting. Then sometime in the future, if people switch over,
remove BOOTTIME and make MONOTONIC like BOOTTIME. Though this doesn't
help simplify the code, I know.

  Thanks again,
  Genki
