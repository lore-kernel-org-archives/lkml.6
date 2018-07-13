Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA94ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61F72147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61F72147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbeGMBEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:04:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387827AbeGMBE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9040818F6F0;
        Fri, 13 Jul 2018 00:52:23 +0000 (UTC)
Received: from [10.72.12.76] (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3F2B2026D6B;
        Fri, 13 Jul 2018 00:52:19 +0000 (UTC)
Subject: Re: [PATCH net-next v2 0/5] virtio: support packed ring
To:     David Miller <davem@davemloft.net>, tiwei.bie@intel.com
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180712.144458.2076041018423659380.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7d3b86d0-c6c7-1468-a3a6-e2091c0e63c0@redhat.com>
Date:   Fri, 13 Jul 2018 08:52:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712.144458.2076041018423659380.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 13 Jul 2018 00:52:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 13 Jul 2018 00:52:23 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月13日 05:44, David Miller wrote:
> From: Tiwei Bie <tiwei.bie@intel.com>
> Date: Wed, 11 Jul 2018 10:27:06 +0800
>
>> Hello everyone,
>>
>> This patch set implements packed ring support in virtio driver.
>>
>> Some functional tests have been done with Jason's
>> packed ring implementation in vhost:
>>
>> https://lkml.org/lkml/2018/7/3/33
>>
>> Both of ping and netperf worked as expected.
> Michael and Jason, where are we with this series?

For the series:

Acked-by: Jason Wang <jasowang@redhat.com>

