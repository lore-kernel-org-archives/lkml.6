Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6880FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1E92087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfAaFqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:46:25 -0500
Received: from ozlabs.org ([203.11.71.1]:57395 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfAaFqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:46:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qq3f4Spmz9sDX;
        Thu, 31 Jan 2019 16:46:22 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org,
        Balbir Singh <bsingharora@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 0/4] powerpc/livepatch: reliable stack unwinder fixes
In-Reply-To: <nycvar.YFH.7.76.1901301427320.6626@cbobk.fhfr.pm>
References: <20190122155724.27557-1-joe.lawrence@redhat.com> <nycvar.YFH.7.76.1901300049470.6626@cbobk.fhfr.pm> <87y372pc75.fsf@concordia.ellerman.id.au> <nycvar.YFH.7.76.1901301427320.6626@cbobk.fhfr.pm>
Date:   Thu, 31 Jan 2019 16:46:22 +1100
Message-ID: <87womlnzv5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jikos@kernel.org> writes:

> On Wed, 30 Jan 2019, Michael Ellerman wrote:
>
>> I'm happy to take it, unless there's some reason you'd rather it go via 
>> the LP tree?
>
> As this is more about reliable stack unwinding than live patching per se 
> (which is only a user of that facility), I'd actually slightly prefer if 
> it goes via your tree.

Sure thing, I'll take it.

cheers
