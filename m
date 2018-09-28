Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165E2C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105E206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RwQr+ETF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B105E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeI2FO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:14:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55664 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeI2FO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:14:58 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8SMmfEo030063;
        Fri, 28 Sep 2018 17:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538174921;
        bh=+4lbJOssBM8+rq1EiZtGFwLXynZrE6qnmWtmjivWgKk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RwQr+ETFNG+SZ0JZlyBaOxXwpXBvFtWBBh0lC0VSFtRPqyGcTTXv7a9gvNOh/YeJ0
         Wb0VDFPiV38X6TsYsEldTGKtFDoDUIqfPZ3RPzYIDGUFGPU2syUBT3EWmMADymG9c3
         3npy/f8z0myGaPZeA7yWMhfz8DzmVJaKHYdggwek=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SMmfCp002215;
        Fri, 28 Sep 2018 17:48:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 17:48:41 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 17:48:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SMmfKP032039;
        Fri, 28 Sep 2018 17:48:41 -0500
Date:   Fri, 28 Sep 2018 17:48:41 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Joe Perches <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>
Subject: Re: Bad MAINTAINERS pattern in section 'Texas Instruments' System
 Control Interface (TISCI) Protocol Driver'
Message-ID: <20180928224841.pbupoemlo4i2j3ks@kahuna>
References: <20180928220455.31806-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180928220455.31806-1-joe@perches.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:04-20180928, Joe Perches wrote:
> Please fix this defect appropriately.
> 
> linux-next MAINTAINERS section:
> 
> 	14531	Texas Instruments' System Control Interface (TISCI) Protocol Driver
> 	14532	M:	Nishanth Menon <nm@ti.com>
> 	14533	M:	Tero Kristo <t-kristo@ti.com>
> 	14534	M:	Santosh Shilimkar <ssantosh@kernel.org>
> 	14535	L:	linux-arm-kernel@lists.infradead.org
> 	14536	S:	Maintained
> 	14537	F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> 	14538	F:	drivers/firmware/ti_sci*
> 	14539	F:	include/linux/soc/ti/ti_sci_protocol.h
> 	14540	F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> -->	14541	F:	include/dt-bindings/genpd/k2g.h
> 	14542	F:	drivers/soc/ti/ti_sci_pm_domains.c
> 	14543	F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
> 	14544	F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
> 	14545	F:	drivers/clk/keystone/sci-clk.c
> 	14546	F:	drivers/reset/reset-ti-sci.c

Sorry about that Joe. Thanks for the headsup.

https://patchwork.kernel.org/patch/10620509/ posted.
-- 
Regards,
Nishanth Menon
