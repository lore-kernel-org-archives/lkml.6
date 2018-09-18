Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94246ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B692088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B692088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeIRIVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:21:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54608 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeIRIVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:21:13 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2883C146330DA;
        Mon, 17 Sep 2018 19:50:49 -0700 (PDT)
Date:   Mon, 17 Sep 2018 19:50:48 -0700 (PDT)
Message-Id: <20180917.195048.1786107377144717518.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     derek.chickles@caviumnetworks.com,
        satananda.burla@caviumnetworks.com,
        felix.manlunas@caviumnetworks.com,
        raghu.vatsavayi@caviumnetworks.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] liquidio: remove duplicated include from
 lio_vf_rep.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180918024343.19832-1-yuehaibing@huawei.com>
References: <20180918024343.19832-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 19:50:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 18 Sep 2018 10:43:43 +0800

> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
