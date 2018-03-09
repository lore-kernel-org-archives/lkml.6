Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932249AbeCIRDZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:03:25 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:53766 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeCIRDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:03:23 -0500
Date: Fri, 09 Mar 2018 12:03:20 -0500 (EST)
Message-Id: <20180309.120320.1315307032420131973.davem@davemloft.net>
To: jasowang@redhat.com
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, glider@google.com, dvyukov@google.com
Subject: Re: [PATCH net 0/3] Several fixes for vhost_net ptr_ring usage
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
References: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri,  9 Mar 2018 14:50:31 +0800

> This small series try to fix several bugs of ptr_ring usage in
> vhost_net. Please review.

Series applied, thanks Jason.
