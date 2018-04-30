Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeD3PUI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:20:08 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:32990 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeD3PUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:20:05 -0400
Date: Mon, 30 Apr 2018 11:17:21 -0400 (EDT)
Message-Id: <20180430.111721.844644740463403738.davem@davemloft.net>
To: zbr@ioremap.net
Cc: stefan.strogin@gmail.com, jderehag@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com,
        matt.helsley@gmail.com
Subject: Re: [PATCH] connector: add parent pid and tgid to coredump and
 exit events
From: David Miller <davem@davemloft.net>
In-Reply-To: <4667631525100490@web38o.yandex.ru>
References: <DB6P190MB0389513E240BD8ECEE575DB4DDBB0@DB6P190MB0389.EURP190.PROD.OUTLOOK.COM>
        <32f14672-5715-3e21-ba85-b27dc8d2c6b0@gmail.com>
        <4667631525100490@web38o.yandex.ru>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <zbr@ioremap.net>
Date: Mon, 30 Apr 2018 18:01:30 +0300

> Stefan, hi
> 
> Sorry for delay.
> 
> 26.04.2018, 15:04, "Stefan Strogin" <stefan.strogin@gmail.com>:
>> Hi David, Evgeniy,
>>
>> Sorry to bother you, but could you please comment about the UAPI change and the patch?
> 
> With 4-bytes pid_t everything looks fine, and I do not know arch where pid is larger currently, so it looks safe.
> 
> David, please pull it into your tree, or should it go via different path?
> 
> Acked-by: Evgeniy Polyakov <zbr@ioremap.net>

After this much time it needs to be resubmitted.
