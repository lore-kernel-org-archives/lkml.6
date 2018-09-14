Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482FCC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39542086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39542086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeINImP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:42:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbeINImP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:42:15 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 675CE5D665;
        Fri, 14 Sep 2018 03:29:48 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5022330912F4;
        Fri, 14 Sep 2018 03:29:43 +0000 (UTC)
Subject: Re: [PATCH net-next V2] virtio_net: ethtool tx napi configuration
To:     David Miller <davem@davemloft.net>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        willemb@google.com
References: <20180913053545.18585-1-jasowang@redhat.com>
 <20180913.155253.713713547323242272.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9c1b1266-234c-78b6-1964-95689699b310@redhat.com>
Date:   Fri, 14 Sep 2018 11:29:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913.155253.713713547323242272.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 14 Sep 2018 03:29:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月14日 06:52, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Thu, 13 Sep 2018 13:35:45 +0800
>
>> Toggle tx napi through a bit in tx-frames.
> This is not what the code implements as the interface any more.
>
> Please fix the commit message to match the code.
>
> Thanks.

Will fix this.

Thanks
