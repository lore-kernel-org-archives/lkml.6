Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeBXQqn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:46:43 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:39436 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeBXQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:46:42 -0500
X-Google-Smtp-Source: AG47ELtstChNcqW4ZgcPoitVU8OyGxyrwgzEwjiWWp0wox3jX6t1fuhHIfNi1+8mI8FguhIgiwoXY3fAIBRSZmiUYko=
MIME-Version: 1.0
In-Reply-To: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 24 Feb 2018 16:46:40 +0000
Message-ID: <CAKv+Gu82+nPRhKSzAvTvwWqVPhi0zhjN4uC8_ZzA7HvBLEuuig@mail.gmail.com>
Subject: Re: [PATCH 0/8] Decode IA32/X64 CPER
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yazen,

On 23 February 2018 at 20:03, Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>
> This series adds decoding for the IA32/X64 Common Platform Error Record.
>
> Patch 1 fixes the IA32/X64 Processor Error Section definition to match
> the UEFI spec.
>
> Patches 2-8 add the new decoding. The patches incrementally add the
> decoding starting from the top-level "Error Section". Hopefully, this
> will make reviewing a bit easier compared to one large patch.
>
> The formatting of the field names and options is taken from the UEFI
> spec. I tried to keep everything the same to make searching easier.
>
> The patches were written to the UEFI 2.7 spec though the definition of
> the IA32/X64 CPER seems to be the same as when it was introduced in
> the UEFI 2.1 spec.
>
> Without basic decoding, users will be confused about what these
> "Hardware Errors" mean. So I'm requesting this set to be applied to the
> stable branches. This set applies to the v4.16. However, patch 2 will
> have a conflict on older branches, so I'll send this set again with the
> conflict fixed.
>

These patches look mostly fine to me, with the exception of some minor nits.

I can queue this for v4.17 if you respin it, but I am not sending 400
lines of brand new error record parsing code to Greg for inclusion in
-stable, so please drop the cc stable tags

Thanks,
Ard.
