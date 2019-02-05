Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E56C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8142145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfBELJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:09:14 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62054 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBELJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:09:13 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id b5ec816de91c6f2c; Tue, 5 Feb 2019 12:09:11 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add James Morse to the list of APEI reviewers
Date:   Tue, 05 Feb 2019 12:08:00 +0100
Message-ID: <22141238.CtQSfXrvFH@aspire.rjw.lan>
In-Reply-To: <20190205083836.21641-1-bp@alien8.de>
References: <20190205083836.21641-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 5, 2019 9:38:36 AM CET Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Add James to the list of reviewers of the firmware-assisted RAS glue.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: James Morse <james.morse@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd5f8ea1e08b..a7e9263a208b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -331,6 +331,7 @@ ACPI APEI
>  M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
>  M:	Len Brown <lenb@kernel.org>
>  L:	linux-acpi@vger.kernel.org
> +R:	James Morse <james.morse@arm.com>
>  R:	Tony Luck <tony.luck@intel.com>
>  R:	Borislav Petkov <bp@alien8.de>
>  F:	drivers/acpi/apei/
> 

OK, but care to resend and CC linux-acpi too?

