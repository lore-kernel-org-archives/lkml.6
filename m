Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF13C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC83219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC83219E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeHHPmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:42:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:37106 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbeHHPmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:42:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4D5D32D0;
        Wed,  8 Aug 2018 13:23:11 +0000 (UTC)
Date:   Wed, 8 Aug 2018 07:23:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 12/13] docs: net: Fix various minor typos
Message-ID: <20180808072310.4695cea4@lwn.net>
In-Reply-To: <20180808014248.GF11191@eros>
References: <20180801050908.29970-1-me@tobin.cc>
        <20180801050908.29970-13-me@tobin.cc>
        <76cf11bc-61b3-8068-5546-79d3ff3a58e9@iogearbox.net>
        <20180808014248.GF11191@eros>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018 11:42:48 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Hi Daniel,
> 
> Thanks for doing such a careful review that you noticed this.  I'm
> working on this more ATM and I've moved the document to use double
> spaces between _all_ full stops.  Currently the document uses mostly
> single spaces but there are some sections with double space.  The
> internet tells me this is a 'style' issue not a rule.  And I've seen
> single and double spacing in tree and do not know if one is favoured.
> 
> Do you care? 

I'm not Daniel, but let me just say that, for docs in general, I'm
absolutely uninterested in patches adjusting the number of spaces after
periods.  It really doesn't matter one way or the other, and I don't think
we benefit from that kind of churn.

Thanks,

jon
