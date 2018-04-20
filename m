Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbeDTBKF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 21:10:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37520 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbeDTBKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 21:10:03 -0400
Date: Thu, 19 Apr 2018 21:10:00 -0400 (EDT)
Message-Id: <20180419.211000.2287069039902804558.davem@davemloft.net>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, mpatocka@redhat.com,
        eric.dumazet@gmail.com, thuth@redhat.com, cohuck@redhat.com
Subject: Re: [PATCH v2 net 0/3] virtio: ctrl buffer fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180420034743-mutt-send-email-mst@kernel.org>
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
        <20180419.163422.299364261955942291.davem@davemloft.net>
        <20180420034743-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 20 Apr 2018 03:49:19 +0300

> On Thu, Apr 19, 2018 at 04:34:22PM -0400, David Miller wrote:
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>> Date: Thu, 19 Apr 2018 08:30:47 +0300
>> 
>> > Here are a couple of fixes related to the virtio control buffer.
>> > Lightly tested on x86 only.
>> 
>> Thanks for taking care of the control buffer DMA'ability issue.
>> 
>> Want any of these queued up for -stable?
> 
> Good point. Patches 1-2 for sure. 

Ok, queued up 1 and 2.
