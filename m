Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76932C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370402082C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfA3X4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:56:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61865 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA3X4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:56:42 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 628b1ba5fb41bf5f; Thu, 31 Jan 2019 00:56:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Lee Jones <lee.jones@linaro.org>, Sinan Kaya <okaya@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [for next][PATCH 1/2] mfd: Fix unmet dependency warning for MFD_TPS68470
Date:   Thu, 31 Jan 2019 00:55:33 +0100
Message-ID: <2030742.Xi8Ns1LLnS@aspire.rjw.lan>
In-Reply-To: <20190128072156.GE4678@dell>
References: <20190121231958.28255-1-okaya@kernel.org> <f4bc6037-7c0f-f053-a150-8ae6f683b1bc@kernel.org> <20190128072156.GE4678@dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 28, 2019 8:21:56 AM CET Lee Jones wrote:
> On Thu, 24 Jan 2019, Sinan Kaya wrote:
> 
> > On 1/24/2019 5:51 AM, Rafael J. Wysocki wrote:
> > > Is anyone taking this or should I?
> > 
> > Nobody replied to this yet. I was hoping this series to go through acpi
> > tree like the rest of the other fixes.
> 
> [post-vacation reply]
> 
> That's not how these things are usually handled, but I taking into
> consideration the trivialises of the patch, I don't really mind.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

I've applied this one, thanks!

