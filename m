Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E49C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EA920817
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EA920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeKIUdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:33:00 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:48721 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeKIUdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:33:00 -0500
X-IronPort-AV: E=Sophos;i="5.54,483,1534809600"; 
   d="scan'208";a="70119411"
Date:   Fri, 9 Nov 2018 10:52:54 +0000
From:   Wei Liu <wei.liu2@citrix.com>
To:     Jacob Wen <jian.w.wen@oracle.com>
CC:     <netdev@vger.kernel.org>, <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen/netfront: remove unnecessary wmb
Message-ID: <20181109105254.giy4ilemhw74zg3x@zion.uk.xensource.com>
References: <20181109065359.14900-1-jian.w.wen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181109065359.14900-1-jian.w.wen@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 02:53:59PM +0800, Jacob Wen wrote:
> RING_PUSH_REQUESTS_AND_CHECK_NOTIFY is already able to make sure backend sees
> requests before req_prod is updated.
> 
> Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>

Reviewed-by: Wei Liu <wei.liu2@citrix.com>
