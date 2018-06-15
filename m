Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA4DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F4E208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l4VRUJCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F4E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756399AbeFOUwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:52:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeFOUwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LjTnMAdK4j2AcEInZexFHqGUwTQ6+OwG1WU1nnS7j1E=; b=l4VRUJCvsPshL4DG+2brzBjRn
        i4tiJPQD2qgKSt1H/QK9EtFS7ofOG1/o0E+I8qryu32AnUDA+c39OFu8i9xyHKg8h/zCcnRzdpe8L
        ufjHqM9n8Ay0SxkdXAQFoc2oZZ+0dPp2jZLZzPenb5C5ny1FD/TqpjcIkr9aWVlFSdKRZBu+duqPK
        o4nGZ7W6mGBIcSkFrs0grjDWa5AjEehsglTdFRcyRMOW5TJK+bBu7DIi8kqpJWJ8Vmm2Uc0QYgQ0s
        rchvBCclsi8PosGWBbL0PZ4PgsRhnfTWnVSmmqC+3LDs9JQWEJXQ7bzZY/Ay/9xCy8LXjhPlX01ls
        Dq3uUxOhg==;
Received: from 177.41.114.220.dynamic.adsl.gvt.net.br ([177.41.114.220] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTvhY-0006SE-Fk; Fri, 15 Jun 2018 20:52:08 +0000
Date:   Fri, 15 Jun 2018 17:52:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 00/26] Fix some doc build warnings/errors and broken
 links
Message-ID: <20180615175203.19bc4abc@coco.lan>
In-Reply-To: <20180615130951.303a3ebb@lwn.net>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
        <20180615130951.303a3ebb@lwn.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 15 Jun 2018 13:09:51 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri, 15 Jun 2018 13:30:28 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > As discussed during the review of v2, your plans were to merge
> > things with potential to conflict with merges by the end of the
> > merge window. So, I'm resubmitting it in order to help you with
> > that.  
> 
> Is there any chance you could send them directly Linusward with my ack?
> I'm fighting a few real-world complications at the moment, and barely
> have time to breathe...

Ok, I'll send him a pull request (likely tomorrow), adding your
ack on the patches at this series.

Regards,
Mauro
