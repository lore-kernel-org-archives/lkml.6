Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755902AbeEaRLy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:11:54 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51743 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755691AbeEaRLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:11:47 -0400
X-Google-Smtp-Source: ADUXVKK8AZTte4N7vZqXXpT0e7PEI2jHT08V4+mA/xjOdGRCu5EXTg2kLA/0nqmJheJO8D7wQ0MyF9msuQ/OFBOkXyo=
MIME-Version: 1.0
In-Reply-To: <CAP03XeoY8_-gG-2h8WP+3ZZFzxeyHERG=o7Y3Btk2svy5kco_Q@mail.gmail.com>
References: <20180531165109.8476-1-jagan@amarulasolutions.com> <CAP03XeoY8_-gG-2h8WP+3ZZFzxeyHERG=o7Y3Btk2svy5kco_Q@mail.gmail.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 31 May 2018 22:41:46 +0530
Message-ID: <CAMty3ZCM55Ug__=t9_JLnq2rcc6GZN5byZn26kyApGR=+_FaWA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2] arm64: allwinner: a64-amarula-relic:
 Enable AP6330 WiFi support
To: Christopher Obbard <chris@64studio.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:25 PM, Christopher Obbard <chris@64studio.com> wrote:
> Hi Jagan,
>
> I cannot find any information on this board online, so I am guessing
> it has not been released yet and you are developing software support
> now.
>
> Do you have any datasheet/overview document of the board?

It's an industrial board for a real product and not so different than
what we supported a software for other A64 boards [1], I will update
the wiki for the same in couple of days.

[1] https://openedev.amarulasolutions.com/display/ODWIKI/A64

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
