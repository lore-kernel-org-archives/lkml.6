Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966572AbeEYMKp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966243AbeEYMKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:10:43 -0400
X-Google-Smtp-Source: ADUXVKI9Cei7hdulT053YsofuWy3YQSd+Z3EUW3+jj4CrdNWGE7qz1evLFyJs+q4ee4u/NaYs4jCzgWDJw/gg1X1XHE=
MIME-Version: 1.0
References: <1527213479-121361-1-git-send-email-sherry.hurwitz@amd.com>
In-Reply-To: <1527213479-121361-1-git-send-email-sherry.hurwitz@amd.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Fri, 25 May 2018 08:10:30 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7aPRHk=kfxsmPi-qStKEnK_HJ=rTjvtQGO1QbnLb9qBw@mail.gmail.com>
Message-ID: <CA+5PVA7aPRHk=kfxsmPi-qStKEnK_HJ=rTjvtQGO1QbnLb9qBw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Update AMD cpu microcode for family 15h
To: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        hmh@debian.org, r.marek@assembler.cz, suravee.suthikulpanit@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:13 PM Sherry Hurwitz <sherry.hurwitz@amd.com>
wrote:

> * Processor Revision ID 0x00610f01 was accidently not included in the
previous
>    submitted microcode container file.
> * Update the Version for family 15h microcode .bin file

> Key Name        = AMD Microcode Signing Key (for signing microcode
container files only)
> Key ID          = F328AE73
> Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

> Signed-off-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
> ---
>   WHENCE                                 |   2 +-
>   amd-ucode/microcode_amd_fam15h.bin     | Bin 5356 -> 7876 bytes
>   amd-ucode/microcode_amd_fam15h.bin.asc |  14 +++++++-------
>   3 files changed, 8 insertions(+), 8 deletions(-)

Applied and pushed out.

josh
