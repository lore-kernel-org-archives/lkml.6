Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA40ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1021531
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGir46BY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A1021531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJTWCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeJTWCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:02:34 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AD8421530;
        Sat, 20 Oct 2018 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540043520;
        bh=afu4MZ/C5g5tu+kpemQoAwiHudy7NvlJ0Tl8QX8WW0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGir46BYF/6kOqPCmm3+KokDxHwNLPxWOV0yJ88Au3kXKC/QuNdW9O4BcxHxtz+9u
         VyBLNpSvN5sysOlf8mijq3QNAAPFE67wNUyOsKCb0cXNGdsN0C0tL5o2HnQGGvQzbB
         17xW0LAzM5uE2l7aMzujBJgTa8GInxw5ullHMjTE=
Date:   Sat, 20 Oct 2018 15:50:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: [PATCH 3/7] Code of Conduct Interpretation: Properly reference the
 TAB correctly
Message-ID: <20181020135021.GD32218@kroah.com>
References: <20181020134908.GA32218@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020134908.GA32218@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use the term "TAB" before defining it later in the document.  Fix
that up by defining it at the first location.

Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Chris Mason <clm@fb.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../process/code-of-conduct-interpretation.rst   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
index b14441711f7b..ecf84cd29735 100644
--- a/Documentation/process/code-of-conduct-interpretation.rst
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -45,11 +45,11 @@ regarding conduct issues.
 
 Maintainers should be willing to help when problems occur, and work with
 others in the community when needed.  Do not be afraid to reach out to
-the TAB or other maintainers if you're uncertain how to handle
-situations that come up.  It will not be considered a violation report
-unless you want it to be.  If you are uncertain about approaching the
-TAB or any other maintainers, please reach out to our conflict mediator,
-Mishi Choudhary <mishi@linux.com>.
+the Technical Advisory Board (TAB) or other maintainers if you're
+uncertain how to handle situations that come up.  It will not be
+considered a violation report unless you want it to be.  If you are
+uncertain about approaching the TAB or any other maintainers, please
+reach out to our conflict mediator, Mishi Choudhary <mishi@linux.com>.
 
 In the end, "be kind to each other" is really what the end goal is for
 everybody.  We know everyone is human and we all fail at times, but the
@@ -125,9 +125,9 @@ are listed at <URL>.  Members can not access reports made before they
 joined or after they have left the committee.
 
 The initial Code of Conduct Committee consists of volunteer members of
-the Technical Advisory Board (TAB), as well as a professional mediator
-acting as a neutral third party.  The first task of the committee is to
-establish documented processes, which will be made public.
+the TAB, as well as a professional mediator acting as a neutral third
+party.  The first task of the committee is to establish documented
+processes, which will be made public.
 
 Any member of the committee, including the mediator, can be contacted
 directly if a reporter does not wish to include the full committee in a
-- 
2.19.1

