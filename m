Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeERPoj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:44:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46510 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeERPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:44:36 -0400
Date: Fri, 18 May 2018 11:44:33 -0400 (EDT)
Message-Id: <20180518.114433.390752642781753429.davem@davemloft.net>
To: eric.dumazet@gmail.com
Cc: threeearcat@gmail.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu,
        willemb@google.com
Subject: Re: WARNING in ip_recv_error
From: David Miller <davem@davemloft.net>
In-Reply-To: <293d029c-b14c-a625-3703-97a5754e99f1@gmail.com>
References: <20180518120826.GA19515@dragonet.kaist.ac.kr>
        <293d029c-b14c-a625-3703-97a5754e99f1@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Fri, 18 May 2018 08:30:43 -0700

> We probably need to revert Willem patch (7ce875e5ecb8562fd44040f69bda96c999e38bbc)

Is it really valid to reach ip_recv_err with an ipv6 socket?
