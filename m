Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B7420644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B7420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeH3FJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:09:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39268 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeH3FJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:09:41 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ECB77108F4391;
        Wed, 29 Aug 2018 18:10:07 -0700 (PDT)
Date:   Wed, 29 Aug 2018 18:10:07 -0700 (PDT)
Message-Id: <20180829.181007.967677259832053608.davem@davemloft.net>
To:     ivan@de.ibm.com
Cc:     netdev@vger.kernel.org, chunkeey@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net/ibm/emac: deletion of unneeded macros
 definitions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180827164336.8815-2-ivan@de.ibm.com>
References: <20180827164336.8815-2-ivan@de.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Aug 2018 18:10:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Mikhaylov <ivan@de.ibm.com>
Date: Mon, 27 Aug 2018 19:43:36 +0300

> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>

Please do not delete these, they could be useful for other
developers and people reading this driver.
