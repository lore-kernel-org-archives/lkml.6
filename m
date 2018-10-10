Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A24214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B2V0yM/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A24214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJKAm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:42:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJKAm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lQdJj9dFVoG56Zv546Lq4c2X4TEL5xqN511DmFXmRk8=; b=B2V0yM/nhR14U7/CBnBUWoZbO
        atEoy1bErAla4ONsdOjfSahyTHHUAzSEnPAvRXR2nzN+//sFG0eD2TCYqztQ1WjTP0kFJMJl210A7
        YIXfryoKYWWgAGVrFJFIeMHWTvApbvNT3KMlDQ7+EysNMFUqwbiKMDus4E3WBg7hfN9xqx4/FYqp7
        bMzUJOIbpyKqvULSUdutIZ3c7XPPpALZ6YiKnv6Zz/lZ9kkQ4SfVED6QjgBQXI7efk1dA7WJs7zDi
        COKwIWfQoeRbYJzz0gDe8WgK3psU2EBfMuETLwuJmGI9kcKdbXmgKAo4Dm551YxO9g89H+jzrgQtF
        qH2v+KstQ==;
Received: from 177.43.144.224.dynamic.adsl.gvt.net.br ([177.43.144.224] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAI8n-0006jp-0r; Wed, 10 Oct 2018 17:19:21 +0000
Date:   Wed, 10 Oct 2018 14:19:17 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Message-ID: <20181010141917.611fb5d8@coco.lan>
In-Reply-To: <20181010165308.187aae51@alans-desktop>
References: <1538861738.4088.5.camel@HansenPartnership.com>
        <1538861851.4088.7.camel@HansenPartnership.com>
        <20181008172303.4f06cd94@coco.lan>
        <20181010165308.187aae51@alans-desktop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 10 Oct 2018 16:53:08 +0100
Alan Cox <gnomes@lxorguk.ukuu.org.uk> escreveu:

> > -Maintainers have the right and responsibility to remove, edit, or reject
> > +Maintainers may remove, edit, or reject
> >  comments, commits, code, wiki edits, issues, and other contributions that are
> >  not aligned to this Code of Conduct, or to ban temporarily or permanently any
> >  contributor for other behaviors that they deem inappropriate, threatening,
> > 
> > The previous text seems too much legal for my taste.
> >   
> 
> That is just as confusing. Maintainers have the right to remove, edit,
> reject commits that *are* aligned with the code as well.

Good point. Yeah, a maintainer can do whatever he thinks it is 
appropriate for a patch - even when it follows the CoC.

> So what exactly is the point here ?

The point is "responsibility" - that sounds like it is bounding a legal
duty to a maintainer.

While this makes sense for Github (as the company doesn't want to be
responsible for sanitizing every single post), this doesn't work for
e-mail based workflow, where the message is stored on a distributed
way, as a maintainer can't "remove, edit or reject" an e-mail.

Thanks,
Mauro
