Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeDXSdS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:33:18 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:43116 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeDXSdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:33:16 -0400
X-Google-Smtp-Source: AIpwx4/ocZEOi6g6GmDeBBpS2C0aP6tTwaJW742YlTY9944Dc9aoPejZ/U3tfvCpVh8hnKrltgDJBp3OYVpm+hYZnjE=
MIME-Version: 1.0
In-Reply-To: <122064928.616643.1524594231224@mail.yahoo.com>
References: <20180420212641.30338-1-antonio.intilisano@gmail.com>
 <a62dded5-0fa9-1a6e-dd71-3e03cc311f1f@debian.org> <CAHp75VdSOGnN5=yxkk1m3=7rBKR1PU3NfO6QNp7wYR7Qx6mWkA@mail.gmail.com>
 <1690760144.5633578.1524494921916@mail.yahoo.com> <CAHp75VeDhyKmcJqA5paqJEPsw-gpzq7iJee+zu=ZMqUpDv0_6A@mail.gmail.com>
 <1524589355.21176.507.camel@linux.intel.com> <122064928.616643.1524594231224@mail.yahoo.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 24 Apr 2018 21:33:14 +0300
Message-ID: <CAHp75VdMHqo=S+xgFPSv7U+3mHn7DpjXC0KSgSZB+wDZLwRV4Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: add another KEY_POWER keycode
To: Gianfranco Costamagna <locutusofborg@debian.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Antonio Rosario Intilisano <antonio.intilisano@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "vger@kernel.org" <vger@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 9:23 PM, Gianfranco Costamagna
<locutusofborg@debian.org> wrote:
> Hello Andy,
>
>>Or I missed the point and it's working? Tell me what to do with it.
>>For now I pushed to my review and testing queue, thanks!
>
>
> Antonio did patch and build a custom kernel locally (testing was successful), and submitted
> the patch to me.
>
> I pinged some Ubuntu folks to get it applied, and also testing with the .deb provided
> by kernel team was good, so I presume this is a safe patch that can be applied right now
> as-is.
> (this is a trivial patch, Antonio told me in another channel that he can also create and post
> failures logs before and after, as well as do some video with the key pressed).
>
> I don't think this is needed, but if you want it for historical purposes, just ask and we will
> do our best to provide them!

Thanks for a sync.

What I asked before still stands, i.e. would be nice to have Tested-by
tag by someone who actually tested the change.

Feel free to respond here with it I hope patchwork catch it up.

-- 
With Best Regards,
Andy Shevchenko
