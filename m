Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8EAECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4BC20850
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB0Vyq2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4BC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeGSD1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbeGSD1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:27:17 -0400
Received: from dragon (unknown [45.56.152.101])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2392320673;
        Thu, 19 Jul 2018 02:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531968388;
        bh=NO1GQ6GWAWSDOjETbLiSyjkpHhgrK4aqHN1chaykUhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pB0Vyq2NmeWHgUYXBRa8rZvxF6zuwbCPUtFChcKpm8sZbEWGnyIJx/aRFFYnYe/yE
         2lkYto0UJeL6hZyPzDFwzzXFrMtRaj4xT28f6bvx3TIxX+q1kYqVViWk2PImVuI4sK
         lvOoxvTeyAt2znJs6rxVPd96IaS3Qc/4arUV47a4=
Date:   Thu, 19 Jul 2018 10:46:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        Davide Bonfanti <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: Re: [PATCH v3 1/3] ARM: dts: i.MX6: imx6dl-mamoj: Add parallel
 display support
Message-ID: <20180719024608.GR4576@dragon>
References: <20180717092526.32215-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717092526.32215-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:55:24PM +0530, Jagan Teki wrote:
> This patch adds parallel display support for i.MX6DL Mamoj board
> along with relevant backlight through pwm.
> 
> LCD power sequence is added by 'Michael Trimarchi'.
> 
> Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
> Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

'ARM: dts: imx6dl-mamoj: ...' being prefix is good enough.  I fixed it
up and applied all.

Shawn
