Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E7AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32FA2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549648051;
	bh=Ns0tZd6nUG6qgOrC9SKATuDtr+8z5jEZ6t4Q4cUP2Gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=V1F25VvuzPnGPlKnj++om66/EfxaZJEpl3UOaz1Acb3Elf4f8gBQDJ/C6xQDht59J
	 eDSHyBzJjtscJhAPsYPSqaBqy2PMGtWvfqb881oPsuGa6Jo/2BzV6WAabq/h47ZM9L
	 nlufScOuBz+sAUxTTeXqaE4aci6Iipl6CQbXRXj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfBHRr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfBHRr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:47:29 -0500
Received: from localhost (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 523E620863;
        Fri,  8 Feb 2019 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549648048;
        bh=Ns0tZd6nUG6qgOrC9SKATuDtr+8z5jEZ6t4Q4cUP2Gs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sOivv1lK7p0qJ2edQkL6F2c2ox//xnh4kCBNV92Yx5uYpa4EFN/X5Gn4ZqydtAjwx
         GwvYbtB05Omm1wMXDCyvNOlFVDT3uDRrhJcZxpvGh95KvJ/Q51S4FmBazBLWILc135
         VHGi00v25AEU3/BzP46w2FX0xfcNzglQmbho2/BA=
Date:   Fri, 8 Feb 2019 18:47:18 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>
Subject: Re: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation
 HWCPAS
Message-ID: <20190208184718.3c488d0d@kernel.org>
In-Reply-To: <BYAPR08MB4533DB0A7F4E30543750C83FDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
        <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
        <BYAPR08MB45335415CC3690816C1FD603DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
        <a83a9655-0ce7-da15-ec17-80ef88764e21@microchip.com>
        <BYAPR08MB4533DB0A7F4E30543750C83FDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

On Fri, 8 Feb 2019 17:13:52 +0000
"Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:

> Hi, Tutor
> Thanks. unfortunately, it doesn't work on my side. Problem is on our email server side, not my local setting.
> I followed your configuration, then git-email failed.

Can you paste the output of git send-email and the [sendemail] section
of your .gitconfig so we can check.
It shouldn't fail, really, because the server shouldn't check the body
section of your email, and this is where the extra

	From: First Last <foo@bar.com>

line is placed.

> Please just change my S-o-b to 'Bean Huo (beanhuo) <beanhuo@micron.com>' in my patch to please checkpacth.pl.  It is not huge change.

It's not a problem when an drive-by contributor posts a patch, but if
you don't patch it that means we'll have to do it manually every time
we apply one of your patch, so please find a solution.

Thanks,

Boris
