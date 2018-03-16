Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeCPF4R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:56:17 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44654 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeCPF4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:56:16 -0400
X-Google-Smtp-Source: AG47ELvDceex6uzmRuxJkCA0VATts0QlUukDIiwnxZS2NWPIPUR2PzcEi3NSioMm4BaMPSQ8suzMULaDfHagRi2rGtY=
MIME-Version: 1.0
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com> <1521155412-29229-2-git-send-email-tmaimon77@gmail.com>
In-Reply-To: <1521155412-29229-2-git-send-email-tmaimon77@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 16 Mar 2018 05:56:04 +0000
Message-ID: <CAFd5g47AeTtU_uYNOuDKroBwf_FMd+4Z7WgcCM5wyj2e_PEZrQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm: npcm: modify configuration for the NPCM7xx BMC.
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Patrick Venture <venture@google.com>,
        Avi Fishman <avifishman70@gmail.com>, Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nancy Yuen <yuenn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 4:16 PM Tomer Maimon <tmaimon77@gmail.com> wrote:

> Modify configuration and MakeFile
> for the Nuvoton NPCM and NPCM7xx BMC.

> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>   arch/arm/mach-npcm/Kconfig  | 40 +++++++++++-----------------------------
>   arch/arm/mach-npcm/Makefile |  4 +++-
>   2 files changed, 14 insertions(+), 30 deletions(-)

<snip>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
