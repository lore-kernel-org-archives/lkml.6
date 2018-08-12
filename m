Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEC8C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8058621774
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8058621774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeHLN4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:56:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60126 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeHLN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:56:44 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 5f934f0183695e43; Sun, 12 Aug 2018 13:18:59 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Tom Todd <thomas.m.a.todd@gmail.com>
Cc:     rjw@jwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: bus: Fixed a pointer coding style issue
Date:   Sun, 12 Aug 2018 13:16:53 +0200
Message-ID: <3140204.5IURiOkdET@aspire.rjw.lan>
In-Reply-To: <20180808005202.4011-1-thomas.m.a.todd@gmail.com>
References: <20180808005202.4011-1-thomas.m.a.todd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 8, 2018 2:52:02 AM CEST Tom Todd wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>
> ---
>  drivers/acpi/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 84b4a62018eb..73e43d81ec63 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -962,7 +962,7 @@ static int acpi_device_probe(struct device *dev)
>  	return 0;
>  }
>  
> -static int acpi_device_remove(struct device * dev)
> +static int acpi_device_remove(struct device *dev)
>  {
>  	struct acpi_device *acpi_dev = to_acpi_device(dev);
>  	struct acpi_driver *acpi_drv = acpi_dev->driver;
> 

Applied (with a modified changelog), thanks!

