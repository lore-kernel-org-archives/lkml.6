Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeERP0b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:26:31 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46178 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeERP0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:26:30 -0400
Date: Fri, 18 May 2018 11:26:28 -0400 (EDT)
Message-Id: <20180518.112628.2034204867850935787.davem@davemloft.net>
To: jes.sorensen@gmail.com
Cc: colin.king@canonical.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hippi: fix spelling mistake: "Framming" -> "Framing"
From: David Miller <davem@davemloft.net>
In-Reply-To: <bdb779e6-1705-3607-7ad8-3b57dfcba31a@gmail.com>
References: <20180518100922.28790-1-colin.king@canonical.com>
        <bdb779e6-1705-3607-7ad8-3b57dfcba31a@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jes Sorensen <jes.sorensen@gmail.com>
Date: Fri, 18 May 2018 10:33:50 -0400

> I do wonder if it's time to retire this driver and the HIPPI code. I
> haven't had access to hardware for over a decade so I have no idea
> if it even works anymore.

That's a good question.

If you really think nobody is using this stuff, yes we can remove it.

Then if someone brings it to our attention that there are users, we
can very easily bring it back.

But as the HIPPI maintiner it is really up to you.
