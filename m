Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5908AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07297208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07297208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936168AbeFODQI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 23:16:08 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52656 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936083AbeFODQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 23:16:07 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DC47614167DD7;
        Thu, 14 Jun 2018 20:16:06 -0700 (PDT)
Date:   Thu, 14 Jun 2018 20:16:06 -0700 (PDT)
Message-Id: <20180614.201606.2231415081744487239.davem@davemloft.net>
To:     haiyangz@microsoft.com, haiyangz@linuxonhyperv.com
Cc:     netdev@vger.kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hv_netvsc: Fix the variable sizes in ipsecv2 and
 rsc offload
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180615012909.13440-1-haiyangz@linuxonhyperv.com>
References: <20180615012909.13440-1-haiyangz@linuxonhyperv.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Jun 2018 20:16:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Date: Thu, 14 Jun 2018 18:29:09 -0700

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> These fields in struct ndis_ipsecv2_offload and struct ndis_rsc_offload
> are one byte according to the specs. This patch defines them with the
> right size. These structs are not in use right now, but will be used soon.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Applied, thank you.
