Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbeDRRrY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:47:24 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46060 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbeDRRrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:47:23 -0400
Date: Wed, 18 Apr 2018 13:47:21 -0400 (EDT)
Message-Id: <20180418.134721.283381724211219025.davem@davemloft.net>
To: eric.dumazet@gmail.com
Cc: mpatocka@redhat.com, edumazet@google.com, joby.poriyath@citrix.com,
        bhutchings@solarflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] net: don't use kvzalloc for DMA memory
From: David Miller <davem@davemloft.net>
In-Reply-To: <5f4e1286-b79f-0b9f-9a30-47d7654f3889@gmail.com>
References: <3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
        <alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
        <5f4e1286-b79f-0b9f-9a30-47d7654f3889@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 18 Apr 2018 09:51:25 -0700

> I suggest that virtio_net clearly identifies which part needs a specific allocation
> and does its itself, instead of abusing the netdev_priv storage.
> 
> Ie use a pointer to a block of memory, allocated by virtio_net, for virtio_net.

+1
