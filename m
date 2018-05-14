Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeENUBk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeENUBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:01:38 -0400
X-Google-Smtp-Source: AB8JxZoNIdzdUgD/dEtkB9qaXxu2Y58TxjMCffIROSyyVl0UDHwT7yJt0oSsZJrzDpL/QR5xuw6M6Vp3kqFCNnMYuRE=
MIME-Version: 1.0
In-Reply-To: <20180514120343.GB5265@infradead.org>
References: <20180511134559.13464-1-robh@kernel.org> <20180514120343.GB5265@infradead.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 14 May 2018 15:01:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWDfCOAzeKP7hM3yGONRU_AKhM1oJHZ7GyzTLNT6EQJw@mail.gmail.com>
Message-ID: <CAL_JsqLWDfCOAzeKP7hM3yGONRU_AKhM1oJHZ7GyzTLNT6EQJw@mail.gmail.com>
Subject: Re: [PATCH] sh: switch to NO_BOOTMEM
To: Christoph Hellwig <hch@infradead.org>
Cc: Rich Felker <dalias@libc.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SH-Linux <linux-sh@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 7:03 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> unflattening could also fix this, but removing bootmem is desired. So
>> enable NO_BOOTMEM on SH like other architectures have done.
>
> Can you send out similarly shoot in the wild conversion for the
> remaining architectures while you are at it?  We still seem to be
> missing: alpha, c6x, hexagon, ia64, m68k, mips, nios2 and unicore32.

Sparc (32-bit only) too.

I might be talked into the remaining arches that support DT which
would be c6x, hexagon, mips, and nios2. Though, looking at the MIPS
arch code always makes me cry (just try "git grep 'bootmem'
arch/mips/").

Rob
