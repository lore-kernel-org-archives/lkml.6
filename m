Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755064AbeDZJOP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:14:15 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45165 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754936AbeDZJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:13:53 -0400
X-Google-Smtp-Source: AIpwx49iVhrte+Qojvsyaeex1+HGmUuy0oqLvKCC7XLKk7NkzhZ3W+dKHi8aOZ48kzumbbGTAGdgh0hHdshS0o8AonY=
MIME-Version: 1.0
In-Reply-To: <20180406124135.46622-1-govert.overgaauw@prodrive-technologies.com>
References: <20180406124135.46622-1-govert.overgaauw@prodrive-technologies.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 11:13:51 +0200
Message-ID: <CACRpkdbBOiC2EXuZvwCJHz3ucNGtNmu2vumFa=68fPXfM2_dSA@mail.gmail.com>
Subject: Re: [PATCH] gpio: fix aspeed_gpio unmask irq
To: Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>
Cc: Joel Stanley <joel@jms.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 2:41 PM, Govert Overgaauw
<govert.overgaauw@prodrive-technologies.com> wrote:

> The unmask function disables all interrupts in a bank when unmasking an
> interrupt. Only disable the given interrupt.
>
> Signed-off-by: Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>

Patch applied for fixes as obviously correct and also tagged
for stable.

Yours,
Linus Walleij
