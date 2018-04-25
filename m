Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755014AbeDYPH4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:07:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41180 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754931AbeDYPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:07:28 -0400
X-Google-Smtp-Source: AB8JxZp8fKxAIm1B4gYP3HtE5RT5nv5vFQJm3z7GXIBx2Q3+3LzK4NY+FE8CgnIHIOcxg6l0F16CBaggaRgLFyYnZRI=
MIME-Version: 1.0
In-Reply-To: <20180425132242.1500539-2-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de> <20180425132242.1500539-2-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 Apr 2018 17:07:26 +0200
X-Google-Sender-Auth: uICsmVZZCTpYOUrUmvZoOeyu7Tg
Message-ID: <CAK8P3a32SQ=6138C0BZ5QMPe9LNwWgVi1pYvx-MGkGemCQ+11g@mail.gmail.com>
Subject: Re: [PATCH v4 01/16] y2038: asm-generic: Extend sysvipc data structures
To: y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 3:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Most architectures now use the asm-generic copy of the sysvipc data
> structures (msqid64_ds, semid64_ds, shmid64_ds), which use 32-bit
> __kernel_time_t on 32-bit architectures but have padding behind them to
> allow extending the type to 64-bit.

Sorry for any duplicate mails you may have receive. I forgot to use '--cc-cover'
with git-send-email as I had intended at first.

      Arnd
