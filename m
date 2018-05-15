Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeEOKmy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbeEOKmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:42:52 -0400
X-Google-Smtp-Source: AB8JxZrJRAnoOJkH/9Y5nShuQeVSwl9lvpSV2EMGVKazlOUSFei8o198ES/TaHEgP1I2f28J2nNn/di7UjL7yzztenA=
MIME-Version: 1.0
In-Reply-To: <20180509224313.5e5fe381@canb.auug.org.au>
References: <20180503020550.GP2714@sirena.org.uk> <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net> <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com> <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk> <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk> <20180509204727.7ff38021@canb.auug.org.au>
 <20180509105534.GE7985@vkoul-mobl> <20180509224313.5e5fe381@canb.auug.org.au>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 15 May 2018 12:42:49 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf=y_D4qA-M=cf4nuL3-J4D9k5UrVo=fDPjJwtntCUBFA@mail.gmail.com>
Message-ID: <CAJKOXPf=y_D4qA-M=cf4nuL3-J4D9k5UrVo=fDPjJwtntCUBFA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "ksummit-discuss@lists.linuxfoundation.org"
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 2:43 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Vinod,
>
> On Wed, 9 May 2018 16:25:34 +0530 Vinod Koul <vinod.koul@linaro.org> wrote:
>> >
>> > I currently have 44 such fixes branches.  More welcome!
>>
>> Great so do you want us to send fixes branch or scan the existing trees and add
>> them.
>
> The former.

Please merge following fixes branches from my trees:
Tree: samsung-krzk
git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
branch: fixes

Tree: pinctrl-samsung
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git
branch: pinctrl-fixes

Although both are currently empty... but I guess you are collecting
this also for future.

Best regards,
Krzysztof
