Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC44C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AF020833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+ZW3SjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AF020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeIJICE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeIJICE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:02:04 -0400
Received: from dragon (unknown [45.56.155.51])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3092087F;
        Mon, 10 Sep 2018 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536540019;
        bh=FWYa+ZLm8U8n+VxE0FaCDWjZhMRorBPeD3C7A8n4Iw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+ZW3SjPl6+9//5fg3ektX4axS1WF9iBUVAL36rj+03O/acISXKyatntsjJiQ9AON
         PwZG41885Zsf0ZXMIC/8Zu/O7eajp0Z4IHlSHTTdUnx84QdioNRajpbOybhOWykt4G
         EL+tUVpk02GCpaCyzemkkOrUKbhD/31fi+BhH9to=
Date:   Mon, 10 Sep 2018 08:38:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] dt-bindings: Add vendor prefix for Microsys
Message-ID: <20180910003852.GD21218@dragon>
References: <20180903140840.23648-1-alexandre.belloni@bootlin.com>
 <20180903140840.23648-4-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903140840.23648-4-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob

@Rob, Are you okay with this?  The patch should really be sent to you
from the beginning.

Shawn

On Mon, Sep 03, 2018 at 04:08:39PM +0200, Alexandre Belloni wrote:
> Add vendor prefix for MicroSys Electronics GmbH
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2c3fc512e746..10155a44b783 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -235,6 +235,7 @@ micrel	Micrel Inc.
>  microchip	Microchip Technology Inc.
>  microcrystal	Micro Crystal AG
>  micron	Micron Technology Inc.
> +microsys	MicroSys Electronics GmbH
>  minix	MINIX Technology Ltd.
>  miramems	MiraMEMS Sensing Technology Co., Ltd.
>  mitsubishi	Mitsubishi Electric Corporation
> -- 
> 2.19.0.rc1
> 
