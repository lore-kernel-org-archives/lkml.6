Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43348C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBCD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBCD20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbeIJV4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:56:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35562 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeIJV4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:56:38 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 55815108F9166;
        Mon, 10 Sep 2018 10:01:37 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:01:34 -0700 (PDT)
Message-Id: <20180910.100134.1463498001968586861.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     ganeshgr@chelsio.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] cxgb4: remove redundant assignment to
 vlan_cmd.dropnovlan_fm
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180910121722.15524-1-colin.king@canonical.com>
References: <20180910121722.15524-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 10 Sep 2018 10:01:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 10 Sep 2018 13:17:22 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent commit updated vlan_cmd.dropnovlan_fm but failed to remove
> the older assignment.  Fix this by removing the former redundant
> assignment.
> 
> Detected by CoverityScan, CID#1473290 ("Unused value")
> 
> Fixes: a89cdd8e7c74 ("cxgb4: impose mandatory VLAN usage when non-zero TAG ID")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.
