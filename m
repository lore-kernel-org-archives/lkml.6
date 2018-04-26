Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755199AbeDZW6y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:58:54 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:45009 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeDZW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:58:52 -0400
X-Google-Smtp-Source: AB8JxZo4bILslx9XWasfL2eKLtTvTlwoJEFwA07RKxTHJOKYTH5vj5pnUJyIlat/WuQFcjliqMZCm15SCtYXnYAaSuA=
MIME-Version: 1.0
In-Reply-To: <bc752fb8-8f2f-70bc-e786-221eb39c618b@opensource.cirrus.com>
References: <20180313131904.13700-1-rf@opensource.cirrus.com>
 <20180313131904.13700-8-rf@opensource.cirrus.com> <CACRpkdZspUbmCk7OwA-rva6zd89TZXt45t5mFes0feuRyOUp9w@mail.gmail.com>
 <bc752fb8-8f2f-70bc-e786-221eb39c618b@opensource.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Apr 2018 00:58:51 +0200
Message-ID: <CACRpkdYjkcjvNyxcLFezSMQ9f9ERNTCcaNv2PYqn8WLgayjJvg@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] pinctrl: madera: Add DT bindings for Cirrus Logic
 Madera codecs
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, patches@opensource.cirrus.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 10:53 AM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> What is your opinion of the i.MX6 pinctrl failure after my bugfix patch
> for the hogs?

Don't know yet. I will answer to that patch, when I get to it.

> If you would want to revert my patch I would need to change this pinctrl
> driver so it has its own child node as a workaround to the hog bug.
>
> Or do you think it is more likely a bug in the i.MX6 pinctrl driver?

No idea yet. I bet you folks have battled it out and know it better
than me already.

Yours,
Linus Walleij
