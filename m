Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF89ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B92204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYsY8kB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B92204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJTWCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeJTWCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:02:36 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3AC42152F;
        Sat, 20 Oct 2018 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540043523;
        bh=G5dvQ5ToyfK+0a6scxCB3REUxkxrOwh/U7I3XktBiC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYsY8kB7bttqTYDCmUFqWSYDh/FJ93eVGmP8dS2/OKhFNi1WFDW6RHjOF7M2AGoYw
         BSBb0fUXPztw1gn90etRGA3qX36tpVc6fSefPBq+VDnRsgJhGGOL/+NtkzSyRu8roF
         0hTkZGzlwjMFAysbBJ4PcxnPQaNFilOSj09/yDl0=
Date:   Sat, 20 Oct 2018 15:50:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: [PATCH 4/7] Code of Conduct: Provide links between the two documents
Message-ID: <20181020135043.GE32218@kroah.com>
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

Create a link between the Code of Conduct and the Code of Conduct
Interpretation so that people can see that they are related.

Acked-by: Chris Mason <clm@fb.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/code-of-conduct-interpretation.rst | 4 +++-
 Documentation/process/code-of-conduct.rst                | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
index ecf84cd29735..4d4e2cc94b5e 100644
--- a/Documentation/process/code-of-conduct-interpretation.rst
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -1,7 +1,9 @@
+.. _code_of_conduct_interpretation:
+
 Linux Kernel Contributor Covenant Code of Conduct Interpretation
 ================================================================
 
-The Contributor Covenant Code of Conduct is a general document meant to
+The :ref:`code_of_conduct` is a general document meant to
 provide a set of rules for almost any open source community.  Every
 open-source community is unique and the Linux kernel is no exception.
 Because of this, this document describes how we in the Linux kernel
diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index a2641c19cf26..3046664c929e 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -1,3 +1,5 @@
+.. _code_of_conduct:
+
 Contributor Covenant Code of Conduct
 ++++++++++++++++++++++++++++++++++++
 
@@ -75,3 +77,9 @@ Attribution
 
 This Code of Conduct is adapted from the Contributor Covenant, version 1.4,
 available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
+
+Interpretation
+==============
+
+See the :ref:`code_of_conduct_interpretation` document for how the Linux
+kernel community will be interpreting this document.
-- 
2.19.1

