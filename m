Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB2C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DAE21473
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfARSgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:36:51 -0500
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:40908 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728288AbfARSgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:36:51 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id EC41D18224B96;
        Fri, 18 Jan 2019 18:36:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lamp29_587eb927af536
X-Filterd-Recvd-Size: 2093
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 18 Jan 2019 18:36:48 +0000 (UTC)
Message-ID: <537b4ea9870fbb93e26f83e7a06ff2091db39ec5.camel@perches.com>
Subject: Re: linux-next: Fixes tag needs some work in the clk tree
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Fri, 18 Jan 2019 10:36:45 -0800
In-Reply-To: <20190118174127.GA822@flashbox>
References: <20190116083440.11b6839c@canb.auug.org.au>
         <154767815973.169631.1738587342757192096@swboyd.mtv.corp.google.com>
         <CAOMZO5DSbVpha=1_s5K+-vodD+N1fGnj41_UKmvqxDOPhxXwfg@mail.gmail.com>
         <154775054438.169631.5111867106558251203@swboyd.mtv.corp.google.com>
         <878szi3zp6.fsf@concordia.ellerman.id.au>
         <154783304655.169631.12906027462791855701@swboyd.mtv.corp.google.com>
         <20190118174127.GA822@flashbox>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 10:41 -0700, Nathan Chancellor wrote:
> On Fri, Jan 18, 2019 at 09:37:26AM -0800, Stephen Boyd wrote:
> > Do you have a patch for checkpatch too? Maybe Joe can solve my problem.
> Joe posted a checkpatch diff in another thread:
> https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com/

That proposal has the negative that a Fixes: line
is often after a Signed-off-by: line and the test
does not validate Fixes lines after Signed-off-by:s.

I would still appreciate some external testing of
the proposed patch.



