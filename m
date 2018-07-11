Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BBC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BF020BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YckIpoOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BF020BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbeGKNZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbeGKNZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:25:14 -0400
Received: from dragon (unknown [45.56.152.98])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40DB20652;
        Wed, 11 Jul 2018 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531315255;
        bh=DNfR8lKnjmisnhCCIGBa/9VGLoN37qq/gB2zP36jKEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YckIpoOQhgEU+P+cIvV2oxnd2rGQEKGj8UHCkDkBO4hD5eLwvuXY0QpLjF3zcoZ3o
         N2WHTs2qi9n3Wjb22SoYdoCv/yt+wX6StdW8kFtU5TseWI7sZ6Bjp//bOEiq9fC4Iz
         zNnXAFxLmB3ERUN4JSV6Eo3mWbgLqM8X8Cx8Xcdo=
Date:   Wed, 11 Jul 2018 21:20:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] Fix imx6sl display power domain
Message-ID: <20180711132019.GK6959@dragon>
References: <cover.1531310547.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1531310547.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:11:15PM +0300, Leonard Crestez wrote:
> Leonard Crestez (2):
>   soc: imx: gpc: Disable 6sl display power gating for ERR006287
>   ARM: dts: imx6sl: Convert gpc to new bindings

Applied both, thanks.
