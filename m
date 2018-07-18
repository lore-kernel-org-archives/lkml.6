Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DA7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66702075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66702075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeGRXCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:02:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44810 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeGRXCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:02:48 -0400
Received: from localhost (50-234-71-226-static.hfc.comcastbusiness.net [50.234.71.226])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5753B147A4139;
        Wed, 18 Jul 2018 15:22:49 -0700 (PDT)
Date:   Thu, 19 Jul 2018 07:22:49 +0900 (KST)
Message-Id: <20180719.072249.841425419842816951.davem@davemloft.net>
To:     krzk@kernel.org
Cc:     pantelis.antoniou@gmail.com, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        vbordug@ru.mvista.com, vitb@kernel.crashing.org
Subject: Re: [PATCH] MAINTAINERS: Drop inactive Vitaly Bordug's email
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180717164154.6577-1-krzk@kernel.org>
References: <20180717164154.6577-1-krzk@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 15:22:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 17 Jul 2018 18:41:54 +0200

> The Vitaly Bordug's email bounces ("ru.mvista.com: Name or service not
> known") and there was no activity (ack, review, sign) since 2009.
> 
> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied.
