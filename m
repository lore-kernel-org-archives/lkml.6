Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeENWgF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:36:05 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36192 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbeENWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:36:03 -0400
X-Google-Smtp-Source: AB8JxZpsJvW+6rkx8C0n8fzZzeDq1Ggrh+z+lhToVmHO4j7W0FXkOe8jpXorP5+s7ovyWE8KJQ9EBkaxMK6qxy5ezJQ=
MIME-Version: 1.0
In-Reply-To: <20180514.145642.989041199343505570.davem@davemloft.net>
References: <20180512170925.23690-1-christophe.jaillet@wanadoo.fr> <20180514.145642.989041199343505570.davem@davemloft.net>
From: Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date: Mon, 14 May 2018 15:35:41 -0700
Message-ID: <CALzJLG9_Yqv96DoRLPZ1641FY5s99vR4Z3_Q=NJHiVMadpnO-A@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Use 'kvfree()' for memory allocated by 'kvzalloc()'
To: David Miller <davem@davemloft.net>
Cc: christophe.jaillet@wanadoo.fr, Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:56 AM, David Miller <davem@davemloft.net> wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Date: Sat, 12 May 2018 19:09:25 +0200
>
>> 'out' is allocated with 'kvzalloc()'. 'kvfree()' must be used to free it.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> Saeed, I assume I will see this in one of your forthcoming pull
> requests.
>
> Thanks.

In case this is for net-next,  I will apply v3 to mlx5-next once
Christophe adds the "Fixes" tags according to Eric's request.
if it is for net (RC) then you can go ahead and apply v3 to net branch.

Thanks,
Saeed.
