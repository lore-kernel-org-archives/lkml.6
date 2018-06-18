Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A237BC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F29C2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F29C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936402AbeFRUiT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:38:19 -0400
Received: from botnar.kaiser.cx ([176.28.20.183]:43784 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935073AbeFRUiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:38:17 -0400
Received: from martin by botnar.kaiser.cx with local (Exim 4.72)
        (envelope-from <martin@botnar.kaiser.cx>)
        id 1fV0tU-0000r7-HE; Mon, 18 Jun 2018 22:36:56 +0200
Date:   Mon, 18 Jun 2018 22:36:56 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: mxc: set spare area size register
 explicitly
Message-ID: <20180618203656.GA1926@botnar.kaiser.cx>
References: <1528025495-14443-1-git-send-email-martin@kaiser.cx>
 <1528637487-25172-1-git-send-email-martin@kaiser.cx>
 <20180618160929.421bee73@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618160929.421bee73@bbrezillon>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thus wrote Boris Brezillon (boris.brezillon@bootlin.com):

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: stable@vger.kernel.org

> Hm, a Cc-stable tag without its associated Fixes tag, I don't like that.
> Can you find which commit introduced this bug?

the particular corner case that I fixed has never really worked. As my
fix updates the preset operation, I'd suggest adding a Fixes tag pointing
at the first commit that introduced the preset operation.

I'll resend my patch with this tag added.

Best regards,

   Martin
