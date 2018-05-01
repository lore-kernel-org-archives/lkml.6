Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756164AbeEAP21 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:28:27 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46116 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbeEAP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:28:26 -0400
Date: Tue, 01 May 2018 11:28:22 -0400 (EDT)
Message-Id: <20180501.112822.1871426720257639849.davem@davemloft.net>
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

Michael, will you be sending this directly to Linus or would you like
me to apply it to net or net-next?

Thanks.
