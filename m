Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE85FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EA32083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="htFfaq9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfBEMXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:23:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48616 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfBEMXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:23:34 -0500
Received: from zn.tnic (p200300EC2BCB6B00551F5C4602011D50.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:551f:5c46:201:1d50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FD2D1EC02AE;
        Tue,  5 Feb 2019 13:23:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549369413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0MI4IyrXuwSDHYt2n4qEaRnthtdcy8LcNZuvJ2/nfjM=;
        b=htFfaq9Vgw1SXCKZsrUFE0l9Wvf+JZw+sMSkLz7aiZDwSO0zeSg+zOVcUL7FmoG78qrxgo
        fXhkMVQpR3wFFaCqiyoHmRTAWChMm6RnCBBeG9Ms+sonVId0JuIDKjZZsUG9BeqlpC+W5U
        QJR5qqRzbkKfMYLPDIhnpplVNuK9Lyc=
Date:   Tue, 5 Feb 2019 13:23:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add James Morse to the list of APEI reviewers
Message-ID: <20190205122323.GL21801@zn.tnic>
References: <20190205083836.21641-1-bp@alien8.de>
 <22141238.CtQSfXrvFH@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22141238.CtQSfXrvFH@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:08:00PM +0100, Rafael J. Wysocki wrote:
> OK, but care to resend and CC linux-acpi too?

Here you go:

---
From: Borislav Petkov <bp@suse.de>

Add James to the list of reviewers of the firmware-assisted RAS glue.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: James Morse <james.morse@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20190205083836.21641-1-bp@alien8.de
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5f8ea1e08b..a7e9263a208b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -331,6 +331,7 @@ ACPI APEI
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Len Brown <lenb@kernel.org>
 L:	linux-acpi@vger.kernel.org
+R:	James Morse <james.morse@arm.com>
 R:	Tony Luck <tony.luck@intel.com>
 R:	Borislav Petkov <bp@alien8.de>
 F:	drivers/acpi/apei/
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
