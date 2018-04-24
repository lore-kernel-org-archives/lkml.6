Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbeDXSX7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:23:59 -0400
Received: from sonic305-34.consmr.mail.ir2.yahoo.com ([77.238.177.96]:39777
        "EHLO sonic305-34.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752700AbeDXSXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:23:55 -0400
X-YMail-OSG: vOQJGGMVM1nTEQa7SV01NVYYRF2DemAncPutE_vCO82h2zcZ9YQfD_yJSbKdzsz
 yQZ9wnb64lPQNpwkpnCqF3SyaKXzZS7MBhKsEkS35Ry0vuTl9c.ZEeJDX851S2dIMBjniASF2tdG
 e8kyZKFzHBWS7CKDRvr6oVh06pVFNzzorTafT3p3ulAt1XkC6lwdsx0luyZz_MeeTlwoW1fCFVc0
 AoWI1pz3tthGkdX.GIy4kMZz3ekPrxSA2zkcpeV02LVMru2j30aIKAPjGijEVcREY0gpF8lZTvvC
 7ODILV9cvFF7dlzkbOjFW.F2YeYkRgpEVanh2E7ObZATzFPejnL11wmA6eueU9FOmDSzQxwSz.kt
 itUpGid8hnPn4P9m2rnVutenAlF_D4YW3wJCrll7myCuE19F7JfDf.fwVzsi5XtrnJwBdKzlenej
 M2xriOnJB0sJ7zX6lEhmrlAKv77VeZNx.hPShuPNDkl1e8ROfTByh11b9bbf3DooqDpz_ZtQKOjr
 YZy3rWaiUD4_V98YvrIGgoTWlw36rzcJpq489TlUMFb2DM_mi
Date: Tue, 24 Apr 2018 18:23:51 +0000 (UTC)
From: Gianfranco Costamagna <locutusofborg@debian.org>
Reply-To: Gianfranco Costamagna <locutusofborg@debian.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Antonio Rosario Intilisano <antonio.intilisano@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "vger@kernel.org" <vger@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>
Message-ID: <122064928.616643.1524594231224@mail.yahoo.com>
In-Reply-To: <1524589355.21176.507.camel@linux.intel.com>
References: <20180420212641.30338-1-antonio.intilisano@gmail.com> <a62dded5-0fa9-1a6e-dd71-3e03cc311f1f@debian.org> <CAHp75VdSOGnN5=yxkk1m3=7rBKR1PU3NfO6QNp7wYR7Qx6mWkA@mail.gmail.com> <1690760144.5633578.1524494921916@mail.yahoo.com> <CAHp75VeDhyKmcJqA5paqJEPsw-gpzq7iJee+zu=ZMqUpDv0_6A@mail.gmail.com> <1524589355.21176.507.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: add another KEY_POWER keycode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.11819 YahooMailNeo Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

>Or I missed the point and it's working? Tell me what to do with it.
>For now I pushed to my review and testing queue, thanks!


Antonio did patch and build a custom kernel locally (testing was successful), and submitted
the patch to me.

I pinged some Ubuntu folks to get it applied, and also testing with the .deb provided
by kernel team was good, so I presume this is a safe patch that can be applied right now
as-is.
(this is a trivial patch, Antonio told me in another channel that he can also create and post
failures logs before and after, as well as do some video with the key pressed).

I don't think this is needed, but if you want it for historical purposes, just ask and we will
do our best to provide them!

Gianfranco
