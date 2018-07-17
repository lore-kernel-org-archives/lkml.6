Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D5AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36CD20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36CD20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darmarit.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeGQMSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:18:05 -0400
Received: from smtp1-3.goneo.de ([85.220.129.32]:39231 "EHLO smtp1-3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730736AbeGQMSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:18:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id B416923F728;
        Tue, 17 Jul 2018 13:45:46 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1aQ6CVxbSuH4; Tue, 17 Jul 2018 13:45:45 +0200 (CEST)
Received: from ryzen (dyndsl-091-248-070-004.ewe-ip-backbone.de [91.248.70.4])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 5A71A23F6EF;
        Tue, 17 Jul 2018 13:45:45 +0200 (CEST)
Message-ID: <db7c7d48d1e8344a4d78193830a544ee8b6bf43b.camel@darmarit.de>
Subject: Re: [PATCH net-next 1/3] docs: networking: Fix indices heading
 indentation
From:   Markus Heiser <markus.heiser@darmarit.de>
To:     "Tobin C. Harding" <me@tobin.cc>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 17 Jul 2018 13:45:44 +0200
In-Reply-To: <1d7a309eb7561b9bb4c31f5deb9a0b63b6263232.camel@darmarit.de>
References: <20180717042906.17308-1-me@tobin.cc>
         <20180717042906.17308-2-me@tobin.cc>
         <1d7a309eb7561b9bb4c31f5deb9a0b63b6263232.camel@darmarit.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 17.07.2018, 10:28 +0200 schrieb Markus Heiser:
> Am Dienstag, den 17.07.2018, 14:29 +1000 schrieb Tobin C. Harding:
> > Currently the 'Indices' heading is not aligned with column 0, it should
> > be.
> 
> Hi Tobin, thats not correct. The 'Indices' heading is a part of the 'only'
> block:
> 
>   http://www.sphinx-doc.org/en/stable/markup/misc.html#including-content-based-on-tags
> 
> -- Markus --

I realized that we have not well documented SPHINXDIRS, to be more elaborate ..

The tag 'subproject' will be set from the networking/conf.py if you run:

   make -k SPHINXDIRS="networking" htmldocs

to just build only the networking folder (aka subproject). For more info,
please run 'make help' and take a look at the 'Documentation targets' section.

In short: a subfolder of Documentation/ with a conf.py file in, is a subproject
and can be build separate.

 -- Markus --



> 
> > 
> > Fix 'Indices' heading indentation.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  Documentation/networking/index.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> > index 6123a7e9e1da..a4bbde70bcb9 100644
> > --- a/Documentation/networking/index.rst
> > +++ b/Documentation/networking/index.rst
> > @@ -20,7 +20,7 @@ Contents:
> >  
> >  .. only::  subproject
> >  
> > -   Indices
> > -   =======
> > +Indices
> > +=======
> >  
> >     * :ref:`genindex`
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
