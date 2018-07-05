Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB9AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA9D21AA5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA9D21AA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeGEKwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:52:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753464AbeGEKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:52:32 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1912F13F12AE5;
        Thu,  5 Jul 2018 03:52:30 -0700 (PDT)
Date:   Thu, 05 Jul 2018 19:52:29 +0900 (KST)
Message-Id: <20180705.195229.1643127099809491582.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: sun: remove redundant variables adv and
 lpa
From:   David Miller <davem@davemloft.net>
In-Reply-To: <dfecea10-87b5-2110-6efb-02f46e7b4e2c@canonical.com>
References: <20180705093732.21650-1-colin.king@canonical.com>
        <20180705.193315.2106014813802269928.davem@davemloft.net>
        <dfecea10-87b5-2110-6efb-02f46e7b4e2c@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Jul 2018 03:52:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 5 Jul 2018 11:50:01 +0100

> Just to clarify, just the MII_ADVERTISE and MII_LPA, or both these AND
> also MII_ESTATUS too?

I think you can safely remove all three.
