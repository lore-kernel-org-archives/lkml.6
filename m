Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F3FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4382152C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4382152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeI0J0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:26:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37456 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeI0J0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:26:24 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CF4A81456FE1C;
        Wed, 26 Sep 2018 20:10:21 -0700 (PDT)
Date:   Wed, 26 Sep 2018 20:10:21 -0700 (PDT)
Message-Id: <20180926.201021.56420855924083408.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     inaky.perez-gonzalez@intel.com, linux-wimax@intel.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] wimax/i2400m: fix spelling mistake "not
 unitialized" -> "uninitialized"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180924173951.3931-1-colin.king@canonical.com>
References: <20180924173951.3931-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 20:10:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 24 Sep 2018 18:39:51 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in ms_to_errno array of error messages
> and remove confusing "not" from the error text since the error code
> refers to an uninitialized error code.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: remove "not" from text too. Thanks to Sergei Shtylyov for spotting that.

Applied.
