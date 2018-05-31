Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756029AbeEaSrl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:47:41 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:41400 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755877AbeEaSrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:47:39 -0400
X-Google-Smtp-Source: ADUXVKKEkJNA+SjkTRcssIXW0CTgXG5f992mQgGvJPgy28+gFkn2ybZ6WchKMX2JjKXYupaA/wX6Tm8Gg1YM914zXNE=
MIME-Version: 1.0
In-Reply-To: <af7838f0-9cae-d526-b52f-15996cd8031c@cogentembedded.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-2-git-send-email-xieyisheng1@huawei.com> <af7838f0-9cae-d526-b52f-15996cd8031c@cogentembedded.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 21:47:38 +0300
Message-ID: <CAHp75VfAwj2P51ydOoe6aysB=Q9j8DaMNSbYaMqwbYHn7UFfdQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] usb: phy: use match_string() helper
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 7:55 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

>>  - donot rename err to ret  - per Andy
>
>    Hm...

>> -     int err, i;

>> +     err = match_string(usbphy_modes, ARRAY_SIZE(usbphy_modes), phy_type);
>> +     if (err < 0)
>
>    This is one of the few cases when 'err' is not the best name for such a
> variable. I'd prefer to see something like 'match' or even 'rc' or 'ret'... :-)

Then leaving i would make it?
I'm okay with either which just not renames err, b/c it's used with
something else in this function.

-- 
With Best Regards,
Andy Shevchenko
