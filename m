Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95573C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D882086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="KsVc6q5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfBTWqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:46:51 -0500
Received: from mx.kolabnow.com ([95.128.36.41]:8640 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfBTWqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:46:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 918E1398E;
        Wed, 20 Feb 2019 23:46:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1550702807; x=1552517208; bh=BT14RPWUUCvsr+25bL6
        6MvXX3meb4PexJ4ucdFkRJvw=; b=KsVc6q5a2aBAsTeNixj02lmkYJYRjo6t/MQ
        R1wEavmkuUHzI65zsDvfsu02QOyYvuLimhNThHYDgygJp3k7Ot7yHUE407zUX+Nn
        zWe0FkQY2nlWa+QO3cxLbBcRxqkbcQVkxjWYxrhzhDdCF24LXOLqfbo4ntofXvig
        pPRM9R2RF+IGr6wF4gIUlA1+x7SOkfTeKiFnpsHvdMwdNbEVQ30oZN0mYIK6FlYH
        Ia1qX3vw4eCfqVGxHv4ogpbiS5qHOUJhK0wDdQC8ZXTKAo5bQUZItuUyDSSZbnz0
        JiJ73dS4EyPy1O+eOE8uAdNdbx9DNC8Fru3yBkrFJ/VoEBdRE53b88su96/bZpRl
        GNuLn6na3/WfXyacjlCW6xiesFnJdPpEPK1A4ekkwQlBz0I656L6fUSYmBTLjgaT
        v2PcFkimyye238sxcxPmgXOiZcStopu9yAiAJRm/Z0z7xdRLacyLFsS7LNFUdTuT
        mWjbK7eG2nw8ITSxtbT2xmoqhs70Az1XJyXIHpk+Zelj0RPwkTdh9H84AyWNO7gv
        PEyEC9Kr3SGy3NWEdjfK7/jnq+w+YWqx2LRscQikd3KkW4CYBgFjGOxkpCu0aRvU
        EdUUye4ylOVTuEl/XxDHZ96PdF28SmZt/QhfsCL4s10MOlmxnR1ZVY8exG2Kf5Vj
        EJtgLTiI=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hHhqJzoPgOsa; Wed, 20 Feb 2019 23:46:47 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 183D5DE4;
        Wed, 20 Feb 2019 23:46:47 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 957B0226;
        Wed, 20 Feb 2019 23:46:46 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Markus Heiser <markus.heiser@darmarit.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc: fix typos in license-rules.rst
Date:   Wed, 20 Feb 2019 23:46:09 +0100
Message-Id: <20190220224609.17721-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches fixes some typos in process/license-rules.rst

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/process/license-rules.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index 2bb8c0fc2238..d9798d61fe64 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -62,7 +62,7 @@ License identifier syntax
 
    The SPDX license identifier in kernel files shall be added at the first
    possible line in a file which can contain a comment.  For the majority
-   or files this is the first line, except for scripts which require the
+   of files this is the first line, except for scripts which require the
    '#!PATH_TO_INTERPRETER' in the first line.  For those scripts the SPDX
    identifier goes into the second line.
 
@@ -368,7 +368,7 @@ kernel, can be broken down into:
 
 
 All SPDX license identifiers and exceptions must have a corresponding file
-in the LICENSE subdirectories. This is required to allow tool
+in the LICENSES subdirectories. This is required to allow tool
 verification (e.g. checkpatch.pl) and to have the licenses ready to read
 and extract right from the source, which is recommended by various FOSS
 organizations, e.g. the `FSFE REUSE initiative <https://reuse.software/>`_.
-- 
2.20.1

