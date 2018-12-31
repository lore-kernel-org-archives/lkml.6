Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE1DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0087B2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeLaTMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:12:24 -0500
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:50740 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727367AbeLaTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:12:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9790B100E86C1;
        Mon, 31 Dec 2018 19:12:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spade09_4e8ff7f567408
X-Filterd-Recvd-Size: 1943
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 31 Dec 2018 19:12:19 +0000 (UTC)
Message-ID: <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
Subject: Re: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
From:   Joe Perches <joe@perches.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Mon, 31 Dec 2018 11:12:18 -0800
In-Reply-To: <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
         <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-01 at 00:25 +0530, Manivannan Sadhasivam wrote:
> Add the linux-actions mailing list for Actions Semi SoC architecture.

Unrelated to adding this L: entry

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
>  M:	Andreas Färber <afaerber@suse.de>
>  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  N:	owl

The N: entry matches too many non-owl entries like:

Documentation/parport-lowlevel.txt
drivers/misc/ibmasm/lowlevel.c
drivers/misc/ibmasm/lowlevel.h
fs/udf/lowle
vel.c
net/ipv6/ip6_flowlabel.c
sound/soc/samsung/lowland.c

Maybe there should be two entries

N:	/owl
N:	-owl


