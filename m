Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756706AbeDCWkD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:40:03 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45326 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755322AbeDCWjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:39:37 -0400
X-Google-Smtp-Source: AIpwx48guNFEG/HrIVEl65/xX4bveDr6PaCLsHZEreVcJa78dgTnTi7zjcBXp5iR5SPfW71fW9FEcQ==
Date: Tue, 03 Apr 2018 15:39:36 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Apr 2018 15:37:40 PDT (-0700)
Subject: Re: [GIT pull] irq updates for 4.17
In-Reply-To: <alpine.DEB.2.21.1804031349110.2511@nanos.tec.linutronix.de>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
From: Palmer Dabbelt <palmer@sifive.com>
To: tglx@linutronix.de
Message-ID: <mhng-524aadcd-1897-4376-ab3c-10c43e79793d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Apr 2018 05:03:56 PDT (-0700), tglx@linutronix.de wrote:
> Palmer Dabbelt (2):
>       genirq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER
>       RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER handler

Oh, sorry, I must have screwed something up here.  I attempted to send out a v4 
of this patch set that doesn't break ARM here

    https://lkml.org/lkml/2018/3/27/671

I assume it's too late to swap this out for that?  If so that's OK, I can just 
send a follow-on.

Sorry for breaking things!
