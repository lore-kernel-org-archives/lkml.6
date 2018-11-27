Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A5BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9305820989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9305820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeK0Pt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:49:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52362 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeK0Pt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:49:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EA88E14C66CD8;
        Mon, 26 Nov 2018 20:52:49 -0800 (PST)
Date:   Mon, 26 Nov 2018 20:52:47 -0800 (PST)
Message-Id: <20181126.205247.1196368459821644290.davem@davemloft.net>
To:     jelsasser@appneta.com
Cc:     jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
From:   David Miller <davem@davemloft.net>
In-Reply-To: <F6168EB4-8C74-456F-B571-6492162CFA0F@appneta.com>
References: <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
        <937675447ad1ec2665d0b6f70390d498a01255d0.camel@intel.com>
        <F6168EB4-8C74-456F-B571-6492162CFA0F@appneta.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 26 Nov 2018 20:52:50 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Elsasser <jelsasser@appneta.com>
Date: Mon, 26 Nov 2018 16:54:11 -0800

> Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
> 
>> No need to re-spin the patch, just reply with the additional "Fixes"
>> tag and if patchwork does not pick it up, I will add it to the patch I
>> have in my tree for validation and review.
> 
> Thanks, let’s try that.
> 
> Fixes: e23f33367882 ("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+”)

Unfortunately, patchwork isn't smart enough to pick up Fixes: tags
still.
