Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A1FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A485720645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfAODSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:18:48 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35440 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfAODSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:18:47 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0F3IYHL006439;
        Tue, 15 Jan 2019 04:18:34 +0100
Date:   Tue, 15 Jan 2019 04:18:34 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/8] ASoC: change snprintf to scnprintf for possible
 overflow
Message-ID: <20190115031834.GC6416@1wt.eu>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-4-w@1wt.eu>
 <20190115012536.GA12096@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115012536.GA12096@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Mon, Jan 14, 2019 at 05:25:37PM -0800, Nicolin Chen wrote:
> I think you probably need to run get_maintainer.pl for the patch

That's what I did :-)

> and should send to Mark Brown and CC alsa-devel.

OK, thanks. At first when adding the CC lines I didn't know if the
report was public or not, which is why I didn't add any list.

> And for subject,
> we usually use prefix "ASoC: imx-audmux:". Otherwise,
> 
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks, I'll adjust this one accordingly and will resend it.

Willy
