Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeEMQWT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 12:22:19 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:40586 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbeEMQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 12:21:29 -0400
X-Google-Smtp-Source: AB8JxZr+75l/OAKpw+BaePoDWhnLtkVr+WlhAl+j8b0gOQM/QnskWnBGOX892AE1ho/vV7QU0lQeag==
Subject: Re: [PATCH v2] {net, IB}/mlx5: Use 'kvfree()' for memory allocated by
 'kvzalloc()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        saeedm@mellanox.com, matanb@mellanox.com, leon@kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180513070041.24246-1-christophe.jaillet@wanadoo.fr>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <91c6f7a0-e099-5b93-1b3a-f16f650adc2e@gmail.com>
Date: Sun, 13 May 2018 09:21:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180513070041.24246-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/13/2018 12:00 AM, Christophe JAILLET wrote:
> When 'kvzalloc()' is used to allocate memory, 'kvfree()' must be used to
> free it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 -> v2: More places to update have been added to the patch


Please add relevant Fixes: tag(s)
