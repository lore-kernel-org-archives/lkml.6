Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeCWM51 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:57:27 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41913 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbeCWM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:57:21 -0400
X-Google-Smtp-Source: AG47ELvSy3lkLjBpHDr7GEvH4pYhxx3D9wfkSPBoc7zKxWMQwy4miRYg8NX9+aHCrJy7Qqwg/U+LSQ==
Subject: Re: [PATCH] netlink: make sure nladdr has correct size in
 netlink_connect()
To: Alexander Potapenko <glider@google.com>, dvyukov@google.com,
        edumazet@google.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180323124902.41625-1-glider@google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <eb767d8b-602f-bfb5-618e-784e61358606@gmail.com>
Date: Fri, 23 Mar 2018 05:57:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323124902.41625-1-glider@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/23/2018 05:49 AM, Alexander Potapenko wrote:
> KMSAN reports use of uninitialized memory in the case when |alen| is
> smaller than sizeof(struct sockaddr_nl), and therefore |nladdr| isn't
> fully copied from the userspace.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Alexander.
