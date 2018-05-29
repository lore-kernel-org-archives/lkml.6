Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933683AbeE2MBL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:01:11 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40797 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933652AbeE2MBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:01:06 -0400
X-Google-Smtp-Source: ADUXVKKDWnp/sQFjJZFWeCok7SNmst4r4PmLPBR3w5xYoJkbaq2Rca+HJKHPHMSK9+8nGxdcXwS1BinnNyFKmVNfdRM=
MIME-Version: 1.0
In-Reply-To: <CA+7wUsw4Us749j8yO5zpqfMcYWPMujwkNq0CRSSWWVFDJXLS0w@mail.gmail.com>
References: <20180529210257.26da8de7@canb.auug.org.au> <CA+7wUsw4Us749j8yO5zpqfMcYWPMujwkNq0CRSSWWVFDJXLS0w@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 29 May 2018 14:00:45 +0200
X-Google-Sender-Auth: lIV7iGxfyJz4VOsICO2nBxagq0Y
Message-ID: <CA+7wUswm60dZAfnTYJ-2p3o1H1ubwn1_OH7GSu9Y_PRKKCHJog@mail.gmail.com>
Subject: Re: linux-next: boot messages from today's linux-next
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 1:56 PM, Mathieu Malaterre <malat@debian.org> wrote:
> On Tue, May 29, 2018 at 1:02 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> My qemu boots of today's powerpc linux-next kernel produced the following
>> boot message differences:
>>
>> -Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
>> +Max number of cores passed to firmware: u (NR_CPUS = 2048)
>>
>> Seemingly caused by commit
>>
>>   eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")
>
> My bad. Patch is pending (thanks Michael!):
>
> https://patchwork.ozlabs.org/patch/921948/

Nope, nevermind this is unrelated.

>> --
>> Cheers,
>> Stephen Rothwell
