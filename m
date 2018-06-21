Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC1C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A984B2251A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A984B2251A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934001AbeFUW4k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:56:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39282 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933393AbeFUW4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:56:39 -0400
Received: from localhost (unknown [119.205.93.152])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 207D01099937D;
        Thu, 21 Jun 2018 15:56:37 -0700 (PDT)
Date:   Fri, 22 Jun 2018 07:56:34 +0900 (KST)
Message-Id: <20180622.075634.1186166032159929401.davem@davemloft.net>
To:     ross.lagerwall@citrix.com
Cc:     netdev@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] xen-netfront: Fix issues with commit f599c64fdf7d
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180621130021.27029-1-ross.lagerwall@citrix.com>
References: <20180621130021.27029-1-ross.lagerwall@citrix.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Jun 2018 15:56:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Thu, 21 Jun 2018 14:00:19 +0100

> Fix a couple of issues with commit f599c64fdf7d ("xen-netfront: Fix race
> between device setup and open").

Series applied and queued up for -stable.
