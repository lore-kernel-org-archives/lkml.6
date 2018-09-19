Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D222C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0DB214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0DB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeISIeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeISIeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:34:03 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAE1F30001D4;
        Wed, 19 Sep 2018 02:58:19 +0000 (UTC)
Received: from localhost (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59CE030912F4;
        Wed, 19 Sep 2018 02:58:18 +0000 (UTC)
Date:   Tue, 18 Sep 2018 19:58:17 -0700 (PDT)
Message-Id: <20180918.195817.280114858430968899.davem@redhat.com>
To:     yuehaibing@huawei.com
Cc:     LinoSanfilippo@gmx.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: slicoss: remove duplicated
 include from slic.h
From:   David Miller <davem@redhat.com>
In-Reply-To: <20180918030914.23592-1-yuehaibing@huawei.com>
References: <20180918030914.23592-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 19 Sep 2018 02:58:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 18 Sep 2018 11:09:14 +0800

> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
