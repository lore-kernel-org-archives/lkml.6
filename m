Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeDQOQh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:16:37 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:55894 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeDQOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:16:36 -0400
X-Google-Smtp-Source: AIpwx4+VXYmhMbka8nKw+zWyuHc2rRMNdRCNt00MYlaLGGpDkr5Fp4V9s8t5VO7K11jChVHDHX23QuZlAyKqJWBIR/M=
MIME-Version: 1.0
In-Reply-To: <20180417081458.GA2894@pd.tnic>
References: <CADDKRnAp1EKCAosD-kLNRaJ4qJppUtmmP1n76wzcvNUVa0fQzg@mail.gmail.com>
 <20180417081458.GA2894@pd.tnic>
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date: Tue, 17 Apr 2018 16:16:34 +0200
Message-ID: <CADDKRnDmycResXxAsfYfM6sFoWffD_v_cMoR4XF7OxUps3mU+Q@mail.gmail.com>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3HEGn9E019991

2018-04-17 10:14 GMT+02:00 Borislav Petkov <bp@alien8.de>:
> On Tue, Apr 17, 2018 at 10:00:25AM +0200, Jörg Otte wrote:
>> Maybe the problem came in with:
>> 6b0a02e:  "Merge branch 'x86-pti-for-linus' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip"
>
> Fetch latest Linus master and try again - there might be a relevant fix
> there.
>

Current Linus master tree (4.17.0-rc1-00021-ga27fc14) does'nt fix it.

Thanks, Jörg
