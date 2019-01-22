Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08231C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEFD21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548136722;
	bh=Ug7uP9VQ+I1hvob15mUa7ch9wstwpTUVBtgQ5p3gNA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WNh9yA4K0RfID9cQgwEt6ASqLtOQe4qp/uKIcQmUIldcLCzyq7q7N145b5PdeTjUc
	 cCYXjz22mYRbWmPt8dOruJus2nddsF7nMOe4pCrEwXf2Eoz2m5nacH6BwSb6XK0ITP
	 LCLKKKEJQySeNdhG+FPt23hWpC/NF3F9RL7xIQq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfAVF6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:58:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVF6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:58:40 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAFEF20870;
        Tue, 22 Jan 2019 05:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548136719;
        bh=Ug7uP9VQ+I1hvob15mUa7ch9wstwpTUVBtgQ5p3gNA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sTqatmkEjltSGP+5Rw36v8n7XiAQMAkXabcD3e4Pk29zDDJR/UkU4wJWPGRCGNgSw
         UDQ7CVgOj5hTFGo+Mo2gBXUYAK/GsBNmQV+4vXb7msOq1TPUUfkWbTPrdFTmT6t7VX
         5i/Ps8kM9gB4SEl38WpzONmKlRwd4Z6/OEkWJGPA=
Date:   Tue, 22 Jan 2019 13:57:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, Christian Hemp <c.hemp@phytec.de>,
        Stefan =?iso-8859-1?Q?Riedm=FCller?= <s.riedmueller@phytec.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 1/2] dt-bindings: Add vendor prefix for Catalyst
 Semiconductor
Message-ID: <20190122055754.GA19929@dragon>
References: <20190121095705.27452-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121095705.27452-1-martyn.welch@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:57:04AM +0000, Martyn Welch wrote:
> Add vendor prefix "catalyst" for Catalyst Semiconductor which is
> already in use but undocumented.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied both, thanks.
