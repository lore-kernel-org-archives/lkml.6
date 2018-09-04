Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9EFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112DF20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112DF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeIDRQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:16:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727075AbeIDRQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:16:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91653AFCE;
        Tue,  4 Sep 2018 12:51:54 +0000 (UTC)
Date:   Tue, 4 Sep 2018 14:51:52 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: linux-next: manual merge of the dmi tree with Linus' tree
Message-ID: <20180904145152.5dae4343@endymion>
In-Reply-To: <20180904091950.2e49b1a5@canb.auug.org.au>
References: <20180904091950.2e49b1a5@canb.auug.org.au>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 4 Sep 2018 09:19:50 +1000, Stephen Rothwell wrote:
> Today's linux-next merge of the dmi tree got a conflict in:
> 
>   drivers/acpi/bus.c
> 
> between commit:
> 
>   ae976358cd7b ("Revert "ACPI / bus: Parse tables as term_list for Dell XPS 9570 and Precision M5530"")
> 
> from Linus' tree and commit:
> 
>   767b174cad46 ("ACPI / bus: Only call dmi_check_system on X86")
> 
> from the dmi tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for the heads up. I have rebased my dmi tree on top of 4.19-rc2,
and this solves the conflict.

-- 
Jean Delvare
SUSE L3 Support
