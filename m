Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888F7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CC7208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CC7208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754389AbeGJMoT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:44:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35583 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933293AbeGJMoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:44:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B05A8208C5; Tue, 10 Jul 2018 14:44:11 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7CE5E20012;
        Tue, 10 Jul 2018 14:44:01 +0200 (CEST)
Date:   Tue, 10 Jul 2018 14:44:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Message-ID: <20180710144401.64ebef79@xps13>
In-Reply-To: <1df9a5d95c44408ab42b34948f956351@SIWEX5A.sing.micron.com>
References: <1df9a5d95c44408ab42b34948f956351@SIWEX5A.sing.micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

> I encounter one question as below when I reply the email of linux-mtd, but If I reply other mail list 
> Such as scsi mail list, mmc mail list, no any problem. Do you know why? 
> 
> 
> Your mail to 'linux-mtd' with the subject
> 
>     Re: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
> 
> Is being held until the list moderator can review it for approval.
> 
> The reason it is being held:
> 
>     Message has a suspicious header

Linus recently reported to a contributor that one of his patches got
marked as SPAM by the kernel ML because it failed the DKIM signature.
This was caused by a bad handling somewhere of the 'To:' field that
ended-up being empty. While this is an arguable handling from mailman,
it might be related to your problems.

Otherwise you could share the headers, but as this message passed
through the mailing list filter, I suspect it's not a severe issue.

Thanks,
Miquèl
