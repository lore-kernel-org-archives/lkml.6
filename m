Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeDMDCr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 23:02:47 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:46427 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeDMDCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 23:02:45 -0400
X-Google-Smtp-Source: AIpwx4+vHS83UTxu0qY6MfNa2/uDvPj+XxrwRKhPKnkaJallZd/AK3gXbIpXPEAXKePe9ACvqvrRsJ9aDnvbWdLvxnI=
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+dh1zm32iBjRVh0s+3gLJYgjwt+z1aBJmrK2Cr8XPWnA@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5j+-PNYxSc3v+QtQLK0S3wdtFthFSxNM_69kFDnPQX0Gaw@mail.gmail.com>
 <CAGXu5j+_UH0h9qeYCKKjhC7jw-mi_=fg4ASHi2=pCF9xGTpA4Q@mail.gmail.com>
 <2864697.7uzmEJovl2@natalenko.name> <CAGXu5jLSmJv9AstzsgSscrv-wA7FwfrxAKRxj-FVBmihQvnj1g@mail.gmail.com>
 <CAGXu5j+dh1zm32iBjRVh0s+3gLJYgjwt+z1aBJmrK2Cr8XPWnA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 12 Apr 2018 20:02:43 -0700
X-Google-Sender-Auth: FkdeRinnirnGHnAc31BG6wfMclM
Message-ID: <CAGXu5jLhnWnUiscP9B=kTEFNyRw9jgFn7Zr5FxhZrO20553+1Q@mail.gmail.com>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jens Axboe <axboe@kernel.dk>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
        paolo.valente@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 3:47 PM, Kees Cook <keescook@chromium.org> wrote:
> After fixing up some build issues in the middle of the 4.16 cycle, I
> get an unhelpful bisect result of commit 0a4b6e2f80aa ("Merge branch
> 'for-4.16/block'"). Instead of letting the test run longer, I'm going
> to switch to doing several shorter test boots per kernel and see if
> that helps. One more bisect coming...

Okay, so I can confirm the bisect points at the _merge_ itself, not a
specific patch. I'm not sure how to proceed here. It looks like some
kind of interaction between separate trees? Jens, do you have
suggestions on how to track this down?

-Kees

-- 
Kees Cook
Pixel Security
