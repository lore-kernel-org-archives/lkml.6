Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDEMvX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:51:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34456 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbeDEMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:51:21 -0400
X-Google-Smtp-Source: AIpwx48P4IqPSp8JEG4NyVLJJeowAEoqJmJfhYjkadDTXSX2wCQtM+1QE45ZtVXPo00Kvwjsx99Kr8z9nmQrgqq+wZs=
MIME-Version: 1.0
In-Reply-To: <CAFd5g47AeTtU_uYNOuDKroBwf_FMd+4Z7WgcCM5wyj2e_PEZrQ@mail.gmail.com>
References: <1521155412-29229-1-git-send-email-tmaimon77@gmail.com>
 <1521155412-29229-2-git-send-email-tmaimon77@gmail.com> <CAFd5g47AeTtU_uYNOuDKroBwf_FMd+4Z7WgcCM5wyj2e_PEZrQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 14:51:20 +0200
X-Google-Sender-Auth: xoVOOPRzLDyZSADQYk3SDjxIGcQ
Message-ID: <CAK8P3a2AtJUmP+cNVEdyiKJSAst+svNqvHrssgseAHnTzqj40w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm: npcm: modify configuration for the NPCM7xx BMC.
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Avi Fishman <avifishman70@gmail.com>, Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nancy Yuen <yuenn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 6:56 AM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> On Thu, Mar 15, 2018 at 4:16 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
>> Modify configuration and MakeFile
>> for the Nuvoton NPCM and NPCM7xx BMC.
>
>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>> ---
>>   arch/arm/mach-npcm/Kconfig  | 40 +++++++++++-----------------------------
>>   arch/arm/mach-npcm/Makefile |  4 +++-
>>   2 files changed, 14 insertions(+), 30 deletions(-)
>
> <snip>
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Sorry for missing this earlier, I did ask for the rework but then
didn't see it as it
wasn't in my arm@kernel.org inbox.

Tomer, please make sure that all patches you want to have included in
the kernel are sent to that address, while patches you want to have reviewed
are not sent to it.

Normally I don't apply patches during the merge window, but this one fixes
some build problems, so I've decided to take it.

       Arnd
