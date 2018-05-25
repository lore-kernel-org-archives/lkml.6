Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966607AbeEYMMK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:12:10 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33865 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966448AbeEYMMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:12:07 -0400
X-Google-Smtp-Source: AB8JxZr5WIDR9BomW0z+eFHvhubIBeeLX1dlx9qHng7GSODqUDZKqI6HlfoTjasfW9s718rRP0Ieldtji6JDAgXpx/I=
MIME-Version: 1.0
In-Reply-To: <20180525050103.3hg3u2v5mvftqhht@linaro.org>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
 <20180520051736.4842-6-manivannan.sadhasivam@linaro.org> <CACRpkdYF7a-uwye0uwn-pT9Bprj74q1-Pcbq4WLyiE+kYY4j7w@mail.gmail.com>
 <25d1c303-71d7-8c38-880f-7bb0e133a876@suse.de> <20180525050103.3hg3u2v5mvftqhht@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 May 2018 14:12:06 +0200
Message-ID: <CACRpkdaTQOWA_5nyasxTwE=cGRis+uaLhw66pmkd+qPxMC6FFQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add Actions Semi S900 pinctrl entries
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, liuwei@actions-semi.com,
        96boards@ucrobotics.com,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 7:01 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> FYI, I have ordered S700 based Cubieboard and will work on adding support for
> that first. I still don't have access to S500 board yet since it is not
> available on my region. Will find a way to get this asap.

Awesome, then we can count on some actions action here.

>> Also I had been investing efforts in explaining the upstreaming process
>> to Actions, last in November. I see Thomas Liau and Jeff Chen missing in
>> CC and I have not seen any Reviewed-by or Acked-by from anyone at
>> Actions on this and the preceding series. There are more chips than the
>> one on Linaro's 96board, so I would prefer to assure that the design
>> works for all. Thus I am very critical of you applying the patches
>> without waiting for review by Actions.
>
> I don't think Actions would be interested in any upstreaming efforts. It
> is our (comunity) responsibility to add support for that in order to
> have our boards running mainline kernel and that's what we both have been
> doing. Moreover I only saw once David Liau responded to your patchset and
> there isn't much further. So how can you expect the subsystem maintainer's
> to hold the patch series waiting for a so far silent SoC manufacturer's
> response?

They are certainly informed now! :D

Actions semi folks, please familiarize yourself with the following:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/tree/Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt?h=devel
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/tree/drivers/pinctrl/actions?h=devel

If you have any concerns with this, now is a good time to share them.

> I
> did ask you to add me as Co-Maintainer but you didn't responded to that.
> I know that I can't send any pull requests to Arnd, but we should sort
> it out IMO. Also, if you are completely swamped, then I take take up the
> maintainership role now inorder to keep the things moving. TBH I don't
> want my patches to be floating for months without any reason.

Doing some comainatinership can very well include doing pull
requests as long as you agree on who does what.

I think it may be a bit late for the next merge window right now,
but if you simply queue up stuff in some git tree and ask
Srothwell to include it in linux-next then Andreas can very well
pull it to his tree from there and then to ARM SoC or you can
queue patches as well.

Yours,
Linus Walleij
