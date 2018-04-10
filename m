Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeDJGxx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:53:53 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:40166 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbeDJGxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:53:50 -0400
X-Google-Smtp-Source: AIpwx4+5wgDwAZCEeY9K/J9ugPTYJ9w+2Vyl8wygY0EPq83DbtrXz1a8CfSP6SynpWXGKXqFPyhCRH8g9W79PSmDwJ0=
MIME-Version: 1.0
In-Reply-To: <3d7b5a707e216e19eb3defe0586bfbc8@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com>
 <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com>
 <2679696.GDoj5zcZOu@natalenko.name> <CAGXu5jLG9ia+zBNcPt+q+BpJayoUuYwXitOgeHmh=7sPp-s87A@mail.gmail.com>
 <51a7e805058ef7f35b226cbbf0ccc4ff@natalenko.name> <CAGXu5jKRrdYjuyLSvc4k4mqttkM7zw-96poQ1GYqRRgPqZFOYQ@mail.gmail.com>
 <3d7b5a707e216e19eb3defe0586bfbc8@natalenko.name>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 9 Apr 2018 23:53:49 -0700
X-Google-Sender-Auth: 2p0hA3PZUD1d9l6mmwSlNZzCxjw
Message-ID: <CAGXu5j+9BJcR63bsqQpqaKrvcgOpWyDzgpD-zRrf1qq7v=Z2CA@mail.gmail.com>
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

On Mon, Apr 9, 2018 at 11:35 PM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> Did your system hang on smartctl hammering too? Have you got some stack
> traces to compare with mine ones?

Unfortunately I only had a single hang with no dumps. I haven't been
able to reproduce it since. :(

-Kees

-- 
Kees Cook
Pixel Security
