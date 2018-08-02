Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7419020C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7419020C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeHBJpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:45:41 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:64548 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeHBJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:45:41 -0400
X-IronPort-AV: E=Sophos;i="5.51,434,1526342400"; 
   d="scan'208";a="61765362"
Date:   Thu, 2 Aug 2018 08:55:43 +0100
From:   Wei Liu <wei.liu2@citrix.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Wei Liu <wei.liu2@citrix.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        "David S. Miller" <davem@davemloft.net>,
        <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] xen-netback: use true and false for boolean
 values
Message-ID: <20180802075542.qs4xbuvm66ca5xnt@citrix.com>
References: <20180802003101.GA19256@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180802003101.GA19256@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 07:31:01PM -0500, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Wei Liu <wei.liu2@citrix.com>

Thanks for the patch.
