Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeC2Siv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:38:51 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47956 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbeC2Sio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:38:44 -0400
Date: Thu, 29 Mar 2018 14:38:42 -0400 (EDT)
Message-Id: <20180329.143842.1841942043775921475.davem@davemloft.net>
To: arnd@arndb.de
Cc: vyasevich@gmail.com, nhorman@tuxdriver.com, viro@ZenIV.linux.org.uk,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] sctp: fix unused lable warning
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180328141512.3083992-1-arnd@arndb.de>
References: <20180328141512.3083992-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Mar 2018 16:14:56 +0200

> The proc file cleanup left a label possibly unused:
> 
> net/sctp/protocol.c: In function 'sctp_defaults_init':
> net/sctp/protocol.c:1304:1: error: label 'err_init_proc' defined but not used [-Werror=unused-label]
> 
> This adds an #ifdef around it to match the respective 'goto'.
> 
> Fixes: d47d08c8ca05 ("sctp: use proc_remove_subtree()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
