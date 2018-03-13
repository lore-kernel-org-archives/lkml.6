Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeCMRhP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:37:15 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:39577 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeCMRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:37:09 -0400
X-Google-Smtp-Source: AG47ELvIyJgKD4eK7TPJOl1VGMHWUBA13dtis2pBZhZRtkGAk6FNHmm7I/XfPYcGM0E17aqz8Hj8e0NbPPAeB2xgzgU=
MIME-Version: 1.0
In-Reply-To: <c3e09140-8a5b-0fdd-82cc-03700be3b5a0@linux.intel.com>
References: <CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
 <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com> <CAHp75VdYG+i+m12yotuUa2JwW4ndMMXTV0ZSs_qOS5EAw7=M4w@mail.gmail.com>
 <CAHp75Vex+m-HqVD-H=B7zh=TFWR2Jbw2zSUwhApeY7xBb8pcvg@mail.gmail.com>
 <23d70b0d-ec19-32c8-e636-4cc36f1eec47@linux.intel.com> <CAHp75VebU5NYXRDpG4pzYrKDmNLE6prGbecacq3gCyDQBJd=cA@mail.gmail.com>
 <c3e09140-8a5b-0fdd-82cc-03700be3b5a0@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 19:31:39 +0200
Message-ID: <CAHp75Vdvmbhj9kb+D7qSbBQFD52n=rHWukvAJgGXxCbcnNSCyg@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/platform/x86: Fix count of CHas on
 multi-pci-segment arches
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: "Kroening, Gary" <gary.kroening@hpe.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 7:28 PM, Liang, Kan <kan.liang@linux.intel.com> wrote:

>>>>>> +#define SKX_CAPID6             0x9c

^^^ This needs a comment.

>>> It looks it doesn't use capability.

> $ lspci -nk -vvv -xx -s 16:1e.3
> 16:1e.3 0880: 8086:2083 (rev 04)
>         Subsystem: 8086:0000
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 00: 86 80 83 20 00 00 00 00 04 00 80 08 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Pity.

-- 
With Best Regards,
Andy Shevchenko
