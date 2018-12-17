Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FD7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C2220672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeLQHhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:37:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43209 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbeLQHhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:37:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 595272072F; Mon, 17 Dec 2018 08:37:35 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 09A532039F;
        Mon, 17 Dec 2018 08:37:35 +0100 (CET)
Date:   Mon, 17 Dec 2018 08:37:35 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        netdev <netdev@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        =?UTF-8?B?R3LDqWdvcnk=?= Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>, nadavh@marvell.com,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Message-ID: <20181217083735.4c6599b3@windsurf>
In-Reply-To: <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
        <20181216.124120.731491122771817496.davem@davemloft.net>
        <CAPv3WKfz4AkODzJ+gsV=u6ve5YnZEdUhZF5+VmFPQa4mp9okUw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcin,

On Mon, 17 Dec 2018 00:25:58 +0100, Marcin Wojtas wrote:

> Thanks. Indeed, the patch is valid as a fix for current version of SW
> BM. However, because this concept is broken, I will rework it and
> submit patch/patches some time early 2019.

I know some people are working on XDP support in mvneta, and this work
also needs to change parts of the memory allocation strategy in this
driver. I'd suggest to get in touch with those folks. Antoine can give
you the contact details, I don't have them off-hand. Or perhaps they
will see this e-mail :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
