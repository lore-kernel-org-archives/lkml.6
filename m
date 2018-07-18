Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C695ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACC42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACC42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbeGRGUe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:20:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57874 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeGRGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:20:34 -0400
Received: from localhost (unknown [172.58.43.84])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D7D8D13EA8061;
        Tue, 17 Jul 2018 22:44:26 -0700 (PDT)
Date:   Wed, 18 Jul 2018 14:44:25 +0900 (KST)
Message-Id: <20180718.144425.289131710667497329.davem@davemloft.net>
To:     Haakon.Bugge@oracle.com
Cc:     santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/rds: void function cannot return -1
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180716130009.1591379-1-Haakon.Bugge@oracle.com>
References: <20180716130009.1591379-1-Haakon.Bugge@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Jul 2018 22:44:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Håkon Bugge <Haakon.Bugge@oracle.com>
Date: Mon, 16 Jul 2018 15:00:09 +0200

> Commit b6fb0df12db6 ("RDS/IB: Make ib_recv_refill return void") did
> not change the comment accordingly.
> 
> Fixes: b6fb0df12db6 ("RDS/IB: Make ib_recv_refill return void")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

Applied.
