Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB0EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37528222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391063AbfBOUO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:14:56 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:34298 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390667AbfBOUOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:14:55 -0500
Received: from belgarion ([90.76.35.80])
        by mwinf5d29 with ME
        id d8Em1z00C1jkVcS038EnfN; Fri, 15 Feb 2019 21:14:51 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 15 Feb 2019 21:14:51 +0100
X-ME-IP: 90.76.35.80
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <linux@armlinux.org.uk>, <daniel@zonque.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] ARM: pxa: ssp: Fix "WARNING: invalid free of devm_ allocated data"
References: <20190129080324.18708-1-yuehaibing@huawei.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 15 Feb 2019 21:14:46 +0100
In-Reply-To: <20190129080324.18708-1-yuehaibing@huawei.com> (YueHaibing's
        message of "Tue, 29 Jan 2019 16:03:24 +0800")
Message-ID: <877ee0u7ux.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:

> Since commit 1c459de1e645 ("ARM: pxa: ssp: use devm_ functions")
> kfree, iounmap, clk_put etc no need do any more in remove path.
>
> Fixes: 1c459de1e645 ("ARM: pxa: ssp: use devm_ functions")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Sorry for the late reply, I had forgotten to answer.

Queued to pxa/for-next with a small spelling fix in the commit message, thanks.

Cheers.

--
Robert
