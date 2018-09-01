Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5167C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 07:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232E72083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 07:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232E72083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darmarit.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeIALoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 07:44:05 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:40095 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbeIALoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 07:44:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 8C5DD23F9F9;
        Sat,  1 Sep 2018 09:33:01 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6mg080PzcGMG; Sat,  1 Sep 2018 09:33:00 +0200 (CEST)
Received: from ryzen (dyndsl-037-138-238-035.ewe-ip-backbone.de [37.138.238.35])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 47DA023F428;
        Sat,  1 Sep 2018 09:33:00 +0200 (CEST)
Message-ID: <5a40b453e9a419c24af1e368711d504a9086c882.camel@darmarit.de>
Subject: Re: [PATCH] docs: tidy up TOCs and refs to license-rules.rst
From:   Markus Heiser <markus.heiser@darmarit.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jonas Oberg <jonas@fsfe.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date:   Sat, 01 Sep 2018 09:32:59 +0200
In-Reply-To: <20180831165015.1461bdc7@lwn.net>
References: <20180814114312.23201-1-markus.heiser@darmarit.de>
         <20180831165015.1461bdc7@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 31.08.2018, 16:50 -0600 schrieb Jonathan Corbet:
> On Tue, 14 Aug 2018 13:43:12 +0200
> Markus Heiser <markus.heiser@darmarit.de> wrote:
> 
> > The documentation and TOCs are organized in a manner of a tree. Adding a
> > TOC to
> > the root, which refers to a file which is located in a subfolder forms a
> > grid. Those TOCs are a bit confusing and thats why we get additional error
> > messages while building partial documentation::
> > 
> >   $ make SPHINXDIRS=process htmldocs
> >   ...
> >   checking consistency... Documentation/process/license-rules.rst: \
> >   WARNING: document isn't included in any toctree
> > 
> > To fix it, the *root-license-TOC* is replaced by a reference and the
> > 'license-roles.txt' is added to the Documentation/process/index.rst TOC.
> > 
> > BTW: there was an old licences remark in Documentation/process/howto.rst
> > which
> > is also updated, mentioning SPDX and pointing to the license-rules.rst
> 
> So those are two separate changes and should really have been in two
> different patches.  I guess we can let that slide just this
> once...applied.

Ah, OK .. thanks!

> I do have to wonder if the licensing rules are *really* the most
> important thing in our docs - the thing that readers should encounter
> first, before anything else.  I think I'll revisit that at another time...

OT: my patch was to fix the structural licensing mess. Feel free to change,
what you have been applied with commit #aa19a176df95

-- Markus --

