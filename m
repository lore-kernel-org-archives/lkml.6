Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E2AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30BA20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/4AF2Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30BA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeILShd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:37:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeILShd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BdAjJ/k+IPiSjgANeuuImD7+Dbw0IipWNXZAI/I7YJk=; b=M/4AF2ThNtK5KjO3Eg6Sqwfpa
        mRgSr8vaH3+d+7hrtIt7PRl6sEB0hC9SXhe3UwJC0Sll27d3VFq+C9+x+gE7u4agchIi6O/wtMZc0
        LfjzrpiO4JlN6K5WKkkg9Ml/hlFPhf22DhduizduuGyUVILHjNOMaZCVM+/LnpqlBPjBVGq9QZkYu
        0OIRdYagT7G/RT9V6HDz3lh7MIOhHi+AtN4LAZbbS2KU/34kX4g3nCNyYSDxKMzzPlw6wgVEpzff5
        JKHSiJpIcEO088vSmQ7v3AFvDSZ3fd81/x53teibt17htTSxjB4bjkkS67BOvsfr1CC5RvJx7ocRG
        8dZ/rfc3A==;
Received: from [177.97.26.110] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g05GP-0008Gy-5V; Wed, 12 Sep 2018 13:33:01 +0000
Date:   Wed, 12 Sep 2018 10:32:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, kbingham@kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/4] MAINTAINERS: VSP1: Add co-maintainer
Message-ID: <20180912103256.3d15fceb@coco.lan>
In-Reply-To: <20180806143904.4716-2-kieran.bingham@ideasonboard.com>
References: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
        <20180806143904.4716-2-kieran.bingham@ideasonboard.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon,  6 Aug 2018 15:39:02 +0100
Kieran Bingham <kieran.bingham@ideasonboard.com> escreveu:

> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Add myself as a co-maintainer for the Renesas VSP driver.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Laurent,

If you're ok with this change, could you please ack?

Regards,
Mauro

Thanks,
Mauro
