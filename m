Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95604C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621DF20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uLKo8NDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfAIJO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:14:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45182 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIJO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:14:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x099EOBc127736;
        Wed, 9 Jan 2019 03:14:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547025265;
        bh=L6RbpFrQ9zUXUEJRWNc+rSpyKLl7L2+EYHiQ++6bbIg=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=uLKo8NDaQ0vkkOtMrB3ESd6RFBYc0qv+lIrzm69oD0l2q7d8HQ7OKzZgJaTgSgCNk
         nXhmPaR6Fra6fL0b51MNhJoH7f0+W7uhIvM8pjrCX/wqtNy7WiufOyg7pMvffKROaL
         MvLPZpb18TU2N/4zwiaBhN2d+z2jbDZeIEVlTQHU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x099EOki115035
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 03:14:24 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 03:14:23 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 03:14:23 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x099ELVE021373;
        Wed, 9 Jan 2019 03:14:22 -0600
Subject: Re: [PATCH 0/4] phy: ti: Add AM654 USB2 support
To:     <kishon@ti.com>
References: <1544022206-2300-1-git-send-email-rogerq@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C35BB6D.2030509@ti.com>
Date:   Wed, 9 Jan 2019 11:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1544022206-2300-1-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 05/12/18 17:03, Roger Quadros wrote:
> Hi Kishon,
> 
> This series extends omap-usb2 PHY driver to be used
> for AM654 USB2 PHY.

Any comments on this series? If it looks fine, could you please
queue this for -next. Thanks.

cheers,
-roger

> 
> cheers,
> -roger
> 
> Roger Quadros (4):
>   phy: ti: usb2: Fix logic on -EPROBE_DEFER
>   phy: ti: Don't depend on OMAP_OCP2SCP
>   dt-bindings: phy: ti: Add support for AM654x USB2 PHY
>   phy: ti: usb2: Add support for AM654 USB2 PHY
> 
>  Documentation/devicetree/bindings/phy/ti-phy.txt |   1 +
>  drivers/phy/ti/Kconfig                           |   6 +-
>  drivers/phy/ti/phy-omap-usb2.c                   | 105 ++++++++++++++---------
>  3 files changed, 67 insertions(+), 45 deletions(-)
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
