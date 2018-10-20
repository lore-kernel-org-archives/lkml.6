Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA1CC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045752152D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o33NwQpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045752152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJTWCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeJTWCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:02:39 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342E0214C3;
        Sat, 20 Oct 2018 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540043525;
        bh=jMUxcMPyIzHtPdbPVBDdktm1VRnlBR/nWRuZb8/IzFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o33NwQpXXgwzDvFanRai0J9e4MojQKtP6iS9slf7Nsmhd4/9LBOBO+VSAQuyNk6b5
         bROzipvgZXh5wozfxerQ+XGLrOHtpVykXf6dTIg5k7Uv9qxuMIrntpxwP42zz8e2uk
         7yctsUEkCKZ+zM54Azfn3viLtVd+dz5HKCTbZvvM=
Date:   Sat, 20 Oct 2018 15:50:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: [PATCH 5/7] Code of Conduct Interpretation: Put in the proper URL
 for the committee
Message-ID: <20181020135058.GF32218@kroah.com>
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

There was a blank <URL> reference for how to find the Code of Conduct
Committee.  Fix that up by pointing it to the correct kernel.org website
page location.

Acked-by: Chris Mason <clm@fb.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/code-of-conduct-interpretation.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
index 4d4e2cc94b5e..e899f14a4ba2 100644
--- a/Documentation/process/code-of-conduct-interpretation.rst
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -123,8 +123,9 @@ Enforcement
 
 The address listed in the Code of Conduct goes to the Code of Conduct
 Committee.  The exact members receiving these emails at any given time
-are listed at <URL>.  Members can not access reports made before they
-joined or after they have left the committee.
+are listed at https://kernel.org/code-of-conduct.html.  Members can not
+access reports made before they joined or after they have left the
+committee.
 
 The initial Code of Conduct Committee consists of volunteer members of
 the TAB, as well as a professional mediator acting as a neutral third
-- 
2.19.1

