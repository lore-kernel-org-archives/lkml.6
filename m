Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857D020C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfBZRHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:07:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBZRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:07:49 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7B0D314F1DCCA;
        Tue, 26 Feb 2019 09:07:48 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:07:47 -0800 (PST)
Message-Id: <20190226.090747.197822470039781854.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     jiri@mellanox.com, idosch@mellanox.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum: remove set but not used
 variable 'autoneg_status'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190225020328.42510-1-yuehaibing@huawei.com>
References: <20190225020328.42510-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Feb 2019 09:07:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 25 Feb 2019 02:03:28 +0000

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function 'mlxsw_sp_port_get_link_ksettings':
> drivers/net/ethernet/mellanox/mlxsw/spectrum.c:3062:5: warning:
>  variable 'autoneg_status' set but not used [-Wunused-but-set-variable]
> 
> It's not used since commit 475b33cb66c9 ("mlxsw: spectrum: Remove unsupported
> eth_proto_lp_advertise field in PTYS")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
