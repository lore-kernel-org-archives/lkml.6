Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A70C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DA321B31
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DA321B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbeHIBJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:09:29 -0400
Received: from baldur.buserror.net ([165.227.176.147]:59044 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:09:29 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0] (helo=home.buserror.net)
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fnXEv-0002ZY-0W; Wed, 08 Aug 2018 17:47:37 -0500
Date:   Wed, 8 Aug 2018 17:47:34 -0500
From:   Scott Wood <oss@buserror.net>
To:     Camelia Groza <camelia.groza@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180808224734.GA32575@home.buserror.net>
References: <6fa5aa04d257525c5703b7c8ca833ec0ae0047c7.1531903211.git.camelia.groza@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa5aa04d257525c5703b7c8ca833ec0ae0047c7.1531903211.git.camelia.groza@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: camelia.groza@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [2/3] powerpc/dts/fsl: t4240rdb: use the Cortina PHY driver
 compatible
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:46:50PM +0300, Camelia Groza wrote:
> The Cortina PHY requires the use of the dedicated Cortina PHY driver
> instead of the generic one.
> 
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
> ---
>  arch/powerpc/boot/dts/fsl/t4240rdb.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied with the changelog updated to talk about hardware compatibility
("The Cortina PHY is not compatible with IEEE 802.3 clause 45") rather
than driver choice.

-Scott
