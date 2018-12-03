Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEB2C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA4C2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA4C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeLCKzi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:55:38 -0500
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:51019 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKzi (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Mon, 3 Dec 2018 05:55:38 -0500
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 03 Dec 2018 03:55:05 -0700
Message-Id: <5C050B87020000780020222E@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Mon, 03 Dec 2018 03:55:03 -0700
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Marek Marczykowski" <marmarek@invisiblethingslab.com>
Cc:     "Dwayne Litzenberger" <dlitz@dlitz.net>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 1/2] xen-pciback: Fix error return in
 bar_write() and rom_write()
References: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com><cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
 <f5ea0f3c2e29a96b59e409e4ae4c62de11a05fc8.1543772656.git-series.marmarek@invisiblethingslab.com>
In-Reply-To: <f5ea0f3c2e29a96b59e409e4ae4c62de11a05fc8.1543772656.git-series.marmarek@invisiblethingslab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 02.12.18 at 18:47, <marmarek@invisiblethingslab.com> wrote:
> From: Dwayne Litzenberger <dlitz@dlitz.net>
> 
> Signed-off-by: Dwayne Litzenberger <dlitz@dlitz.net>

At least in the kernel world I think your own SOB is expected here.

Also the description would better be non-empty, explaining under
what conditions failure was observed (and wrongly ignored), or
whether instead the change is solely "just in case".

Some stylistic adjustments would also seem on order, but since
I'm not entirely certain about the kernel policy in this regard I'll
omit respective remarks.

Jan


