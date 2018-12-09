Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF462C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5415620865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544359858;
	bh=zOr9gCr1YQksQ4Efd8nd9wFvYrPiM35M1JKyA3ETjH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SgHJBbF04/7vAPnkuN6u53U4pRaVB7NmGMJ41giYZbeVe79ukNn4990zdFdi4AV4O
	 xm5v6mfsTnoqYDgHRPlBwmkmL6AmumZ9AGlyejQn9SUGuBYcVLstdaqLyXn4OBNwIf
	 W/9M/MGROQS+VjPKaDb+W3mMMrtsbl2ued5jtU3I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5415620865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLIMu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 07:50:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeLIMu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 07:50:57 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB5920831;
        Sun,  9 Dec 2018 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544359856;
        bh=zOr9gCr1YQksQ4Efd8nd9wFvYrPiM35M1JKyA3ETjH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVSECJ1lYYn9soS8/NOnS2vKL/CrPLENvYm+M67xgB46UYNvhe7RdR1K0Sl61f9Oa
         1RIWelkR95UAz1YYf6L2hqdKbXDLgNRtM90gL+0pqLIIMToCBoOv+x6D/msiP/YSmv
         KyvAuwiVZLSCGcpnW5i+0KuAdbg+SMtEU2D4RbwA=
Date:   Sun, 9 Dec 2018 20:50:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx6ul: Remove extra space between node name
 and {
Message-ID: <20181209125006.GD22960@dragon>
References: <58cf0fc7b3e0037344de3a02ecc3b210abfbfc28.1544123990.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cf0fc7b3e0037344de3a02ecc3b210abfbfc28.1544123990.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 07:22:16PM +0000, Leonard Crestez wrote:
> Fixes: 7d1cd2978664 ("ARM: dts: imx6ul: add gpmi support")
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
