Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C0EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A1021736
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeLZDYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:24:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbeLZDYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:24:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8837837E74;
        Wed, 26 Dec 2018 03:24:42 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-157.pek2.redhat.com [10.72.12.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 227F8608C8;
        Wed, 26 Dec 2018 03:24:37 +0000 (UTC)
Date:   Wed, 26 Dec 2018 11:24:33 +0800
From:   Dave Young <dyoung@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, bhe@redhat.com,
        linux-doc@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
Message-ID: <20181226032433.GB13556@dhcp-128-65.nay.redhat.com>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com>
 <20181217130024.GD12165@zn.tnic>
 <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826c1a6b-41da-bc1a-f9c2-0d52e774b572@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 26 Dec 2018 03:24:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +
> >> +KERNEL_IMAGE_SIZE
> >> +=================
> >> +The size of 'KERNEL_IMAGE_SIZE', currently unused.
> > 
> > So remove?
> > 
> 
> I'm not sure whether it should be removed, so i keep it.

Just remove it.  It was added by Baoquan for KASLR issues, later
makedumpfile reverted the userspace part and added other implementation.

In case old makedumpfile does not support new kernel, it has some kernel
versions support list in code, thus no worry about the compatibility
issue.

Thanks
Dave
