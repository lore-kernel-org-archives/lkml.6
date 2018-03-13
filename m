Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeCMOJC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:09:02 -0400
Received: from web2.default.djames.uk0.bigv.io ([213.138.101.246]:52056 "EHLO
        web2.default.djames.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751616AbeCMOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:09:00 -0400
X-Google-Smtp-Source: AG47ELsaB5wbdW+xgIpAVLjXQ3ROTDBrx8L/CNacMvYRkq+lml030GQeHr+yuL4SIb1mQRIuUCu4k4W2tpEMkY3CRSA=
MIME-Version: 1.0
In-Reply-To: <20180312183521.GP2186@sirena.org.uk>
References: <20180312155753.9478-1-codekipper@gmail.com> <20180312155753.9478-7-codekipper@gmail.com>
 <20180312183521.GP2186@sirena.org.uk>
From: Chris Obbard <chris@64studio.com>
Date: Tue, 13 Mar 2018 13:39:44 +0000
X-Gmail-Original-Message-ID: <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
Message-ID: <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 6/6] ASoC: sun4i-i2s: Add support for loopback
To: broonie@sirena.org.uk
Cc: Code Kipper <codekipper@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        be17068@iperbole.bo.it
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

>
>> +- loopback:  if this property is present then the dai is configured in
>> +             loopback mode where the output fifo is redirected to the input
>> +             fifo.
>
> This really doesn't seem like something that ought to go into the DT
> and hence ABI given that there's obviously no reason to use this in
> production.  Just make it be a #define in the code or something.

It would be nice to have this as an optional devicetree property so
when testing JACK latency etc I don't have to manually re-compile a
kernel...
