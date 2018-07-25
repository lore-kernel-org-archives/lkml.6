Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52006C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F231920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F231920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbeGYP1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:27:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:46310 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbeGYP1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:27:40 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 17D6230D;
        Wed, 25 Jul 2018 14:15:48 +0000 (UTC)
Date:   Wed, 25 Jul 2018 08:15:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-mtd@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] mtd: nand: fix spelling in driver api documentation
Message-ID: <20180725081547.21ea6597@lwn.net>
In-Reply-To: <20180725092928.243bf07f@xps13>
References: <20180720075334.24254-1-marcel@ziswiler.com>
        <20180723093924.04af0e2f@lwn.net>
        <20180723181915.5f35f668@bbrezillon>
        <20180725092928.243bf07f@xps13>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 09:29:28 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > > That's not a spelling mistake, that's a factual change.  I'll apply the
> > > patch since it appears to be correct, but will be tweaking the changelog.    
> > 
> > I think Miquel had planned to apply this patch to the NAND tree, but we
> > don't seem to have conflicting changes on this file, so feel free to
> > take it in the doc tree.
> > 
> > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> 
> Can you confirm you will take this patch?

Yeah, that's what the "I'll apply the patch" part above means :)  It's
already in docs-next.

Thanks,

jon
