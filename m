Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2573BC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C8A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="igAvnL1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfAOP16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:27:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfAOP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OA0UhEPE6788YS3yup2Ddds4qfo+2Gi9J0ZwV1q2rGg=; b=igAvnL1i6cusXUTsVbk4tIG2c
        AKHrnbw+BBIRfOniVPZJMtBPxvxWSY4Lj9xCz0gpCt16hPW3XudMvLriPUtVVIXm+56U1oFEhCcUW
        N7+BfUHkqUKcdW4sM5RKPVLQ735aBjH8+pV4w8bRpCWsfRRvHU1EcODy9mhDCXsVr2W2T1YMf3Yr1
        m3W2gksql/Kn/IuSzlJgbBIl67F3LVZxyuuzgtBRWu0Hq7ksjVQYW7BoMNQnBazjsUSTRNCHAooJ1
        NOuFB4bTKy3WonRkLng2icTcn5IRklMVPE/Zi7jM1mmlOIIm3nv4Hk/Igf8Tv4JSeE3k2PKRDhv+7
        OL5/XPtgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjQdB-0007yB-T1; Tue, 15 Jan 2019 15:27:57 +0000
Date:   Tue, 15 Jan 2019 07:27:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, sachin.ghadi@sifive.com,
        thierry.reding@gmail.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190115152757.GB26443@infradead.org>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From a general code quality point of view this looks fine to me.
I don't really know anything about the PWM subsystem, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>
