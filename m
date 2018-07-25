Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF14C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFB620671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFB620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeGYVzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:55:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55708 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbeGYVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:55:41 -0400
Received: from localhost (unknown [172.58.43.97])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 72BE0124391AB;
        Wed, 25 Jul 2018 13:42:19 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:42:17 -0700 (PDT)
Message-Id: <20180725.134217.306393798893792554.davem@davemloft.net>
To:     krzk@kernel.org
Cc:     fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiggers3@gmail.com
Subject: Re: [PATCH v3] net: ethernet: freescale: Use generic CRC32
 implementation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180723161914.6101-1-krzk@kernel.org>
References: <20180723161914.6101-1-krzk@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Jul 2018 13:42:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 23 Jul 2018 18:19:14 +0200

> Use generic kernel CRC32 implementation because it:
> 1. Should be faster (uses lookup tables),
> 2. Removes duplicated CRC generation code,
> 3. Uses well-proven algorithm instead of coding it one more time.
> 
> Suggested-by: Eric Biggers <ebiggers3@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied.
