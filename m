Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933284AbeBLJgq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:36:46 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35535 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933192AbeBLJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:36:31 -0500
X-Google-Smtp-Source: AH8x224qjcVXuw7yKk7rjJGju+7t0f3/jzlppLigAYyrW3jt89xgHwJzGE1Kt23K4YI9p7EgxhCMKXh5j+JLqcNPzSg=
MIME-Version: 1.0
In-Reply-To: <20180212052111.12010-5-jerry.hoemann@hpe.com>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com> <20180212052111.12010-5-jerry.hoemann@hpe.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 12 Feb 2018 10:35:50 +0100
Message-ID: <CAOFm3uH0PUXVOxJmqDf-ZCm8vTp_6ERwYSC6Bt2-8r-C2yH9gQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] watchdog/hpwdt: white space changes
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        rwright@hpe.com, maurice.a.saldivar@hpe.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerry,

On Mon, Feb 12, 2018 at 6:21 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
> Minor white space changes and some name clean up.
>
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  drivers/watchdog/hpwdt.c | 49 +++++++++++++++++++++++-------------------------
>  1 file changed, 23 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 6f7949ef9a23..ee9a92220ece 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -1,11 +1,9 @@
>  /*
>   *     HPE WatchDog Driver
> - *     based on
>   *
> - *     SoftDog 0.05:   A Software Watchdog Device
> - *
> - *     (c) Copyright 2015 Hewlett Packard Enterprise Development LP
> + *     (c) Copyright 2018 Hewlett Packard Enterprise Development LP
>   *     Thomas Mingarelli <thomas.mingarelli@hpe.com>
> + *     Jerry Hoemann <jerry.hoemann@hpe.com>
>   *
>   *     This program is free software; you can redistribute it and/or
>   *     modify it under the terms of the GNU General Public License

Since you are updating the copyright, why not updating the licensing
to use the new concise SPDX ids instead? [1]
And you get a big good karma bonus if you can also do the same for all
HPE-copyrighted files, tree-wide ;) and/or spread the word inside your
team.

Thank you for your kind consideration!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst

Cordially
Philippe Ombredanne
