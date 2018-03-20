Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbeCTRwN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:52:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40195 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:52:10 -0400
X-Google-Smtp-Source: AG47ELvdyc0LBD8qWhR3LrAduqOuVp2ch40N8gQIlvJ4upfdGz1kg5EAUIl0T8097NlTOhIZ5jJAQw==
Date: Tue, 20 Mar 2018 10:52:08 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Mar 2018 10:51:59 PDT (-0700)
Subject: Re: [tip:irq/core 12/13] drivers/irqchip/irq-vic.c:295:2: error: implicit declaration of function 'set_handle_irq'; did you mean 'vic_handle_irq'?
In-Reply-To: <alpine.DEB.2.21.1803200852590.6506@nanos.tec.linutronix.de>
CC: fengguang.wu@intel.com, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com
From: Palmer Dabbelt <palmer@sifive.com>
To: tglx@linutronix.de
Message-ID: <mhng-673d4545-7e62-4815-bdac-33b0e990ec7e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018 00:53:21 PDT (-0700), tglx@linutronix.de wrote:
> On Tue, 20 Mar 2018, kbuild test robot wrote:
>
>> Hi Palmer,
>>
>> FYI, the error/warning still remains.
>
> Zapped the commit as well...

Sorry, I got the flu at ELC and have been offline for a bit.  It looks like
you've kept the IRQ and RISC-V patches, I'll fix up the others are re-submit
them as a separate patch set.
