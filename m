Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeBUIpu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:45:50 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:35285 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeBUIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:45:49 -0500
X-Google-Smtp-Source: AG47ELs9GQwD44RkNjEI0OLzhqc9Rk9KL/6Aeb2aHn/q76/6qlD4Zo2SsHgvRttDjo8xRGEs8ZCR8V+neB/14Tj3F68=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802191549270.1853@nanos.tec.linutronix.de>
References: <CABbc0=RMYWGN0L=z_Y=FuZJUDzD5NVa2XBTVnmpZxX5tnk3-5g@mail.gmail.com>
 <alpine.DEB.2.21.1802141306360.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802150948530.1673@nanos.tec.linutronix.de>
 <CABbc0=QZY8d_Kyd5hX5X99S60ANrncPSk785FpZTAJS+C9_tDQ@mail.gmail.com>
 <alpine.DEB.2.21.1802181901520.1549@nanos.tec.linutronix.de> <alpine.DEB.2.21.1802191549270.1853@nanos.tec.linutronix.de>
From: Yuriy Vostrikov <delamonpansie@gmail.com>
Date: Wed, 21 Feb 2018 11:45:48 +0300
Message-ID: <CABbc0=RVr5MD2v5G8tJ8Aqz+eJHPv6RXkCc73LpFH1BAm19OQw@mail.gmail.com>
Subject: Re: linux acpi (thunderbolt? bug)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 February 2018 at 17:51, Thomas Gleixner <tglx@linutronix.de> wrote:
> The patch below should cure it.

After applying the patch I'm no longer unable to reproduce the bug. Thank you!

Yuriy
