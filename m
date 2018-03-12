Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeCLOH4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:07:56 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42106 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeCLOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:07:53 -0400
X-Google-Smtp-Source: AG47ELuXVg2lQSP7eFKgIpv0+XJlrSqCXyHPSJwmstM1nNhS34kRHJbsJCgqtOHAx/ezbe5Uwu/Vbuv3ZWG2Rh5T+2M=
MIME-Version: 1.0
In-Reply-To: <20180310052601.GA6294@piout.net>
References: <20180310052601.GA6294@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 12 Mar 2018 15:07:52 +0100
X-Google-Sender-Auth: LbsSBIhFLBLXUBNTnmJ41lueTv4
Message-ID: <CAK8P3a0LOjORi7f_YEp+zk28CTrvo7RLS-BmnooRL11MH2nh5A@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: at91: DT for 4.17
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 6:26 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Arnd, Olof,
>
> Not much this cycle, mainly changes on the Axentia boards from Peter and
> a cleanup from Bartosz.
...
> AT91 DT for 4.17:
>
>  - use 'atmel' as at24 manufacturer
>  - device addition and fixes for axentia boards
>  - fix sama5d4 pinctrl compatible

I added the first sentence to the commit log and pulled it into next/dt.
Generally speaking, I find those cleartext descriptions are more helpful
than a list that repeats the list of commits.

      Arnd
