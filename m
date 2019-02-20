Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D472F2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfBTJfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:35:46 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50800 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfBTJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:35:44 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id a016dbb7175a3338; Wed, 20 Feb 2019 10:35:42 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Borislav Petkov <bp@alien8.de>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2 0/2] Fix crash in cper_estatus_check()
Date:   Wed, 20 Feb 2019 10:34:16 +0100
Message-ID: <1984226.rhZVaWBjWf@aspire.rjw.lan>
In-Reply-To: <20190219135004.GC19514@zn.tnic>
References: <20190128100424.30278-1-ross.lagerwall@citrix.com> <2534482.fmfRlZkPUo@aspire.rjw.lan> <20190219135004.GC19514@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 19, 2019 2:50:04 PM CET Borislav Petkov wrote:
> On Tue, Feb 19, 2019 at 11:00:49AM +0100, Rafael J. Wysocki wrote:
> > Boris, any comments here?
> 
> For both:
> 
> Acked-by: Borislav Petkov <bp@suse.de>

Both applied, thanks!

