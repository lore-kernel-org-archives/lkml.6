Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755345AbeDQQZV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:25:21 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:45103 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754683AbeDQQZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:25:17 -0400
X-Google-Smtp-Source: AIpwx489QpEGjS+vQvnJOpDpN2T499GSzjzKX1kjKt4fcw1JATBH5BKsw7TNWyeXddREJXTPT/luhbCiCsPezrFNY6Y=
MIME-Version: 1.0
In-Reply-To: <8faec18239a6104b250d9668bb1d3abc@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name> <CAGXu5j+-PNYxSc3v+QtQLK0S3wdtFthFSxNM_69kFDnPQX0Gaw@mail.gmail.com>
 <CAGXu5j+_UH0h9qeYCKKjhC7jw-mi_=fg4ASHi2=pCF9xGTpA4Q@mail.gmail.com>
 <2864697.7uzmEJovl2@natalenko.name> <CAGXu5jLSmJv9AstzsgSscrv-wA7FwfrxAKRxj-FVBmihQvnj1g@mail.gmail.com>
 <CAGXu5j+dh1zm32iBjRVh0s+3gLJYgjwt+z1aBJmrK2Cr8XPWnA@mail.gmail.com>
 <CAGXu5jLhnWnUiscP9B=kTEFNyRw9jgFn7Zr5FxhZrO20553+1Q@mail.gmail.com>
 <CAGXu5jKuZwicyyXH2gB3vp-OjtS+MkG+hqxV1cq1jaG9vAAO=g@mail.gmail.com>
 <CAGXu5jLQuzpjFcfjpT=MvgOxBizFNMjnfmY+E7eCHkDAV5swHg@mail.gmail.com> <8faec18239a6104b250d9668bb1d3abc@natalenko.name>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 17 Apr 2018 09:25:15 -0700
X-Google-Sender-Auth: qO9gabUg4TB_EjZ4mZV2rKhow-0
Message-ID: <CAGXu5jLcrymg8bDXB=MRKwwAqN2Y=qMeO4PNDQ_t4DekyOk+JQ@mail.gmail.com>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 2:19 AM, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
> By any chance, have you tried to simplify the reproducer environment, or it
> still needs my complex layout to trigger things even with KASAN?

I haven't tried minimizing the reproducer yet, no. Now that I have a
specific place to watch in the kernel for the corruption, though, that
might help. If I get stuck again today, I'll try it.

-Kees

-- 
Kees Cook
Pixel Security
