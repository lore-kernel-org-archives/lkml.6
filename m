Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08E6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67765214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67765214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbeGMDjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:39:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387615AbeGMDjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:39:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A3AD72632;
        Fri, 13 Jul 2018 03:27:00 +0000 (UTC)
Received: from redhat.com (ovpn-112-30.rdu2.redhat.com [10.10.112.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0902E2026D68;
        Fri, 13 Jul 2018 03:26:57 +0000 (UTC)
Date:   Fri, 13 Jul 2018 06:26:57 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     tiwei.bie@intel.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 0/5] virtio: support packed ring
Message-ID: <20180713062627-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180712.144458.2076041018423659380.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712.144458.2076041018423659380.davem@davemloft.net>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 03:27:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 03:27:00 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 02:44:58PM -0700, David Miller wrote:
> From: Tiwei Bie <tiwei.bie@intel.com>
> Date: Wed, 11 Jul 2018 10:27:06 +0800
> 
> > Hello everyone,
> > 
> > This patch set implements packed ring support in virtio driver.
> > 
> > Some functional tests have been done with Jason's
> > packed ring implementation in vhost:
> > 
> > https://lkml.org/lkml/2018/7/3/33
> > 
> > Both of ping and netperf worked as expected.
> 
> Michael and Jason, where are we with this series?

I'm at netdev, won't be able to review before Monday.

-- 
MST
