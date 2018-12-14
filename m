Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45EDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CAF206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbeLNRjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:39:15 -0500
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:51885 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726662AbeLNRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:39:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D4C1D83777F0;
        Fri, 14 Dec 2018 17:39:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: gate46_16287bca7c34e
X-Filterd-Recvd-Size: 1600
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Dec 2018 17:39:12 +0000 (UTC)
Message-ID: <8242597611424ecd79d7863552b2281d89ccae76.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add Co-Developed-by to signature tags
From:   Joe Perches <joe@perches.com>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
Date:   Fri, 14 Dec 2018 09:39:10 -0800
In-Reply-To: <20181214172843.GA18703@himanshu-Vostro-3559>
References: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
         <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
         <20181214161604.GA17456@himanshu-Vostro-3559>
         <8ae5c67a5c4516a783579e449313d1d59fe3a47d.camel@perches.com>
         <20181214172843.GA18703@himanshu-Vostro-3559>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 22:58 +0530, Himanshu Jha wrote:
> On Fri, Dec 14, 2018 at 08:27:33AM -0800, Joe Perches wrote:
> > Is it really important to specify things like 75% / 25%
> > authorship crediting?
> 
> IDK how that ratio came up into this discussion ?

How does one tell when a co-developed-by: person
should be notated or blamed for a defective commit?

git blame shows only 1 author.



