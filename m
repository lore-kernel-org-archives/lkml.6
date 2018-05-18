Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeERM32 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbeERM3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:29:25 -0400
X-Google-Smtp-Source: AB8JxZqkzIyU42bvYqPuXNkHvn4Xr0sxULhLaichi4IHDlhS4JYHivYauz5YIOjAkGoT0GjaX2akk1XcMxMLwuBivT0=
MIME-Version: 1.0
References: <1526512248-54510-1-git-send-email-sherry.hurwitz@amd.com>
In-Reply-To: <1526512248-54510-1-git-send-email-sherry.hurwitz@amd.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Fri, 18 May 2018 08:29:12 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6Xv1WeyBbSYXo94rtyUCxVBpBVw1zvNL+cB04-emdZtg@mail.gmail.com>
Message-ID: <CA+5PVA6Xv1WeyBbSYXo94rtyUCxVBpBVw1zvNL+cB04-emdZtg@mail.gmail.com>
Subject: Re: [PATCH 1/1] linux-firmware: Update AMD cpu microcode
To: sherry.hurwitz@amd.com
Cc: Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        suravee.suthikulpanit@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 9:44 PM Sherry Hurwitz <sherry.hurwitz@amd.com>
wrote:

> * Add AMD cpu microcode for processor family 17h
> * Update AMD cpu microcode for processor family 15h
> * Update the AMD cpu microcode license copyright
> * Add a Version for both microcode family 15h and 17h

> Key Name        = AMD Microcode Signing Key (for signing microcode
container files only)
> Key ID          = F328AE73
> Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

> Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
> ---
>   LICENSE.amd-ucode                      |   2 +-
>   WHENCE                                 |   4 +++-
>   amd-ucode/microcode_amd_fam15h.bin     | Bin 7876 -> 5356 bytes
>   amd-ucode/microcode_amd_fam15h.bin.asc |  14 +++++++-------
>   amd-ucode/microcode_amd_fam17h.bin     | Bin 0 -> 3364 bytes
>   amd-ucode/microcode_amd_fam17h.bin.asc |  11 +++++++++++
>   6 files changed, 22 insertions(+), 9 deletions(-)
>   create mode 100644 amd-ucode/microcode_amd_fam17h.bin
>   create mode 100644 amd-ucode/microcode_amd_fam17h.bin.asc

Applied and pushed out.  Thanks.

josh
