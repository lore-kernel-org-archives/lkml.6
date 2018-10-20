Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228A4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5A321530
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSv+LeiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5A321530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeJTWCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeJTWCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:02:41 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB19204FD;
        Sat, 20 Oct 2018 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540043528;
        bh=gQUxrTZv46hY16njzWWYSgXVvhCt2PZTFwH8lxCVwn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSv+LeiMml2rXmwdH6XNPZ8AH6JJNM+Lkbs6EyUE62HzhcpUFp8X2L9cQ9uznzSBt
         0nO++4VbhDBoRHNNinA9eKaT6veXL8Q9iCy+OYBAvfuXtcGCnyhjM9LrIABiJ6ERdv
         e9Qgj3tGOstFrmwoxvXuwXVjlrpKClTUl+6IbDxM=
Date:   Sat, 20 Oct 2018 15:51:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: [PATCH 6/7] Code of Conduct: Change the contact email address
Message-ID: <20181020135118.GG32218@kroah.com>
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

The contact point for the kernel's Code of Conduct should now be the
Code of Conduct Committee, not the full TAB.  Change the email address
in the file to properly reflect this.

Acked-by: Chris Mason <clm@fb.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/code-of-conduct.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index 3046664c929e..be50294aebd5 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -65,12 +65,13 @@ Enforcement
 ===========
 
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
-reported by contacting the Technical Advisory Board (TAB) at
-<tab@lists.linux-foundation.org>. All complaints will be reviewed and
-investigated and will result in a response that is deemed necessary and
-appropriate to the circumstances. The TAB is obligated to maintain
-confidentiality with regard to the reporter of an incident.  Further details of
-specific enforcement policies may be posted separately.
+reported by contacting the Code of Conduct Committee at
+<conduct@kernel.org>. All complaints will be reviewed and investigated
+and will result in a response that is deemed necessary and appropriate
+to the circumstances. The Code of Conduct Committee is obligated to
+maintain confidentiality with regard to the reporter of an incident.
+Further details of specific enforcement policies may be posted
+separately.
 
 Attribution
 ===========
-- 
2.19.1

