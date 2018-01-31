Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeAaCWe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:22:34 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44370 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753035AbeAaCWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:22:31 -0500
X-Google-Smtp-Source: AH8x2249PK8ZAzKqoinQp/Og3qiEtbY/mGf8duVJk9FjDvDS6nsVt8TVntn4pQSWTAft9NXWw3ZI1g==
Date: Tue, 30 Jan 2018 21:22:05 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Change ISA_BUS_API dependency to selection
Message-ID: <20180131022151.GA14668@sophia>
References: <cover.1514578085.git.vilhelm.gray@gmail.com>
 <CACRpkdbBA0DX22ZGSkQxi+euTSROPzsmLTvSPwY8peg6+7igFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdbBA0DX22ZGSkQxi+euTSROPzsmLTvSPwY8peg6+7igFQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2018 at 10:29:30AM +0100, Linus Walleij wrote:
>On Fri, Dec 29, 2017 at 9:13 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> Linus, please pickup this entire patchset through your GPIO subsystem
>> tree; a recursive dependency error is present if these patches are
>> cherry-picked (see https://lkml.org/lkml/2017/12/26/235), so they should
>> be merged together in the same tree.
>
>OK I just need a bunch of ACKs so giving subsystem maintainers some
>days to come back on this.
>
>Yours,
>Linus Walleij

Hi Linus,

Do you have any objections to picking up this patchset now; or would you
prefer to wait for some more input from the other maintainers?

William Breathitt Gray
