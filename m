Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeENThq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:37:46 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:35899 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeENTho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:37:44 -0400
X-ME-Helo: [192.168.43.42]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 14 May 2018 21:37:41 +0200
X-ME-IP: 77.136.42.172
Subject: Re: [PATCH] net/mlx5: Use 'kvfree()' for memory allocated by
 'kvzalloc()'
To: David Miller <davem@davemloft.net>
Cc: saeedm@mellanox.com, matanb@mellanox.com, leon@kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.network,gmane.linux.drivers.rdma,gmane.linux.kernel.janitors
References: <20180512170925.23690-1-christophe.jaillet@wanadoo.fr>
 <20180514.145642.989041199343505570.davem@davemloft.net>
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Message-ID: <72339a77-1740-e081-06bc-8295687f80b8@wanadoo.fr>
Date: Mon, 14 May 2018 21:37:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514.145642.989041199343505570.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/05/2018 à 20:56, David Miller a écrit :
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
> 

I've send a v2 with additional 'kvfree()' fixes.

CJ
