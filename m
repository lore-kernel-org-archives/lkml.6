Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D48C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1632082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547645294;
	bh=cwDBqrDNBY0bDhGdTrqynZCkuUCzT+gy8WU9uQEHUiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bCG/fFwffJ/55khtPojBa8LGW95SZueCGWXXTmo4/3a/1QQ4tmp7jjd8uhNFC6gDy
	 q0YEMCFCWOe1boPiKTWo5rpK9YJ2r7GUmkO2FEMk9aAZo2PmtG++HtVK0Ovvsiu9u8
	 HYijWRUxNlsOvVLc/DrogASrd/ijoR3a7dwKOyzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393159AbfAPN2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732867AbfAPN2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:28:11 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB0120675;
        Wed, 16 Jan 2019 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547645290;
        bh=cwDBqrDNBY0bDhGdTrqynZCkuUCzT+gy8WU9uQEHUiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcga9rCuA8PGGtM3/ugj+Ls4n80G7O6iCySmvdDGOA1ZlOMrY7VsACIBNhFkS1/Rl
         mmuqqDSqSDmjIfsZO+Fwn8cfM2JaNnPwXWLr7ZdsYzyT4pMuw/UjlAYR5/YYFUem6g
         W4HFrQcple5O5HpiOXZxja5uPRnMxB78g5DcTQto=
Date:   Wed, 16 Jan 2019 21:27:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: imx8mq: Number clocks consecutively
Message-ID: <20190116132741.GC17702@dragon>
References: <20190116084122.GA19712@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116084122.GA19712@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:41:22AM +0100, Guido Günther wrote:
> This fixes a duplicate use of 232 and numbers the clocks without holes.
> 
> Fixes: 1cf3817bf1f5 ("dt-bindings: Add binding for i.MX8MQ CCM")
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks.
