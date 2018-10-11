Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41309C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70C3206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T9y7NwKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70C3206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJKJzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:55:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=32Sj7YTpr29sCd0zeNTVaXrFBfL4bG09869xpoRzhLg=; b=T9y7NwKlILZtbJA9CVr/aJ9mB
        cbIa3bSXGigQpLEMBoamURDl/c6vZEYFSSrURskvZug7rUj8eZs2VVGsfgPh8h2jllwWlCxTeBf20
        3tOZ2UoD8o2HgVXf4lUwzNDKgnJW4Le8yB8vsDYNjNB9VgUkHh08N3XfQvjq3TFVfp+GnZVEuIJPa
        lnHc2hcGWf5XEBOIlbMo/qzHT/T/vj+QSkmoee/m7j471LjlksUaOxJcdEyCdYocrBD3MluU031AS
        hm6Q4qOwwMl7iWQ8+H99/HTd7O/wqdGxqSI2ji10rwZXUCwgnL/NkxnmUVmkGTTFeRcX1EN/IbHCw
        wkhH1kQPA==;
Received: from 177.43.144.224.dynamic.adsl.gvt.net.br ([177.43.144.224] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAQkN-0004rg-9z; Thu, 11 Oct 2018 02:30:43 +0000
Date:   Wed, 10 Oct 2018 23:30:39 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] code-of-conduct: Add back the
 TAB as the central reporting point
Message-ID: <20181010233039.6ab78374@coco.lan>
In-Reply-To: <20181010211313.5a63ce6f@alans-desktop>
References: <1539202053.12644.8.camel@HansenPartnership.com>
        <1539202230.12644.12.camel@HansenPartnership.com>
        <20181010211313.5a63ce6f@alans-desktop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 10 Oct 2018 21:13:13 +0100
Alan Cox <gnomes@lxorguk.ukuu.org.uk> escreveu:

> On Wed, 10 Oct 2018 13:10:30 -0700
> > +appropriate to the circumstances. The TAB is obligated to maintain
> > +confidentiality with regard to the reporter of an incident.  
> 
> I would add (except where required by law.)

With the proposed change by Alan, you can add my:
	Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Thanks,
Mauro
