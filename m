Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC92C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E9C20844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E9C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeGZGlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:41:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33162 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbeGZGlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:41:18 -0400
Received: from localhost (unknown [172.58.43.249])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2B68712DE5809;
        Wed, 25 Jul 2018 22:26:12 -0700 (PDT)
Date:   Wed, 25 Jul 2018 22:26:10 -0700 (PDT)
Message-Id: <20180725.222610.2089956256497101095.davem@davemloft.net>
To:     ubraun@linux.ibm.com
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net/smc: patches 2018-07-25
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180725143533.7082-1-ubraun@linux.ibm.com>
References: <20180725143533.7082-1-ubraun@linux.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Jul 2018 22:26:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed, 25 Jul 2018 16:35:29 +0200

> here are 4 more patches for SMC: The first one is just a small
> code cleanup in preparation for patch 2. Patch 2 switches to the
> use of the vlan-gid for VLAN traffic. Patch 3 improves diagnosis
> when creating SMC connections. Patch 4 improves synchronization
> between local and remote link groups.

Series applied.
