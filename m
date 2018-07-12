Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B33BECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1342087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1342087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeGLV41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:56:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43200 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeGLV41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:56:27 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6B613102C739D;
        Thu, 12 Jul 2018 14:44:59 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:44:58 -0700 (PDT)
Message-Id: <20180712.144458.2076041018423659380.davem@davemloft.net>
To:     tiwei.bie@intel.com
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 0/5] virtio: support packed ring
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180711022711.7090-1-tiwei.bie@intel.com>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Jul 2018 14:44:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 11 Jul 2018 10:27:06 +0800

> Hello everyone,
> 
> This patch set implements packed ring support in virtio driver.
> 
> Some functional tests have been done with Jason's
> packed ring implementation in vhost:
> 
> https://lkml.org/lkml/2018/7/3/33
> 
> Both of ping and netperf worked as expected.

Michael and Jason, where are we with this series?
