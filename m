Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756075AbeEaS4C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:56:02 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46172 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755955AbeEaSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:55:58 -0400
X-Google-Smtp-Source: ADUXVKKDXGAx2QrJeJvd9fE1KvKdPD4bCbaJzd5NgUmC+XVr3VG1HAOfCxq86TY37Lzd6PikfOoKk4zvJsnmRNFnFRA=
MIME-Version: 1.0
In-Reply-To: <20180531072732.GA90146@google.com>
References: <20180530163135.50081-1-liumartin@google.com> <Pine.LNX.4.44L0.1805301319430.1502-100000@iolanthe.rowland.org>
 <20180531063118.GA7554@kroah.com> <20180531072732.GA90146@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 31 May 2018 21:55:56 +0300
Message-ID: <CAHp75Ve8RmAcr-nEQaLZug2+x_d8ExJJK2DgEJc+L_60u0vLzw@mail.gmail.com>
Subject: Re: [PATCH v4] driver core: hold dev's parent lock when needed
To: Martin Liu <liumartin@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, jenhaochen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:27 AM, Martin Liu <liumartin@google.com> wrote:
> On Thu, May 31, 2018 at 08:31:18AM +0200, Greg KH wrote:
>> On Wed, May 30, 2018 at 01:21:02PM -0400, Alan Stern wrote:
>> > On Thu, 31 May 2018, Martin Liu wrote:

>> > This looks okay to me.
>> >
>> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> >
>> > Greg, any more comments?
>>
>> Looks sane to me.  Martin, thanks for all of the changes.

> Great thank Alan, Greg and Andy for helpful hints and feedback.
> Many Thanks!

You are welcome!

Btw, FWIW,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
