Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeBZNaE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:30:04 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37666 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeBZNaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:30:03 -0500
X-Google-Smtp-Source: AG47ELvuSq8qIiuiTpW9Uzy9hXjzKGcnsve2BX52zNCxmi/KOyZsqJeVthwFMsBioi2NxuZ57ORMO4EqohN7mrhlSQY=
MIME-Version: 1.0
In-Reply-To: <1519650228-6271-1-git-send-email-alexandre.torgue@st.com>
References: <1519650228-6271-1-git-send-email-alexandre.torgue@st.com>
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Date: Mon, 26 Feb 2018 14:30:02 +0100
Message-ID: <CALszF6D9cpiwnc9a+ZeOiED5Fgv1yLLxJrO7rH9fKttLja-jZg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update entries for ARM/STM32
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 14:03 GMT+01:00 Alexandre Torgue <alexandre.torgue@st.com>:
> Changes old git repository to the maintained one and adds more patterns.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bdc260..802b984 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1999,8 +1999,10 @@ M:       Maxime Coquelin <mcoquelin.stm32@gmail.com>
>  M:     Alexandre Torgue <alexandre.torgue@st.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
>  N:     stm32
> +F:     arch/arm/boot/dts/stm32*
> +F:     arch/arm/mach-stm32/
>  F:     drivers/clocksource/armv7m_systick.c
>
>  ARM/TANGO ARCHITECTURE
> --
> 2.7.4
>

Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Thanks,
Maxime
