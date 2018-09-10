Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5699C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJWc8MIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E45A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbeIJHMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeIJHMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:12:00 -0400
Received: from dragon (unknown [45.56.155.51])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E04BE2088F;
        Mon, 10 Sep 2018 01:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536541399;
        bh=rfnxCTFDOkTzXCELWrkte+GGSbQeBmzDecnhrJShReE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJWc8MIjQa0ChRobb9/i0Clwl+hAaObRBj+6DPvhJ7o5MG+vEkGFiTwgReEF6yACv
         3Q4y7F/4sLs1TYJVW+OGv+oaMgvlt1vRNVwD1JZCGFkg1LwH9E1HBt4wjWkcGlcAJE
         TQNLNL26UuGunb9/pgiXKr2wgKU56WXDu4o3m0b4=
Date:   Mon, 10 Sep 2018 09:01:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabreauto: add gpio keys support
Message-ID: <20180910010149.GA21992@dragon>
References: <1536133572-2138-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536133572-2138-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 03:46:12PM +0800, Anson Huang wrote:
> Add i.MX6QDL SabreAuto board's gpio keys support, there
> are 5 gpio keys on base board:
> 
> SW3: KEY_HOME;
> SW4: KEY_BACK;
> SW5: KEY_PROGRAM;
> SW6: KEY_VOLUMEUP;
> SW7: KEY_VOLUMEDOWN;
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
