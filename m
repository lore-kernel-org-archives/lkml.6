Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755422AbeDWOG3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:06:29 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:40083 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753999AbeDWOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:06:23 -0400
X-Google-Smtp-Source: AB8JxZq4+UNaiwUzWFZtWaPsiYePagdjYhlMKThO6AUH3jbrwMd4CiU/MVwm1xKI6hIvBFmPq8wPrvG9RH+/umUVFMs=
MIME-Version: 1.0
In-Reply-To: <a62dded5-0fa9-1a6e-dd71-3e03cc311f1f@debian.org>
References: <20180420212641.30338-1-antonio.intilisano@gmail.com> <a62dded5-0fa9-1a6e-dd71-3e03cc311f1f@debian.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Apr 2018 17:06:21 +0300
Message-ID: <CAHp75VdSOGnN5=yxkk1m3=7rBKR1PU3NfO6QNp7wYR7Qx6mWkA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: add another KEY_POWER keycode
To: Gianfranco Costamagna <locutusofborg@debian.org>
Cc: Antonio Rosario Intilisano <antonio.intilisano@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>, vger@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2018 at 9:40 PM, Gianfranco Costamagna
<locutusofborg@debian.org> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hello,
>
> On 20/04/2018 23:26, Antonio Rosario Intilisano wrote:
>>     Now that we have informed the firmware that the Power Button driver is
>>     active, laptops such as the Acer Swift 3 will generate
>>     a WMI key event with code 0x87 when the power button key is
>>     pressed.
>>
>>     Add this keycode to the table so that it is converted to an appropriate
>>     input event.
>>
>
> I don't know why Acer folks didn't merge this into the kernel yet, but this patch
> seems to fix a real issue, so I'm thinking about uploading it in Ubuntu right now.

Can you give your corresponding tag as well?

-- 
With Best Regards,
Andy Shevchenko
