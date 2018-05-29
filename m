Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934964AbeE2OA0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:00:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55428 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934802AbeE2OAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:00:21 -0400
Date: Tue, 29 May 2018 10:00:19 -0400 (EDT)
Message-Id: <20180529.100019.342627848221840486.davem@davemloft.net>
To: brnkv.i1@gmail.com
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: zatm: fix memcmp casting
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180525174952.21965-1-brnkv.i1@gmail.com>
References: <20180525174952.21965-1-brnkv.i1@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Bornyakov <brnkv.i1@gmail.com>
Date: Fri, 25 May 2018 20:49:52 +0300

> memcmp() returns int, but eprom_try_esi() cast it to unsigned char. One
> can lose significant bits and get 0 from non-0 value returned by the
> memcmp().
> 
> Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>

Applied, thanks.
