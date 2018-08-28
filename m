Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39ADC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7C020659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7C020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeH1JlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:41:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbeH1JlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:41:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16B1940241CB;
        Tue, 28 Aug 2018 05:51:16 +0000 (UTC)
Received: from localhost (dhcp-192-209.str.redhat.com [10.33.192.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 863E4A9EA3;
        Tue, 28 Aug 2018 05:51:13 +0000 (UTC)
Date:   Tue, 28 Aug 2018 07:51:12 +0200
From:   Jens Freimann <jfreiman@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
Message-ID: <20180828055112.2p4fvjikcclkde4p@jenstp.localdomain>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180827170005-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180827170005-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 28 Aug 2018 05:51:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 28 Aug 2018 05:51:16 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jfreiman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 05:00:40PM +0300, Michael S. Tsirkin wrote:
>Are there still plans to test the performance with vost pmd?
>vhost doesn't seem to show a performance gain ...

Yes, I'm having trouble getting it to work with virtio PMD (it works
with Tiweis guest driver though), but I'm getting closer. Should only
be 1-2 more days. 

regards,
Jens 
