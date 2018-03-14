Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCNQ03 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:26:29 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38269 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbeCNQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:26:27 -0400
X-Google-Smtp-Source: AG47ELvux/He+oNIP7IscATDxFLiZSV56bILUM+RqpqpV5ZH3r99BK4g9lDWAtkYbVAadTHg1KVEWh1k6EZoGOBIUK0=
MIME-Version: 1.0
In-Reply-To: <20180314161212.GS2186@sirena.org.uk>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-16-arnd@arndb.de>
 <20180314161212.GS2186@sirena.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 17:26:25 +0100
X-Google-Sender-Auth: WP4qPNjDt3_dadmcV5CMV6FP_sc
Message-ID: <CAK8P3a1AX16ekADiZeLuDXp9+mPQaOxNa4bGy1ptquEdO3AC6g@mail.gmail.com>
Subject: Re: [PATCH 15/47] ASoC: remove blackfin drivers
To: Mark Brown <broonie@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 5:12 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Mar 14, 2018 at 04:35:28PM +0100, Arnd Bergmann wrote:
>
>> The blackfin architecture is getting removed, so the ASoC drivers
>> are all obsolete as well.
>
> This is going to cause loads of conflicts due to the ASoC platform to
> component refactoring - can you send me something that I can git am
> directly against my -next please, it seems better to apply it there so
> that nobody needs to see the conflicts?

Done.

      Arnd
