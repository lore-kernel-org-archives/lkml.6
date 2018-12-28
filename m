Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D0A218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeL1A2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:28:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52080 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeL1A2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:28:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C3AF01017CFDD;
        Thu, 27 Dec 2018 16:28:40 -0800 (PST)
Date:   Thu, 27 Dec 2018 16:28:40 -0800 (PST)
Message-Id: <20181227.162840.1148572221333237817.davem@davemloft.net>
To:     peng.hao2@zte.com.cn
Cc:     qiang.zhao@nxp.com, linux-kernel@vger.kernel.org,
        wen.yang99@zte.com.cn, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] net/wan/fsl_ucc_hdlc: Avoid double free in
 ucc_hdlc_probe()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1545812910-77777-1-git-send-email-peng.hao2@zte.com.cn>
References: <1545812910-77777-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Dec 2018 16:28:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 26 Dec 2018 16:28:30 +0800

> From: Wen Yang <wen.yang99@zte.com.cn>
> 
> This patch fixes potential double frees if register_hdlc_device() fails.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>

Applied.
