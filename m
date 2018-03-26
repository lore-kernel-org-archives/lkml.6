Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeCZQ7g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:59:36 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53296 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCZQ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:59:34 -0400
Date: Mon, 26 Mar 2018 12:59:33 -0400 (EDT)
Message-Id: <20180326.125933.76259382836188471.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost_net: add missing lock nesting notation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1522051823-5166-1-git-send-email-jasowang@redhat.com>
References: <1522051823-5166-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Mar 2018 16:10:23 +0800

> We try to hold TX virtqueue mutex in vhost_net_rx_peek_head_len()
> after RX virtqueue mutex is held in handle_rx(). This requires an
> appropriate lock nesting notation to calm down deadlock detector.
> 
> Fixes: 0308813724606 ("vhost_net: basic polling support")
> Reported-by: syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks Jason.
