Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15912C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9977214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549850490;
	bh=Pg48BriuwqThZRLtYzbmluzmcwhs4dJwh9F3eVrzHHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=juV5SlLjMjgIIT/NTd19uqN6oknuuLOUaolznV9EQtY0hUvLCWKcb63iP/tl88sZL
	 TQdsCSisJIBTd2rpl/hrGVejXnuyEZmXvHBbUaT5ywlHIyciNB/SHtcd8bmvZ5t8Fz
	 ERTU0XduMh0Mu3AmoDJkR72KxzJpSRuW4ZUny6QA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBKCB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 21:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfBKCB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 21:01:29 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF132084D;
        Mon, 11 Feb 2019 02:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549850488;
        bh=Pg48BriuwqThZRLtYzbmluzmcwhs4dJwh9F3eVrzHHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0huGKgC9EHlOFfvW1qMZn8MhLJsgI0lOZj03dbSf+6Ib8LyiPvav0eTmefBBMuQ8b
         xSHF/K/ZBXKyar4Dm/je2LEuNa45VIID2MobPeViC2JP0ERccFeL7xMpkb72LVPWfm
         evjHm2HiMMB8gFRWXvcY7SgVISHKQpekZggdb0AU=
Date:   Mon, 11 Feb 2019 10:01:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] firmware: imx: Add support to start/stop a CPU
Message-ID: <20190211020115.GD22487@dragon>
References: <20190130133005.5732-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130133005.5732-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:30:22PM +0000, Daniel Baluta wrote:
> This is done via RPC call to SCU.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
