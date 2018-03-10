Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeCJUba (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 15:31:30 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:41758 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeCJUb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 15:31:28 -0500
X-Google-Smtp-Source: AG47ELsSdMn5R4HOenIDti5PH/bz4iWcsqEhKPP4y1o1WnLadRdXLEg435tQhVni3QcTMv99iYPvxS2zGST3eTcQYeI=
MIME-Version: 1.0
In-Reply-To: <287cdb39-92ed-79d7-82a0-69063e9d49e0@arm.com>
References: <1518441176-6107-1-git-send-email-festevam@gmail.com> <287cdb39-92ed-79d7-82a0-69063e9d49e0@arm.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 10 Mar 2018 17:31:27 -0300
Message-ID: <CAOMZO5AUf2KUug-y6YCUuqAZ9yzOzZNkWs8EhAhQKvGdiRyarw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/irq-imx-gpcv2: Remove unused function
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Feb 12, 2018 at 11:22 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> I'll queue this up for -rc2, with this addition:
>
> Fixes: e324c4dc4a59 ("irqchip/imx-gpcv2: IMX GPCv2 driver for wakeup
> sources")

It seems this one got missed?

Thanks
