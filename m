Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1F7C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5170020880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5170020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeIMXQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:16:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51830 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeIMXQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:16:20 -0400
Received: from localhost (unknown [24.18.143.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D2D8E13FE788C;
        Thu, 13 Sep 2018 11:05:44 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:05:44 -0700 (PDT)
Message-Id: <20180913.110544.1829014151772495898.davem@davemloft.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next V2 00/11] vhost_net TX batching
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180913135833-mutt-send-email-mst@kernel.org>
References: <20180912031709.14112-1-jasowang@redhat.com>
        <20180913.092819.2099750169529223026.davem@davemloft.net>
        <20180913135833-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 11:05:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 13 Sep 2018 14:02:13 -0400

> On Thu, Sep 13, 2018 at 09:28:19AM -0700, David Miller wrote:
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Wed, 12 Sep 2018 11:16:58 +0800
>> 
>> > This series tries to batch submitting packets to underlayer socket
>> > through msg_control during sendmsg(). This is done by:
>>  ...
>> 
>> Series applied, thanks Jason.
> 
> Going over it now I don't see a lot to complain about, but I'd
> appreciate a bit more time for review in the future. 3 days ok?

I try to handle every patchwork entry within 48 hours, more
specifically 2 business days.

Given the rate at which patches flow through networking, I think
this is both reasonable and necessary.

One always have the option to send a quick reply to the list saying
"Please wait for my review, I'll get to it in the next day or two."
which I will certainly honor.

Thank you.
