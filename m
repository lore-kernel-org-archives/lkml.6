Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeDXOmx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:42:53 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35160 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeDXOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:42:52 -0400
Date: Tue, 24 Apr 2018 10:42:50 -0400 (EDT)
Message-Id: <20180424.104250.1411072442966778574.davem@davemloft.net>
To: luc.vanoostenryck@gmail.com
Cc: linux-kernel@vger.kernel.org, igor.russkikh@aquantia.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: aquantia: fix aq_ndev_start_xmit()'s return type
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180424131623.3505-1-luc.vanoostenryck@gmail.com>
References: <20180424131623.3505-1-luc.vanoostenryck@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luc please don't submit such a huge number of patches all at one time.

Also, please fix the indentation of the functions whose arguments
span multiple lines as has been pointed out to you in patch feedback.

Finally, make this a true patch series.  It is so much easier for
maintainers to work with a set of changes all doing the same thing if
you make them a proper patch series with an appropriate "[PATCH 0/N] ..."
header posting.

Thank you.
