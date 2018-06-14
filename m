Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 01A35C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA29320020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pawi1ed8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA29320020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965809AbeFNOXx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:23:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755246AbeFNOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d+s7IYeTqsyU5dsNkJ7X3WfQBu/Gj+oeikES7r7tPMM=; b=Pawi1ed8LBXWw6cNe7uTDYf2c
        GbrlAX7MYds8mpjBKvx/cZrKrgvIwUhqoSGEbg/2CEajgdf7lvlIU31DVre7WT7ahIm1oCGM60eu0
        pmEuOh8ACX2JbAavVC15kCtjyUOPc/bMiwns0ZO47izywptXAW5KJ4eM0Ri8O6xNeVQef6a2qubiB
        N+xmfpM4S5A1x1PniW3Wl30a5Cfgklo9GuJrouNqyWeWvfkkF30pyIVUHBHMwSJlhwYY71vei++Gs
        N5fBp65FtE5OOZoV1XQskQApoig7F610Jfs7ywuDgsaCuWgUavkq48u0NefyjyU4gnB1T/3cW6EP0
        +haOGcopw==;
Received: from 177.41.114.220.dynamic.adsl.gvt.net.br ([177.41.114.220] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTTAC-0003Hs-Kf; Thu, 14 Jun 2018 14:23:49 +0000
Date:   Thu, 14 Jun 2018 11:23:43 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 09/11] docs: Fix some broken references
Message-ID: <20180614112343.61bb84d7@coco.lan>
In-Reply-To: <Pine.LNX.4.44L0.1805091509100.1391-100000@iolanthe.rowland.org>
References: <20180509152045.722f0c51@vento.lan>
        <Pine.LNX.4.44L0.1805091509100.1391-100000@iolanthe.rowland.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 9 May 2018 15:11:07 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> escreveu:

> On Wed, 9 May 2018, Mauro Carvalho Chehab wrote:
> 
> > Em Wed, 9 May 2018 19:15:01 +0200
> > Andrea Parri <parri.andrea@gmail.com> escreveu:  
> 
> > > >  tools/memory-model/README                     | 10 +++++-----    
> > > 
> > > As mentioned in the previous thread, I am for keeping the current
> > > references: the REAMDE is listing the doc files, as well as other
> > > files in tools/memory-model/, relatively to that directory.  
> > 
> > Yeah, at least this hunk deserves some rework, as now some
> > references are Documentation/.../foo, while others are just
> > bar.
> > 
> > As on (almost) all other places (except for tools/memory-model/README),
> > the references are always from the main directory, I would make all
> > patches there also relative to main dir. If you're afraid of
> > not being too clearer, we could prefix all of them with something
> > like:
> > 
> > 	${LINUX}/tools/memory-model/...
> > 
> > just like some DT binding files do:
> > 
> > 	Documentation/devicetree/bindings/sound/audio-graph-card.txt:see ${LINUX}/Documentation/devicetree/bindings/graph.txt
> > 
> > A bonus of doing that is that the broken reference detect script can
> > keep parsing it without changes (well, it wouldn't be hard to make
> > it also accept a relative file, but doing that just due to 
> > tools/memory-model/README seems overkill).
> > 
> > Another advantage is that it would allow to easily add references
> > there from the main kernel Documentation, if needed in the future,
> > without messing with local x non-local relative namespace.  
> 
> How about changing the relative references so that something like
> Documentation/recipes.txt becomes ./Documentation/recipes.txt?

Thanks,
Mauro

After thinking a little bit about that, it should be easy to fix the
tool to consider references relative to tools/.*/Documentation.

I intend to send a new patch series with the changes to 
tools/memory-model/README removed from this patch and with the enclosed
patch on it.

Regards,
Mauro

[PATCH] scripts/documentation-file-ref-check: check
 tools/*/Documentation

Some files, like tools/memory-model/README has references to
a Documentation file that is locale to it. Handle references
that are relative to them too.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index 047f463cdf4b..078999a3fdff 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -78,6 +78,13 @@ while (<IN>) {
 		# Check if exists, evaluating wildcards
 		next if (grep -e, glob("$ref $fulref"));
 
+		# Accept relative Documentation patches for tools/
+		if ($f =~ m/tools/) {
+			my $path = $f;
+			$path =~ s,(.*)/.*,$1,;
+			next if (grep -e, glob("$path/$ref $path/$fulref"));
+		}
+
 		if ($fix) {
 			if (!($ref =~ m/(scripts|Kconfig|Kbuild)/)) {
 				$broken_ref{$ref}++;
