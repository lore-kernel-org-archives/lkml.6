Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B2620872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wCofHHvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B2620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeKKTBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 14:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbeKKTBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 14:01:21 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9C720871;
        Sun, 11 Nov 2018 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541927600;
        bh=E0h7Kmlh6mq3fquq4dh+1Uk4NToUQCcQJ7vHFTp5q/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCofHHvC4Bpf2wG2y4DohPMoWagmwILYT+bHlIkWwdnzrubSWGkX2xr+UUeJ3p2SI
         1gtzT7/WCBfTGzGjoJpAqHq60q5xWjce/hdVtfr8umQ316ZTsFVDLQ2LR98zDh1Awd
         0HItjsbfPwNkjaa+S/jy01PwMHNVl7IkX4ZHlpxo=
Date:   Sun, 11 Nov 2018 14:43:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Kauer <florian.kauer@koalo.de>
Subject: Re: [PATCH 06/17] dma: bcm2835: Switch to SPDX identifier
Message-ID: <20181111091312.GY12092@vkoul-mobl>
References: <1541864080-7320-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541864080-7320-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-18, 16:34, Stefan Wahren wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.

Applied after fixing subsystem tags, thanks

-- 
~Vinod
