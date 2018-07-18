Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87354ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE5A2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE5A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeGSB1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:27:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeGSB1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:27:01 -0400
Received: from localhost (unknown [128.208.196.2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0FE87147A4CC1;
        Wed, 18 Jul 2018 17:46:34 -0700 (PDT)
Date:   Thu, 19 Jul 2018 02:59:15 +0900 (KST)
Message-Id: <20180719.025915.233546971559781209.davem@davemloft.net>
To:     ubraun@linux.ibm.com
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net/smc: fixes 2018-07-18
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718132251.7222-1-ubraun@linux.ibm.com>
References: <20180718132251.7222-1-ubraun@linux.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 17:46:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Wed, 18 Jul 2018 15:22:48 +0200

> here are small fixes for SMC: The first patch speeds up unidirectional
> traffic, the second patch increases security, and the third patch
> fixes a problem for fallback cases.

Series applied, thank you.
