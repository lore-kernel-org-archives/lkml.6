Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A79C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE47A214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="wjBRXoz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE47A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJKAYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:24:48 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:3874 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJKAYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:24:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 1BC0F3D8;
        Wed, 10 Oct 2018 19:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1539190899; x=1541005300; bh=5AmPBE4/VxhPgEv8KhruXhMNtNd2NRf6iD5
        pOaVhGrE=; b=wjBRXoz/GnX+QlfD3jyVgjwB6dPtjDxvnmCUA1keU/w3LNJehqs
        MM8recWVuO4oe4wkoNodOe4QW4RbPZbo2zDWYqhZE4p9LC5tHFP+yN9RS/GDcr1Y
        vPfoxUoaUa7c5nxiq3ECQlOgVxldc2KzhOzg35x2lX5u1xEcR0+YwTH/0CyccTCS
        +dUXVTu/7At4hcRzgylmpzeFfawRSGSTNHD5HCMfTy6sAbCuUUyO22ZVM2RNOOQh
        1uIvz3b86WHVdnT6sRR4o45XmeOl6srIEt0/P4eubDB69hRy3AfU5zgwN0ljTheR
        0g0kQ1xfvUoDolOX5AwuNM+jE4FjWxV5tjePAutbMqblYdWEjLYcq8rNDF/cvGvo
        hC1tjmwQsVsIButLaVO59+jD6yJ00EVvK/YxpTP/AtW/v8jQmJajyrD8r9KrQ3TQ
        6Dw/NeK6qsyrq06e4R73T+oUMiuPjIrTFNrM9Im5WVkADUZysIA/TAfikZKXqxO+
        jPooIuRwP+uPGyrAP/582nf4szVV1U1bgzpCyl1FRr/VNWIVL/94x2WY5aqcZjN0
        BvLJDL76VcZPWVeC01C6cDIDVQW39UZEYoP1GxYmrTn10+3UAfMP6Z3O5Texnr37
        MYmeHsQsHF1y5TkTj4OSDDxXt1bN2YxfSxtKj3mCkDIlJf5I9yFBlGVM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QIL5ylSVhmvs; Wed, 10 Oct 2018 19:01:39 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 9B677125;
        Wed, 10 Oct 2018 19:01:39 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 16E841DE;
        Wed, 10 Oct 2018 19:01:39 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] doc:it_IT: add some process/* translations
Date:   Wed, 10 Oct 2018 19:01:29 +0200
Message-ID: <36650122.oeEFLVpePO@harkonnen>
In-Reply-To: <20181007084210.0cec373a@lwn.net>
References: <20181005185157.27819-1-federico.vaga@vaga.pv.it> <20181007084210.0cec373a@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 7, 2018 4:42:10 PM CEST Jonathan Corbet wrote:
> Just FYI, I'll hold this until after the start of the merge window.

Ok

> This is starting to be quite a bit of translated material!  Are you sure
> you're up to maintaining it all as the documents evolve?

Short answer:
yes

Long answer:
I cannot guarantee that as soon as there are changes in English we are there 
to translate them immediately within the same release. We do our best to do 
it, but I think that a delay has to be taken into account (a change has to be 
accepted first, and then we can translate. Already in the optimal process 
there is a delay).
The intention is to continue our translations with "stable" documents so that 
maintenance become easier.

As we discussed a bit some time ago, Documentation is not always in sync with 
the code, and translations may not be in sync with the official Documentation. 
So, I understand your question (fear) and I answer "yes with a human delay" 
because we are not a company but just free contributors (which means: we are 
using our free time).






