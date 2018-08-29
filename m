Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDABC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5BB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5BB2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeH2OqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:46:24 -0400
Received: from smtprelay0075.hostedemail.com ([216.40.44.75]:38544 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbeH2OqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:46:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 830101804EA50;
        Wed, 29 Aug 2018 10:50:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trade12_74f4fe2bf7100
X-Filterd-Recvd-Size: 1388
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Aug 2018 10:50:03 +0000 (UTC)
Message-ID: <7dbd5426426315977a8dc7e1745d3addce3d16b5.camel@perches.com>
Subject: Re: [PATCH net-next v2 2/2] dpaa2-eth: Move DPAA2 Ethernet driver
 from staging to drivers/net
From:   Joe Perches <joe@perches.com>
To:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        netdev@vger.kernel.org, davem@davemloft.net
Cc:     gregkh@linuxfoundation.org, andrew@lunn.ch,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com,
        madalin.bucur@nxp.com, horia.geanta@nxp.com
Date:   Wed, 29 Aug 2018 03:50:02 -0700
In-Reply-To: <20180829094240.27242-3-ruxandra.radulescu@nxp.com>
References: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
         <20180829094240.27242-3-ruxandra.radulescu@nxp.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-29 at 04:42 -0500, Ioana Radulescu wrote:
> The DPAA2 Ethernet driver supports Freescale/NXP SoCs with DPAA2
> (DataPath Acceleration Architecture v2). The driver manages
> network objects discovered on the fsl-mc bus.

Please use git 'format-patch -M' to make the diff
smaller and more readable.

