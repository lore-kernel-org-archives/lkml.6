Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771B6C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28474216FC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28474216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeHHDQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:16:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54268 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeHHDQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:16:40 -0400
Received: from localhost (c-73-37-107-99.hsd1.or.comcast.net [73.37.107.99])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 21DEC13F960B2;
        Tue,  7 Aug 2018 17:59:36 -0700 (PDT)
Date:   Tue, 07 Aug 2018 17:59:31 -0700 (PDT)
Message-Id: <20180807.175931.200772329178253653.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-net-drivers@solarflare.com, ecree@solarflare.com,
        bkenward@solarflare.com, jes@trained-monkey.org,
        linux-acenic@sunsite.dk, michael.chan@broadcom.com,
        nicolas.ferre@microchip.com, derek.chickles@caviumnetworks.com,
        satananda.burla@caviumnetworks.com,
        felix.manlunas@caviumnetworks.com,
        raghu.vatsavayi@caviumnetworks.com, ganeshgr@chelsio.com,
        santosh@chelsio.com, sgoutham@cavium.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        tariqt@mellanox.com, linux-rdma@vger.kernel.org, jdmason@kudzu.us,
        saeedm@mellanox.com, leon@kernel.org, Ariel.Elior@cavium.com,
        everest-linux-l2@cavium.com, manish.chopra@cavium.com,
        rahul.verma@cavium.com, Dept-GELinuxNICDev@cavium.com,
        harish.patil@cavium.com, bh74.an@samsung.com, ks.giri@samsung.com,
        vipul.pandya@samsung.com, chessman@tux.org
Subject: Re: [PATCH 00/33] net: ethernet: Mark expected switch fall-throughs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1533675546.git.gustavo@embeddedor.com>
References: <cover.1533675546.git.gustavo@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Aug 2018 17:59:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 7 Aug 2018 18:09:00 -0500

> In preparation to enabling -Wimplicit-fallthrough, this patchset aims
> to add some annotations in order to mark switch cases where we are
> expecting to fall through.

Ok, I went through all of these and they look good.

If any are not correct we can revert/fix.

Series applied, thanks.
