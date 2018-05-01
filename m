Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756347AbeEASF4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:05:56 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48108 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756174AbeEASFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:05:55 -0400
Date: Tue, 01 May 2018 14:05:51 -0400 (EDT)
Message-Id: <20180501.140551.1944561534446599966.davem@davemloft.net>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, kevin@guarana.org, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] vhost: make msg padding explicit
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180501201841-mutt-send-email-mst@kernel.org>
References: <1524844881-178524-1-git-send-email-mst@redhat.com>
        <20180501.112822.1871426720257639849.davem@davemloft.net>
        <20180501201841-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 1 May 2018 20:19:19 +0300

> On Tue, May 01, 2018 at 11:28:22AM -0400, David Miller wrote:
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>> Date: Fri, 27 Apr 2018 19:02:05 +0300
>> 
>> > There's a 32 bit hole just after type. It's best to
>> > give it a name, this way compiler is forced to initialize
>> > it with rest of the structure.
>> > 
>> > Reported-by: Kevin Easton <kevin@guarana.org>
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> 
>> Michael, will you be sending this directly to Linus or would you like
>> me to apply it to net or net-next?
>> 
>> Thanks.
> 
> I'd prefer you to apply it for net and cc stable if possible.

Ok, applied, and added to my -stable submission queue.
