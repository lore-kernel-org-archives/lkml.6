Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeDQPVd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:21:33 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36971 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDQPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:21:32 -0400
X-Google-Smtp-Source: AIpwx48mbeZXXJFK+x4v5M2T45e0LmVJ3/lMmtH0RtBTpA+98+LptILpDUIZVBBHOTHYUpwsmKmEI0iMf1R6nnVuK8w=
MIME-Version: 1.0
In-Reply-To: <20180417142715.GL18640@pd.tnic>
References: <CADDKRnAp1EKCAosD-kLNRaJ4qJppUtmmP1n76wzcvNUVa0fQzg@mail.gmail.com>
 <20180417081458.GA2894@pd.tnic> <CADDKRnDmycResXxAsfYfM6sFoWffD_v_cMoR4XF7OxUps3mU+Q@mail.gmail.com>
 <20180417142715.GL18640@pd.tnic>
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date: Tue, 17 Apr 2018 17:21:30 +0200
Message-ID: <CADDKRnBtQKz5S3EdJbrVH8PN9_qTrSQ3owcK=PfxToHdxpu8rA@mail.gmail.com>
Subject: Re: 4.17.0-rc1 doesn't boot.
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3HFLacR024172

2018-04-17 16:27 GMT+02:00 Borislav Petkov <bp@alien8.de>:
> On Tue, Apr 17, 2018 at 04:16:34PM +0200, Jörg Otte wrote:
>> Current Linus master tree (4.17.0-rc1-00021-ga27fc14) does'nt fix it.
>
> Then pls continue bisecting. Unless someone has a better idea...
>

finished bisection.
39114b7a743e6759bab4d96b7d9651d44d17e3f9 is the first bad commit
(x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image).

Thanks, Jörg
