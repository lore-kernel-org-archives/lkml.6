Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76778C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443332184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Piq6eug2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfBLHJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:09:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLHJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yhVxFenIgPub/w/35qpJsH+EleYVEBaF1uzR5/OHDEM=; b=Piq6eug2cDHgdEngRoM2T7JLj
        Kqm+gS30pLwOJZw6nBQ2W9ev3eZLjYfUmqr6iFG7P5OND1p2HrJJMPqlY+vJGsluCQWStbcVoAxsM
        LqpFfxJP7HGdZTp+Pa4Pq6dEB6DmS8UY1dSFnbAv3djnvodyeDllu+Lg8X1ByAP9SydxSGsVCWgas
        r63YHOF1RHSCOZPHwryNpDcFn0vLiqumehJ3NI81iHAQN2qeme92sO9tW68shbQtAzb3wLReI+Kp5
        MHJgcbmRAyF3s0KZNHRPNZez6J4FVDKi0iC7ZHvEKBXOTYNLbZyx0DY/fcaY81O2aDULt4zJWokGc
        7KxYpW2nQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSCP-0001AX-KJ; Tue, 12 Feb 2019 07:09:45 +0000
Date:   Mon, 11 Feb 2019 23:09:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] irqchip: sifive-plic: Differentiate between PLIC
 handler and context
Message-ID: <20190212070945.GF26747@infradead.org>
References: <20190119055625.100054-1-anup@brainfault.org>
 <20190119055625.100054-5-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119055625.100054-5-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
