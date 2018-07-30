Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF64CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8015720857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8015720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbeG3Vhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:37:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36582 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731904AbeG3Vhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:37:55 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 328E213F6E186;
        Mon, 30 Jul 2018 13:01:20 -0700 (PDT)
Date:   Mon, 30 Jul 2018 13:01:19 -0700 (PDT)
Message-Id: <20180730.130119.1162984202708995473.davem@davemloft.net>
To:     thomas.petazzoni@bootlin.com
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, hannah@marvell.com
Subject: Re: [PATCH 2/2] sparc: use asm-generic version of msi.h
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180724115305.11289-2-thomas.petazzoni@bootlin.com>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
        <20180724115305.11289-2-thomas.petazzoni@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Jul 2018 13:01:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 24 Jul 2018 13:53:05 +0200

> This is necessary to be able to include <linux/msi.h> when
> CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled. Without this, a build with
> CONFIG_GENERIC_MSI_IRQ_DOMAIN fails with:
 ...
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Applied.
