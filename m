Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E049ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B3321522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B3321522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbeIUMR3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:17:29 -0400
Received: from piie.net ([80.82.223.85]:36678 "EHLO piie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389203AbeIUMR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:17:29 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2018 08:17:28 EDT
Received: from mail.piie.net (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by piie.net (Postfix) with ESMTPSA id 2D308194A;
        Fri, 21 Sep 2018 08:20:27 +0200 (CEST)
Mime-Version: 1.0
Date:   Fri, 21 Sep 2018 06:20:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.11.3
From:   "Peter Feuerer" <peter@piie.net>
Message-ID: <f401b6fed813afb86f5442c7707bf9fb@piie.net>
Subject: Re: [PATCH 0/6] platform/x86: acerhdf: new BIOS string, better
 modparam handling
To:     "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, "Darren Hart" <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>
In-Reply-To: <20180921014421.30804-1-paul.gortmaker@windriver.com>
References: <20180921014421.30804-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

21. September 2018 03:45, "Paul Gortmaker" <paul.gortmaker@windriver.com> schrieb:

> I came across this older netbook over the xmas holidays, and noticed the
> acerhdf driver wouldn't load. Turns out the BIOS string was too new,
> and not listed in the driver. There were module params for overrides,
> but I found their use isn't quite clear without reading the source.
> 
> Here I clarify some of the module parameter usage, and then add the new
> BIOS string, so they won't be needed for this particular platform. Some
> probe code is also shifted out to be __init to reduce the driver size a
> bit. Further details can be found in the respective commit logs.
> 
> Since it was months ago when I created these patches, I retested on top
> of tree to ensure things still work, as can be seen below.

Thanks a lot for your work and this set of changes.  This improves quality.
I reviewed all 6 patches.

Reviewed-by: Peter Feuerer <peter@piie.net>

Please also add CC: Boris Petkov <bp@suse.de> for review.

[...]

-- 
kind regards,
--peter;
