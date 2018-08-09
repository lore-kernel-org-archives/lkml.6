Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B32BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA9D21DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA9D21DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeHIXgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:36:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36936 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeHIXf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:35:59 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 92CF61426BF1C;
        Thu,  9 Aug 2018 14:09:22 -0700 (PDT)
Date:   Thu, 09 Aug 2018 14:09:22 -0700 (PDT)
Message-Id: <20180809.140922.263463642075324643.davem@davemloft.net>
To:     poros@redhat.com
Cc:     netdev@vger.kernel.org, ivecera@redhat.com,
        sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] be2net: Use Kconfig flag to support for
 enabling/disabling adapters
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180808113505.550-1-poros@redhat.com>
References: <20180808113505.550-1-poros@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 09 Aug 2018 14:09:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Oros <poros@redhat.com>
Date: Wed,  8 Aug 2018 13:35:01 +0200

> Add flags to enable/disable supported chips in be2net.
> 
> With disable support are removed coresponding PCI IDs and
> also codepaths with [BE2|BE3|BEx|lancer|skyhawk]_chip checks.
> 
> Disable chip will reduce module size by:
> BE2 ~2kb
> BE3 ~3kb
> Lancer ~10kb
> Skyhawk ~9kb
> 
> When enable skyhawk only it will reduce module size by ~20kb
> 
> New help style in Kconfig
> 
> Reviewed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Petr Oros <poros@redhat.com>

Applied.
