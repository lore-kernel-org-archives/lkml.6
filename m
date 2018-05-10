Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966039AbeEJAv6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:51:58 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:43074 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965926AbeEJAv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:51:56 -0400
X-Google-Smtp-Source: AB8JxZoGdZiHEx3wweXWyHIKEXakj7eUWg1BHw+Kr0Zf5v6xG8dK2GP3jiBdux7J1/Dm7UIx+XrJesRpf9lCPRE9TL8=
MIME-Version: 1.0
In-Reply-To: <CAJrWOzBYNBzGuStrqjzLirUxhC1K02PE9kPdY+GuJF6ynRBZgA@mail.gmail.com>
References: <1453803006-12812-1-git-send-email-roman.penyaev@profitbricks.com> <CAJrWOzBYNBzGuStrqjzLirUxhC1K02PE9kPdY+GuJF6ynRBZgA@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 10 May 2018 08:51:54 +0800
Message-ID: <CACVXFVO51Un=nGZCfyUN_SKG11O7+LR4paSkS8QMFsqBL9UewQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: fix race between opening blkext device and
 freeing it
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: Keith Busch <keith.busch@intel.com>, stable <stable@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2016 at 12:29 AM, Roman Penyaev
<roman.penyaev@profitbricks.com> wrote:
> Hello, Jens.
>
> Could you please take a look at this patch.
> This issue happens quite often on our servers, when udevd
> tries to get detailed info about md raid starting mdadm,
> but this raid device is already in closing state and is
> about to free internal structures, afterwards an oops
> happens and mdadm gets killed.

Looks the issue is still there, so could we consider Roman's approach
for this issue?

Thanks,
Ming Lei
