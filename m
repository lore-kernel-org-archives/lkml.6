Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933617AbeE2L5L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:57:11 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41020 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933418AbeE2L5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:57:09 -0400
X-Google-Smtp-Source: AB8JxZoL0oRDjlhpcJPkuFiVc2SJ9H9WQ9o04kF/i8FEfMOFeT067Df/Mwb3RmFgZdKy0uXgHLpJ1uBFbJmysfRJK1Y=
MIME-Version: 1.0
In-Reply-To: <20180529210257.26da8de7@canb.auug.org.au>
References: <20180529210257.26da8de7@canb.auug.org.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 29 May 2018 13:56:48 +0200
X-Google-Sender-Auth: 4Z-HL97SHvZtYUc8kyz6MVkDkgw
Message-ID: <CA+7wUsw4Us749j8yO5zpqfMcYWPMujwkNq0CRSSWWVFDJXLS0w@mail.gmail.com>
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

On Tue, May 29, 2018 at 1:02 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> My qemu boots of today's powerpc linux-next kernel produced the following
> boot message differences:
>
> -Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
> +Max number of cores passed to firmware: u (NR_CPUS = 2048)
>
> Seemingly caused by commit
>
>   eae5f709a4d7 ("powerpc: Add __printf verification to prom_printf")

My bad. Patch is pending (thanks Michael!):

https://patchwork.ozlabs.org/patch/921948/

> --
> Cheers,
> Stephen Rothwell
