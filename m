Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA933C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A4121774
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A4121774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeHLN6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:58:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57358 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeHLN6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:58:53 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id d5510979cabb2430; Sun, 12 Aug 2018 13:21:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     David Archuleta <darchuletajr@gmail.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: processor_throttling: fixed a few brace coding style issues.
Date:   Sun, 12 Aug 2018 13:19:02 +0200
Message-ID: <2258817.rCk9hs2z3C@aspire.rjw.lan>
In-Reply-To: <20180726202341.9816-1-darchuletajr@gmail.com>
References: <20180726202341.9816-1-darchuletajr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 26, 2018 10:23:41 PM CEST David Archuleta wrote:
> From: darchuletajr <darchuletajr@gmail.com>
> 
> Fixed a few brace coding style issues found by running
> ./scripts/checkpatch
> 
> Signed-off-by: David Archuleta Jr. <darchuletajr@gmail.com>

IMO this doesn't add any value to the code, so I'm not going to apply it.

> ---
>  drivers/acpi/processor_throttling.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index fbc936cf2025..75cc179b352b 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -298,9 +298,8 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
>  
>  	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
>  	if (ACPI_FAILURE(status)) {
> -		if (status != AE_NOT_FOUND) {
> +		if (status != AE_NOT_FOUND)
>  			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
> -		}
>  		return -ENODEV;
>  	}
>  
> @@ -431,9 +430,8 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
>  
>  	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
>  	if (ACPI_FAILURE(status)) {
> -		if (status != AE_NOT_FOUND) {
> +		if (status != AE_NOT_FOUND)
>  			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PTC"));
> -		}
>  		return -ENODEV;
>  	}
>  
> @@ -516,9 +514,8 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
>  
>  	status = acpi_evaluate_object(pr->handle, "_TSS", NULL, &buffer);
>  	if (ACPI_FAILURE(status)) {
> -		if (status != AE_NOT_FOUND) {
> +		if (status != AE_NOT_FOUND)
>  			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSS"));
> -		}
>  		return -ENODEV;
>  	}
>  
> @@ -596,9 +593,8 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
>  
>  	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
>  	if (ACPI_FAILURE(status)) {
> -		if (status != AE_NOT_FOUND) {
> +		if (status != AE_NOT_FOUND)
>  			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSD"));
> -		}
>  		return -ENODEV;
>  	}
>  
> 


