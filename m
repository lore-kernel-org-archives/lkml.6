Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeEDJEy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:04:54 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:46850 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeEDJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:04:52 -0400
X-Google-Smtp-Source: AB8JxZqX+64sAdWZfzTiDtUF/XuPvmW51KPn2t4T7zA5fmQZkyCLK6HKGtOxLCy1dBbCA2LF6BM49FaoNAwa3M3DnO8=
MIME-Version: 1.0
In-Reply-To: <20180503175401.GD29205@thunk.org>
References: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
 <20180503175401.GD29205@thunk.org>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Fri, 4 May 2018 14:34:51 +0530
Message-ID: <CAHhAz+iiv+h+RAPXACQuJRiEQmE1jxeS7+qaz-8fu30Fm9tNaw@mail.gmail.com>
Subject: Re: serial: custom baud rate
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Muni Sekhar <munisekharrms@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 11:24 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Thu, May 03, 2018 at 06:09:13PM +0530, Muni Sekhar wrote:
>> Hi All,
>>
>> From include/asm-generic/termbits.h , I see baudrate can be one of the
>> standard values: 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800,
>> 2400, 4800, 9600, 19200, 38400, 57600, 115200, 230400, 460800, 500000,
>> 576000, 921600, 1000000, 1152000, 1500000, 2000000, 2500000, 3000000,
>> 3500000, 4000000.
>>
>> If I need to set a custom baud rates(e.g. 14400, 128000, 256000), does
>> Linux serial framework has any supporting method?
>
> See the setserial man page:t
>
>         https://linux.die.net/man/8/setserial
>
> Not all serial devices support the spd_cust and divisor, however.  In
> general, only devices where the kernel directly programs the
> 8250/16450/16550 UART directly will support this feature.
>
So custom baud's can be set via TIOCSSERIAL IOCtl in kernel mode?
>                                                         - Ted



-- 
Thanks,
Sekhar
