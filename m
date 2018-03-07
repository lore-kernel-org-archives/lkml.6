Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933870AbeCGPuZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:50:25 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40998 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933386AbeCGPuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:22 -0500
X-Google-Smtp-Source: AG47ELtpw7uHXmk9P1rl0L0AZ7FUXsrsWzjMuxhl8Mhqvb6PQTPoMTkdLRGKM+dHBXS4HSIR/K5vor9wb1jZfoQ2x0Q=
MIME-Version: 1.0
In-Reply-To: <1520296873-12982-2-git-send-email-santosh.shilimkar@oracle.com>
References: <1520296873-12982-1-git-send-email-santosh.shilimkar@oracle.com> <1520296873-12982-2-git-send-email-santosh.shilimkar@oracle.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 16:50:21 +0100
X-Google-Sender-Auth: zckP0E9h8SKhkYVQlJju83eKpbI
Message-ID: <CAK8P3a3HbkMJsppb4jN-755T-8CyASsN7kJ1ZLTg31XXeBnO=A@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] SOC: Couple of drivers changes for v4.17
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 1:41 AM, Santosh Shilimkar
<santosh.shilimkar@oracle.com> wrote:
> The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:
>
>   Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.17
>
> for you to fetch changes up to a817e5d82a2dc5daaa0a8a66cfab268fdf2f6bb6:
>
>   memory: ti-emif-sram: remove redundant dev_err call in ti_emif_probe() (2018-03-05 16:21:31 -0800)
>
> ----------------------------------------------------------------
> SOC driver changes for v4.17
>
>  - Remove deundant dev_err from probe in ti-emif-srma driver
                     ^^ I fixed the typo while applying

>  - Make use of seq_putc in emif reg show

Pulled into next/drivers, thanks!

        Arnd
