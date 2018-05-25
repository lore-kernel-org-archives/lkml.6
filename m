Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968334AbeEYU1k (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:27:40 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37356 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968175AbeEYU1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:27:38 -0400
Date: Fri, 25 May 2018 16:27:36 -0400 (EDT)
Message-Id: <20180525.162736.1851445273924939030.davem@davemloft.net>
To: songliubraving@fb.com
Cc: laoar.shao@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: use data length instead of skb->len in
 tcp_probe
From: David Miller <davem@davemloft.net>
In-Reply-To: <630ED9AE-A932-4B6A-8236-D133CE3E0726@fb.com>
References: <1527166097-10908-1-git-send-email-laoar.shao@gmail.com>
        <630ED9AE-A932-4B6A-8236-D133CE3E0726@fb.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>
Date: Thu, 24 May 2018 17:44:46 +0000

> We should also rename __entry->length to __entry->data_len, so that whoever
> using this field will notice the change. 

Agreed.
