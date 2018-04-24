Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeDXSsX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:48:23 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:37858 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeDXSsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:48:21 -0400
X-Google-Smtp-Source: AIpwx4/Wa5eDVqqpBD+p1DgBteM+eMKjc4fjZGgv9/3GJA+iK+/3PjacZUcTQWjNUf5M60nXrByw8ASEhxdXFlpqlwo=
MIME-Version: 1.0
In-Reply-To: <87fu3spmy9.fsf@concordia.ellerman.id.au>
References: <20180417104909.22D416C07D@po15720vm.idsi0.si.c-s.fr>
 <CA+7wUszKbPKu86jSprEBJsxJOmyAc42x5S4XmPce_RFXTsHTfQ@mail.gmail.com>
 <e49e2296-11f8-a2fa-6b64-db18ba5db641@c-s.fr> <CA+7wUswJoGnb50y8jbPfsi9ztCO1jZ+O4cirHtXc7gp7MXRm5Q@mail.gmail.com>
 <48cdb73c-f0c4-0c8a-19f5-8fce000e7050@c-s.fr> <CA+7wUszJzG4CyfO2_Tvmc_u9oMPxLQMaiP+HnhpEex6KCRgSYw@mail.gmail.com>
 <87fu3spmy9.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 24 Apr 2018 20:48:00 +0200
X-Google-Sender-Auth: 0XyWAeVAfIoMuR8irjyAJSpM9Hw
Message-ID: <CA+7wUsyO1QR6wzR9_Lj856m9OKOpvz4OjQKKY8SXe-iG+TbWRg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Allow selection of CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 5:13 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Mathieu Malaterre <malat@debian.org> writes:
>> On Wed, Apr 18, 2018 at 8:34 AM, Christophe LEROY
> ...
>>
>>> Can you also provide a copy of the messages you can see (prom_init ...) when
>>> boot is ok ?
>>
>> Hum. I've always been interested in seeing it also myself. Is there a
>> way to setup env to see those message (netconsole, delayed boot
>> messages ...) ? I never found a clear documentation on how to do that
>> on (closed) Apple hardware.
>
> If you see nothing after prom_init it usually indicates the kernel died
> very early in boot before it could find the console.
>
> The only option then is to enable one of the hard-coded EARLY_DEBUG
> options.

Right I see them now.

> I don't know which one works on a G4, maybe CONFIG_PPC_EARLY_DEBUG_BOOTX ?

Exactly !

> I assume it doesn't have a serial port.

- 56K Modem line (yes really!)
- 2 USB
- 1 Firewire

:(

> cheers
