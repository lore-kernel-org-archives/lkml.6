Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeENRYS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:24:18 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36737 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeENRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:24:16 -0400
X-Google-Smtp-Source: AB8JxZrJeFq+mkiMfHA2MX5Foye4xmwIzMOqFdkDPlthtuc2Ebk+UtF8+WXDzg/eKGx7G5iUXEGUSvjWHRT+DQCwGcw=
MIME-Version: 1.0
In-Reply-To: <20180503175401.GD29205@thunk.org>
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
 <20180503175401.GD29205@thunk.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 20:24:15 +0300
Message-ID: <CAHp75Ve8DF=CUV7XLdKScdjyOJUs9fWTn3o4_7TKFmOxONqDdw@mail.gmail.com>
Subject: Re: serial: custom baud rate
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Muni Sekhar <munisekharrms@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 8:54 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Thu, May 03, 2018 at 06:09:13PM +0530, Muni Sekhar wrote:

> See the setserial man page:t
>
>         https://linux.die.net/man/8/setserial
>
> Not all serial devices support the spd_cust and divisor, however.  In
> general

Oh, please, do not advertise this old hack.

We have BOTHER that what people should use in new code.

-- 
With Best Regards,
Andy Shevchenko
