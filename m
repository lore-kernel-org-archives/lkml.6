Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeD3Beu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 21:34:50 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:54036 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbeD3Bes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 21:34:48 -0400
Date: Sun, 29 Apr 2018 21:34:47 -0400 (EDT)
Message-Id: <20180429.213447.688736262643740298.davem@davemloft.net>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, kevin@guarana.org, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: make msg padding explicit
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524844881-178524-1-git-send-email-mst@redhat.com>
References: <1524844881-178524-1-git-send-email-mst@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 27 Apr 2018 19:02:05 +0300

> There's a 32 bit hole just after type. It's best to
> give it a name, this way compiler is forced to initialize
> it with rest of the structure.
> 
> Reported-by: Kevin Easton <kevin@guarana.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Who applied this, me? :-)
