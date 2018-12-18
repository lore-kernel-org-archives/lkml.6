Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85526C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFB0218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeLRXui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:50:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44570 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeLRXug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:50:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EC7A21487877D;
        Tue, 18 Dec 2018 15:50:35 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:50:35 -0800 (PST)
Message-Id: <20181218.155035.232147444579151712.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     Shahed.Shaikh@cavium.com, manish.chopra@cavium.com,
        Dept-GELinuxNICDev@cavium.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] qlcnic: remove set but not used variables
 'op, cmd_op'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181217092716.30708-1-yuehaibing@huawei.com>
References: <20181217092716.30708-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 15:50:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 17 Dec 2018 17:27:16 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c:1070:5: warning:
>  variable 'op' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c:1342:5: warning:
>  variable 'cmd_op' set but not used [-Wunused-but-set-variable]
> 
> 'op' never used since introduction in commit 7cb03b2347d5 ("qlcnic:
> Support VF-PF communication channel commands.")
> 'cmd_op' not used since commit 6226204bcf20 ("qlcnic: Fix operation
> type and command type.")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
