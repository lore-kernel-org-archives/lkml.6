Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2666CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF5F20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF5F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeGaRWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:22:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54164 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbeGaRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:22:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED249C22;
        Tue, 31 Jul 2018 15:41:43 +0000 (UTC)
Date:   Tue, 31 Jul 2018 17:41:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     bp@alien8.de, prarit@redhat.com, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Don't duplicate code to update ucode cpu
 info and cpu info
Message-ID: <20180731154140.GA15243@kroah.com>
References: <1533050970-14385-1-git-send-email-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533050970-14385-1-git-send-email-sironi@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 05:29:30PM +0200, Filippo Sironi wrote:
> ... on late microcode loading when handling a CPU that's already been
> updated and a CPU that's yet to be updated.
> 
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c   | 15 +++++++++------
>  arch/x86/kernel/cpu/microcode/intel.c | 10 ++++++----
>  2 files changed, 15 insertions(+), 10 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
