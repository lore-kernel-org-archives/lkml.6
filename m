Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703C8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3279521A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3279521A5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbeHFSaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:30:35 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:38634 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeHFSaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:30:35 -0400
X-IronPort-AV: E=Sophos;i="5.51,452,1526342400"; 
   d="scan'208";a="77238463"
Date:   Mon, 6 Aug 2018 18:20:37 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>, <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 4/4] xen/blkback: remove unused pers_gnts_lock from
 struct xen_blkif_ring
Message-ID: <20180806162037.g32ilxvvzdfnwu7i@mac>
References: <20180806113403.24728-1-jgross@suse.com>
 <20180806113403.24728-6-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180806113403.24728-6-jgross@suse.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:34:03PM +0200, Juergen Gross wrote:
> pers_gnts_lock isn't being used anywhere. Remove it.

That was likely a leftover from when the list of persistent grants was
shared between rings.

> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
