Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeEEJr4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:47:56 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:42396 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEEJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:47:54 -0400
X-Google-Smtp-Source: AB8JxZr2XHT8bMYwdk3PW1ySCTlzYd9fTkvWX6m2LBFKD7xZUy4oSp6ufhwiyAv5SJ3nAraBb06zdNgGpMZvOf7utXA=
MIME-Version: 1.0
In-Reply-To: <20180504161815.GG9257@pd.tnic>
References: <CADDKRnBD=cgptLmDMu0YiaUThO-1ydKaAD4X3sTWfLuP5M5BEw@mail.gmail.com>
 <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de>
 <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com>
 <alpine.DEB.2.21.1805011458390.1596@nanos.tec.linutronix.de>
 <CA+55aFxKbPDrMQssyEtOnYZqE8HcOo=Zx6ASty6CybhwPfT9_g@mail.gmail.com>
 <CADDKRnC1V3KUR__PAo_JhMVdaWknQ9x1_XAQNewUWuO3cqFFFg@mail.gmail.com>
 <alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de>
 <CADDKRnBn7rNN9UrwtYvNDPeJxqNQ-WHQVyHXAV7RwcVxX7jSDw@mail.gmail.com>
 <alpine.DEB.2.21.1805021418550.1560@nanos.tec.linutronix.de> <20180504161815.GG9257@pd.tnic>
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date: Sat, 5 May 2018 11:47:53 +0200
Message-ID: <CADDKRnDU6gt4a0UaPkjHOE+8iZCoZ1DXw06Fx7y6=Ge+trhbOQ@mail.gmail.com>
Subject: Re: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2 mitigation.
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w459m2mi000691

2018-05-04 18:18 GMT+02:00 Borislav Petkov <bp@alien8.de>:
> On Wed, May 02, 2018 at 02:20:52PM +0200, Thomas Gleixner wrote:
>> Thanks for confirming. Still need to find a way which is less fragile, but
>> that's probably too much of churn for rc4....
>>
>> At least I know exactly what's happening, so I can write a better changelog.
>>
>> Thanks for testing!
>
> Jörg, can you pls also test this one ontop of Thomas' patch to make
> sure it doesn't break your box.
>
> Thx.
>
> ---
> From 6857c2ac8e31f4f9b350cfad4f6b6eb831bf57f1 Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 2 May 2018 18:15:14 +0200
> Subject: [PATCH] x86/CPU: Use synthetic bits for IBRS/IBPB/STIBP
>
> Intel and AMD have different CPUID bits for those so use synthetic bits
> which get set on the respective vendor in init_speculation_control(). So
> that debacles like the commit message of
>
>   c65732e4f721 ("x86/cpu: Restore CPUID_8000_0008_EBX reload")
>

Patch doesn't hurt me. For me it´s ok.

Thanks, Jörg
