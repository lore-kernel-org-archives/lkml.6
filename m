Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E35C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08BD2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLRA2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:28:07 -0500
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:41334 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726296AbeLRA2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:28:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E1F48182CED5B;
        Tue, 18 Dec 2018 00:28:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bells92_809dd50aab658
X-Filterd-Recvd-Size: 1895
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Dec 2018 00:28:03 +0000 (UTC)
Message-ID: <f0b650bf6bcf81c56f9624cdc3dbf65e158c677b.camel@perches.com>
Subject: Re: [PATCH v1 1/1] MAINTAINERS: update list of qcom drivers
From:   Joe Perches <joe@perches.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>, marc.w.gonzalez@free.fr,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Dec 2018 16:28:02 -0800
In-Reply-To: <CAP245DWOSoZ4qXQ-CgUPdRQhHyg6X_7i9h0ctwafGXYS2yZLZQ@mail.gmail.com>
References: <cover.1545063166.git.amit.kucheria@linaro.org>
         <ced6f6be01195e706ded5548897ff72503780146.1545063166.git.amit.kucheria@linaro.org>
         <d45ce5f7612ef579a9bc687bab4339f27ee35660.camel@perches.com>
         <CAP245DWOSoZ4qXQ-CgUPdRQhHyg6X_7i9h0ctwafGXYS2yZLZQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 00:20 +0530, Amit Kucheria wrote:
> On Mon, Dec 17, 2018 at 10:51 PM Joe Perches <joe@perches.com> wrote:
> > git history is used by default for the N: entries and that can
> > cause whitespace style commit authors to be cc'd on various changes
> > to matched files.
> 
> Is that by design?

yes.

> Or can we fix get_maintainer.pl to be less
> sensitive to whitespace authorship?

Use get_maintainer.pl's --nogit-fallback option


