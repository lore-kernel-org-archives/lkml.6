Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF0EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE339206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547645186;
	bh=opnxPWfcl8lROKcOERNn51KMVYIbbdUZt/fNQMzRB1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Klq+XNOBYX6xbZUHamzuY6H6NPa6hSQugrSmHMGF2mQkxtBP+SiFpejcFb3Q/7SH5
	 /OFYS78ixuGaPMLwQ7d8N5RY7vX9IxbXd9G69Y71+zksAmLKcOVkqCSFRYndl5xooW
	 kmeMLFeCLJv7hEfgxD0y8AGBbhu/HSpJCWEDMk6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404305AbfAPN0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732880AbfAPN0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:26:24 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA3920651;
        Wed, 16 Jan 2019 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547645184;
        bh=opnxPWfcl8lROKcOERNn51KMVYIbbdUZt/fNQMzRB1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRQie5cQpLa3QXBPAm7bqOWcMmb7z6Gwx5uFZhP5mW3mzcMwscQk+/5EVfOXGuKq1
         KngOW/3YBc+RPPT9fRxnJV1ja3kF+2j5NlNNsX4jGZ0xxU5bV/GLQdZz7fYBfvT5Ol
         5hyoq5y5nwRnuLtng5LPx5eY6GSgBqmxbBqoh+pA=
Date:   Wed, 16 Jan 2019 21:25:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Anson Huang <anson.huang@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: imx8qxp: Fix MU4_INT number
Message-ID: <20190116132554.GB17702@dragon>
References: <20190116132124.4383-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116132124.4383-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 01:21:36PM +0000, Daniel Baluta wrote:
> MU4_INT correct number is 180, while 179 is for MU3_INT.
> 
> Fixes: 3d91ba65fec ("arm64: dts: imx: add imx8qxp support")
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
