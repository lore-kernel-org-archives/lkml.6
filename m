Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeDLWBo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:01:44 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:41293 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753536AbeDLWBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:01:42 -0400
X-Google-Smtp-Source: AIpwx48qG82LW5IkF/kgXU/A/j2qHi1ylMQuRS6UtiLzHuNQFuSfklKR4nIAoqp0V5FE+fzEYzJLA9SVPuKj5ZgHgFs=
MIME-Version: 1.0
In-Reply-To: <2864697.7uzmEJovl2@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5j+-PNYxSc3v+QtQLK0S3wdtFthFSxNM_69kFDnPQX0Gaw@mail.gmail.com>
 <CAGXu5j+_UH0h9qeYCKKjhC7jw-mi_=fg4ASHi2=pCF9xGTpA4Q@mail.gmail.com> <2864697.7uzmEJovl2@natalenko.name>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 12 Apr 2018 15:01:40 -0700
X-Google-Sender-Auth: W9_exQBhK9GXlFfgwMskXXF5CEQ
Message-ID: <CAGXu5jLSmJv9AstzsgSscrv-wA7FwfrxAKRxj-FVBmihQvnj1g@mail.gmail.com>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
        paolo.valente@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3CM1lYh019618

On Thu, Apr 12, 2018 at 12:04 PM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> Hi.
>
> On čtvrtek 12. dubna 2018 20:44:37 CEST Kees Cook wrote:
>> My first bisect attempt gave me commit 5448aca41cd5 ("null_blk: wire
>> up timeouts"), which seems insane given that null_blk isn't even built
>> in the .config. I managed to get the testing automated now for a "git
>> bisect run ...", so I'm restarting again to hopefully get a better
>> answer. Normally the Oops happens in the first minute of running. I've
>> set the timeout to 10 minutes for a "good" run...
>
> Apparently, you do this on Linus' tree, right? If so, I won't compile it here
> then.

Actually, I didn't test Linus's tree, but I can do that after the most
recent bisect finishes... I'm just trying to find where it went wrong
in 4.16.

> Thanks for taking care of this.

Thanks for building the reproducer! :)

-Kees

-- 
Kees Cook
Pixel Security
