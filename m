Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F36C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5892420882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5892420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbeGYWPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:15:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55980 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbeGYWPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:15:31 -0400
Received: from localhost (unknown [172.58.43.97])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D33B1122FE543;
        Wed, 25 Jul 2018 14:02:01 -0700 (PDT)
Date:   Wed, 25 Jul 2018 14:01:54 -0700 (PDT)
Message-Id: <20180725.140154.1401102419515041292.davem@davemloft.net>
To:     dann.frazier@canonical.com
Cc:     aviad.krawczyk@huawei.com, zhaochen6@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hinic: Link the logical network device to the pci
 device in sysfs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180723225540.GA6905@xps13.dannf>
References: <20180723225540.GA6905@xps13.dannf>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Jul 2018 14:02:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dann frazier <dann.frazier@canonical.com>
Date: Mon, 23 Jul 2018 16:55:40 -0600

> Otherwise interfaces get exposed under /sys/devices/virtual, which
> doesn't give udev the context it needs for PCI-based predictable
> interface names.
> 
> Signed-off-by: dann frazier <dann.frazier@canonical.com>

Applied, thank you.
