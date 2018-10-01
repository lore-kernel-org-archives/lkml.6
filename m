Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0803C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A00D213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A00D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fifo99.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbeJAVVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:21:07 -0400
Received: from ec2-34-208-57-251.us-west-2.compute.amazonaws.com ([34.208.57.251]:49832
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729497AbeJAVVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:21:06 -0400
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id F306E4021D; Mon,  1 Oct 2018 07:42:57 -0700 (PDT)
Date:   Mon, 1 Oct 2018 07:42:57 -0700
From:   dwalker@fifo99.com
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: commits in the cisco tree
Message-ID: <20181001144257.GA13523@fifo99.com>
References: <20180930112419.6f880e46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930112419.6f880e46@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 11:24:19AM +1000, Stephen Rothwell wrote:
> Hi Daniel,
> 
> I noticed that you have added some commits to the cisco tree today.  Just a couple of comments:
> 
> Fristly, commits
> 
>   734245aec283 ("This code allows architectures to use a generic builtin command line."
> 
> and
> 
>   b17f223f16f2 ("This code allows architectures to use a generic builtin command line.")
> 
> are identical (though in different branches).
> 
> Secondly, commits
> 
>   2c070709ea75 ("his updates the x86 code to use the CONFIG_GENERIC_CMDLINE")
>   a5c4647c26da ("This updates the powerpc code to use the CONFIG_GENERIC_CMDLINE")
> 
> have no Acked-by or Reviewed-by from the repspective architecture
> maintainers/developers.

Is this just an alert , or are you not merging for these reasons ?

Daniel
