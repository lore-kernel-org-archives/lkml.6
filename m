Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29BB2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549865532;
	bh=ukjViv8ENbx3dHpm6gKFDW8/tAncoM54okjsh2iOTA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i73qbtm/iP23EZH74JOIy9H0Lu8sF1TCOGzA95nPul0LtVE0gej90cTSn6DZ8J3UG
	 xFoeszVFqX5Zl+2z/Zw3uxPHONqThkIn+VDO1M15aSZBuRV4Q8ybJqwRIvCWpOCdZ0
	 k+LGaLaZPmcWas+C1xwx9UM6i77roKVgortegoms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBKGML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKGMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:12:10 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529C82084D;
        Mon, 11 Feb 2019 06:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549865530;
        bh=ukjViv8ENbx3dHpm6gKFDW8/tAncoM54okjsh2iOTA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNmzAfR1gEz8ff/fayX14bw67bwl0kd7W58XHljSRpmgDC1cig+cjJ515MYYCTCKf
         G2SV+rRyUX+2qgD9lZRzLSowY/O/RIcCiGvUn+py4FUyVtxxnUUymmSn7U4rsO52xH
         q0YSoVmROx8jF+MoppM5MB2/eoYXI1kn/l4yUaH8=
Date:   Mon, 11 Feb 2019 14:11:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] ARM: dts: imx: Add support for Logic PD i.MX6QD EVM
Message-ID: <20190211061155.GO22487@dragon>
References: <20190210205723.15708-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210205723.15708-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 02:57:23PM -0600, Adam Ford wrote:
> The EVM consists of a system on module (SOM) and baseboard, and LCD.
> This patch adds a DTSI file for the SOM and baseboard separately,
> then a wrapper to combine them and specify processor type and a
> LCD information.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
