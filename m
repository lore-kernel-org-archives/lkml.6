Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4985FC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A87A2147D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A87A2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbeLBXWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:22:23 -0500
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:36066 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbeLBXWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:22:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7376E1822385E;
        Sun,  2 Dec 2018 23:22:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: north85_88458c8a24a09
X-Filterd-Recvd-Size: 2318
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Dec 2018 23:22:16 +0000 (UTC)
Message-ID: <772d86622aea17e1c7b5ac05e096f1a129fc86b4.camel@perches.com>
Subject: Re: [PATCH] staging: iio: ad5933: add binding doc for ad5933
From:   Joe Perches <joe@perches.com>
To:     Himanshu Jha <himanshujha199640@gmail.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Date:   Sun, 02 Dec 2018 15:22:15 -0800
In-Reply-To: <20181202185043.GA2007@himanshu-Vostro-3559>
References: <20181202165712.t6pd6ygq57llf2lr@smtp.gmail.com>
         <20181202185043.GA2007@himanshu-Vostro-3559>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 00:20 +0530, Himanshu Jha wrote:
> On Sun, Dec 02, 2018 at 02:57:12PM -0200, Marcelo Schmitt wrote:
> > Add a devicetree documentation for the ad5933 and ad5934 impedance
> > converter, network analyzer.
> > 
> > Co-Developed-by: Gabriel Capella <gabriel@capella.pro>
> 
> checkpatch spits out:
> 
> WARNING: Non-standard signature: Co-Developed-by:
> 
> Co-developed-by Vs Co-Developed-by ?
> 
> Documentation/process/5.Posting.rst: - Co-developed-by: states that the patch was also created by another developer
> Documentation/process/submitting-patches.rst:12) When to use Acked-by:, Cc:, and Co-Developed-by:
> 
> Confusing! Don't know which one is correct.

I think neither one.

What's the real purpose or value of it?
There isn't one as far as I can tell.

Just use Signed-off-by:

Or maybe add multiple "Authored-by:" if
anyone is all that concerned about authorship
crediting...


> 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> > ---
> 
> Use `./scripts/get_maintainer.pl <your_patch>` to list the DT
> maintainers and the relevant mailing list.
> 
> 

