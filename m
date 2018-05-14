Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeENFy0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 01:54:26 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:41107 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeENFyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 01:54:24 -0400
X-Google-Smtp-Source: AB8JxZo7XOzp987lzIRmgFCCT01bk1/oO83oXFpCmWRurJanrt6cQA8/DjACkcM/EXm0HzK95do+hyspRoJdZxT6vT8=
MIME-Version: 1.0
In-Reply-To: <20180419150119.5yhf3uupdolg3cnv@localhost.localdomain>
References: <20180212131717.27193-1-linus.walleij@linaro.org>
 <20180212131717.27193-17-linus.walleij@linaro.org> <20180213111147.kr4kecqbhmcoq6w2@localhost.localdomain>
 <CACRpkdZVoYsdWy6GwnnSfaSc2_wycEse3JswqufqDoz=GFb5FQ@mail.gmail.com> <20180419150119.5yhf3uupdolg3cnv@localhost.localdomain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 07:54:22 +0200
Message-ID: <CACRpkdahS9VGvRKKedfgAqa8zpDj3ASGa3atwtF=BY794ne5tw@mail.gmail.com>
Subject: Re: [PATCH] ARM: s3c64xx: Tidy up handling of regulator GPIO lookups
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        patches@opensource.cirrus.com, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 5:01 PM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> From: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Rather than unconditionally registering the GPIO lookup table only do so
> for devices that require it.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> Do you have any objections to the following?
>
> If we are lucky I might be able to find time to test these early
> next week. Well at least there is reasonable chance I can test
> the 5102 stuff when you resend, not sure I have a device to
> test the wm1277 but will have a look. Also I haven't run up
> Cragganmore in a little while so might depend a little on how
> much people have broken it since last I did :-)

I folded this in on top of my series, also adding the table entries
for wm5102 and wm5102 reva.

Sorry for the delay, I was sidetracked...

Yours,
Linus Walleij
