Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8C8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8571E2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXOrIV/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8571E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeLCTcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCTcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:32:31 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C98B6214C1;
        Mon,  3 Dec 2018 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543865544;
        bh=TJnHsdIRP++NUf3MT6qQN3f8YkL7yQXLZpezHeM5/Vc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=oXOrIV/E/MByRpFafWS4f46HyGWGMef+grKe/zQlxFLhT4VG0irl5DSCX2o6d3PaG
         0AWNECH4Pq78zzQrRFq5D1SNPYfh7/GTDfoJCB/oSeEQNEBJNgR7Ljiq2qvSvT/Yo9
         WR1wTOsU3JNjFz62/Vd1GEsVyEp4FM9HW/CZ48Zs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-9-git-send-email-aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <1542200198-3017-9-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386554424.88331.5358384242097908533@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 8/9] clk: imx: implement new clk_hw based APIs
Date:   Mon, 03 Dec 2018 11:32:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting A.s. Dong (2018-11-14 05:02:04)
> Clock providers are recommended to use the new struct clk_hw based API,
> so implement IMX clk_hw based provider helpers functions to the new
> approach.
> =

> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> =

> ---

Applied to clk-next

