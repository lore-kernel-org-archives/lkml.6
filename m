Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeCNIkj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:40:39 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:39337 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752648AbeCNIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:40:37 -0400
X-Google-Smtp-Source: AG47ELsIL+ONHlO61L29yXAL6992I50GnM3Skylcl/rZxOyxK9t1np0Y6A1JdlUWV8UPKEWRP6I7tdgyFIqE36/DPOw=
MIME-Version: 1.0
In-Reply-To: <20180314080727.GA17319@embeddedgus>
References: <20180314080727.GA17319@embeddedgus>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 09:40:35 +0100
X-Google-Sender-Auth: IgXysOa3ZxXevwl32_AP3Ec9QBA
Message-ID: <CAK8P3a2YAYvGKdP8ynFqvXprifXWQS6u7J9NZVuRbvqBZT=19w@mail.gmail.com>
Subject: Re: [PATCH] pktgen: Fix memory leak in pktgen_if_write
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Wang Jian <jianjian.wang1@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 9:07 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> _buf_ is an array and the one that must be freed is _tp_ instead.
>
> Fixes: a870a02cc963 ("pktgen: use dynamic allocation for debug print buffer")
> Reported-by: Wang Jian <jianjian.wang1@gmail.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for fixing up my mistake so quickly, and thanks to Wang for the report

I was about to send the same patch, but you got there first.
