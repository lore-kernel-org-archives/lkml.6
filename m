Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LsPrFbpmHlvTFQAAmS7hNA
	; Mon, 11 Jun 2018 12:10:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4CC5260792; Mon, 11 Jun 2018 12:10:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CF8CC60791;
	Mon, 11 Jun 2018 12:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF8CC60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeFKMKc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:10:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:43085 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932658AbeFKMKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:10:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22537AC50;
        Mon, 11 Jun 2018 12:10:30 +0000 (UTC)
Date: Mon, 11 Jun 2018 14:10:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Corentin Chary <corentin.chary@gmail.com>
cc: linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net
Subject: [PATCH] MAINTAINERS: Acpi4asus-user is moderated for
 non-subscribers
Message-ID: <nycvar.YFH.7.76.1806111409240.6203@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make that clear in the MAINTAINERS file.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c7069037a15..a297a2bf8100 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2286,7 +2286,7 @@ F:	drivers/hwmon/asc7621.c
 
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
-L:	acpi4asus-user@lists.sourceforge.net
+L:	acpi4asus-user@lists.sourceforge.net (moderated for non-subscribers)
 L:	platform-driver-x86@vger.kernel.org
 W:	http://acpi4asus.sf.net
 S:	Maintained

-- 
Jiri Kosina
SUSE Labs
