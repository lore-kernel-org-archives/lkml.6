Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933163AbeCFWKE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:10:04 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:42783 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932753AbeCFWKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:10:02 -0500
X-Google-Smtp-Source: AG47ELuEgN7WoifpfmInkjwP5TsN+/sHPXtLqdPe7Va8xIrfZweXTiPMFl4nnNcjoxmBoNSXDpvruN3jmBZ3xlMN4dg=
MIME-Version: 1.0
In-Reply-To: <20180306213350.GH13586@sirena.org.uk>
References: <20180305231246.GB5799@atomide.com> <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk> <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
 <20180306191218.GF13586@sirena.org.uk> <CAOMZO5BfEfXN6OgxXswm8qFDbxDJKdUJmhDZGr_DBOh8fbtodA@mail.gmail.com>
 <20180306213350.GH13586@sirena.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 6 Mar 2018 19:10:01 -0300
Message-ID: <CAOMZO5BPyY3WUYUhV76HGdb_NbCv9riFdtEFaku2k4dd9-A_FQ@mail.gmail.com>
Subject: Re: Regulator regression in next-20180305
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Maciej Purski <m.purski@samsung.com>,
        linux-omap@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 6:33 PM, Mark Brown <broonie@kernel.org> wrote:

> No, unfortunately, apart from the generic kernel ones (like lockdep).
> I'll try to have a poke at adding some tomorrow, though I'm also
> considering just dropping the series for now.

Ok, lockdep is already enabled by default in the defconfig I am using
(imx_v6_v7_defconfig).

Yesterday I spent a few hours trying to understand this locking issue,
but didn't get any success on this task.

Thanks
