Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E87ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661EE214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4/s5EYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661EE214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeJTWCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeJTWCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:02:43 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1462152D;
        Sat, 20 Oct 2018 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540043530;
        bh=2/MuNsraLM+27JDExVptCloInxn+8vKahJrq7n6JPfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4/s5EYPTsBlmEC++ZARRgt6g9tn++82gbmAImVMu7iHeFI+Yn+jOFsu/iU9m699c
         8yEecQSAWUADa+DZgJAeOYLIaDOLsrcI3wFVxO4N7pUsphPE/q/26j+PiJqLf45BU3
         5GOO1ktIpkoDS60f7dXFf0sxIcuoEiXfl8krsDTI=
Date:   Sat, 20 Oct 2018 15:51:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: [PATCH 7/7] MAINTAINERS: Add an entry for the code of conduct
Message-ID: <20181020135139.GH32218@kroah.com>
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

As I introduced these files, I'm willing to be the maintainer of them as
well.

Acked-by: Chris Mason <clm@fb.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f371d372bdd..21faaf4c6161 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3673,6 +3673,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/coda.txt
 F:	drivers/media/platform/coda/
 
+CODE OF CONDUCT
+M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+S:	Supported
+F:	Documentation/process/code-of-conduct.rst
+F:	Documentation/process/code-of-conduct-interpretation.rst
+
 COMMON CLK FRAMEWORK
 M:	Michael Turquette <mturquette@baylibre.com>
 M:	Stephen Boyd <sboyd@kernel.org>
-- 
2.19.1

