Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7D8C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C98720684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="LdaW/kmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C98720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJBPZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:25:24 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:48036 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJBPZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:25:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id CD7944068B;
        Tue,  2 Oct 2018 10:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1538469792; x=1540284193; bh=9I3mhbSPlWpHa5QXZkDqBVAouF5ZA6sGAi2
        Ke0tVqVI=; b=LdaW/kmEtSJ2wNc6a4Yov4z2kJulsFAKSCc3R0pQZIrOYyzYOKM
        lWI67PWkWwr8yBuXpg9SwQU42+RlSTqsV9JOcQ5cZo1YKlYXAnE6yghHRJ5cS3ES
        vFXg+6rNKIW3SSE4ud45w+1UPNp6E8TQdpRpXWW9Hyb5UsjZW6WyF+iQvltnhnLq
        522TuXw/X626ridMKKPZIFOZPnAeqNgj0nrimEK7leHl7jgTzIe8bXoPLu6WG5Xg
        Y4HIgItMAsPIWLr4ebaiyZ3YnDxmo7/MtZzch5ttQe3ZBI5/VlbwVDSYAmwUctNK
        4kwwU5lK+rTgQe4v/7zF/rz/FOXe10JRY9b46YBwJX0fDdldtcMdvMwgGwbSJAs1
        NlXwxrFgPsaXvGMeMn9eVmNZxy191zX6bUPjquJE6SE0WP7DWqVpT2oh3Z4kEer0
        PtsL1aqOGgTkjnGxrtQNrs2ykz/ZUYu7k3Pa95ItofIGxXRHNYkfMjZJTHpdL+Wn
        g++r7dzDq66xq0p0Yp8XxM0xW8bJAlP0TwXOpC0sUC/KA77vlx8ql7WZ+rf3pWxF
        vNUd5tD1sEJBDH7Zz/BA5cb83dSmWipn74QaHQokMiJKrooQ8YiRrfMmRnrDg2u4
        gbROFgN4U2dwdRevbFLGSt2mXGoMcYlcedoBvpLAKGOIc7vCJH4zmhMo=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HEMsKuBP399v; Tue,  2 Oct 2018 10:43:12 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 9F549402C0;
        Tue,  2 Oct 2018 10:43:12 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id EDE9927C;
        Tue,  2 Oct 2018 10:43:11 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: add some process/* translations
Date:   Tue, 02 Oct 2018 10:43:10 +0200
Message-ID: <1608921.jop3HA6fpD@pcbe13614>
In-Reply-To: <20180920143511.26136ddd@lwn.net>
References: <20180909161641.3792-1-federico.vaga@vaga.pv.it> <20180920142957.09000163@lwn.net> <20180920143511.26136ddd@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

I was on a long holiday. I will re-send a V2 patch without that document in 
the next days

On Thursday, September 20, 2018 10:35:11 PM CEST Jonathan Corbet wrote:
> On Thu, 20 Sep 2018 14:29:57 -0600
> 
> Jonathan Corbet <corbet@lwn.net> wrote:
> > On Sun,  9 Sep 2018 18:16:41 +0200
> > 
> > Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > > This patch does not translate entirely the subfolder "process/"
> > > but only part of it (to begin with).
> > > 
> > > In order to avoid broken links, I included empty documents
> > > for those which are not yet translated.
> > > 
> > > In order to be able to refer to all documents in "process/",
> > > I added a sphinx label to those which had not one.
> > > 
> > > Translated documents:
> > > - howto
> > > - 1.Intro
> > > - clang-format
> > > - coding-style
> > > - kernel-driver-statement
> > > - magic-number
> > > - volatile-considered-harmful
> > > - development-process
> > > 
> > > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> > > Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>
> > 
> > Applied, thanks.
> 
> Actually, I just backed that out, sorry.  There's an immediate conflict
> with -next over code-of-conflict.rst that is best avoided, and there is
> no point in adding a translation of the old code. If you can respin the
> patch set without that change, I'll apply it.
> 
> Thanks,
> 
> jon


-- 
Federico Vaga
http://www.federicovaga.it/


