Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375C7C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F360C213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549854403;
	bh=gg0u0TYlHQQUf7L3h4uIvaMqXbs6dHwS+JCO6nvGyWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lHZUf7UNOMJ/QcQhulEbkJOtwvW8eroTtRn2ANWTMt0YWQo684YT/v4QyK5l3369N
	 8PlJC57fUqR2sLewY10Cbdm1qYbgvIh1bf5RcQMNeew6KOwMzlYbPPyK0Vt1ddHKRL
	 23oDM1JA7lTzm6sD/extCb79DqwE7voUgDLItHvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBKDGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfBKDGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 22:06:40 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7418D2084D;
        Mon, 11 Feb 2019 03:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549854400;
        bh=gg0u0TYlHQQUf7L3h4uIvaMqXbs6dHwS+JCO6nvGyWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fg7neW5rUiyHViHvoge2kZApad/jCy2qJyKCi/RFOMWe/QZ/2b754A8KA2ov4vYZ7
         w26PCTu+fWp9XY7WnhlxFoOt3zBNNGTv3RbPWvWWj5yVX2bBzmaLKgDx7AZh0O4Dvk
         JUY0kHHjHo2WHkGY80B+HZDdhOYUu5hKvIoyhWYQ=
Date:   Mon, 11 Feb 2019 11:06:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/4] ARM: dts: imx6qdl-sabresd: add regulator control for
 isl29023 sensor
Message-ID: <20190211030627.GL22487@dragon>
References: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 03:18:30PM +0000, Anson Huang wrote:
> The isl29023 light sensor driver has supported regulator control,
> assign the power supply for isl29023 to enable the control.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
