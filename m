Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75880C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31070208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31070208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeGaTcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:32:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbeGaTcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:32:04 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61F8ECC0;
        Tue, 31 Jul 2018 17:50:38 +0000 (UTC)
Date:   Tue, 31 Jul 2018 19:50:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Sironi, Filippo" <sironi@amazon.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/microcode: Don't duplicate code to update ucode cpu
 info and cpu info
Message-ID: <20180731175035.GB16667@kroah.com>
References: <1533050970-14385-1-git-send-email-sironi@amazon.de>
 <20180731154140.GA15243@kroah.com>
 <5C646084-CE58-41A5-AC57-E42D996C4212@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C646084-CE58-41A5-AC57-E42D996C4212@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 04:23:00PM +0000, Sironi, Filippo wrote:
> 
> > On 31. Jul 2018, at 17:41, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Tue, Jul 31, 2018 at 05:29:30PM +0200, Filippo Sironi wrote:
> >> ... on late microcode loading when handling a CPU that's already been
> >> updated and a CPU that's yet to be updated.
> >> 
> >> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> >> ---
> >> arch/x86/kernel/cpu/microcode/amd.c   | 15 +++++++++------
> >> arch/x86/kernel/cpu/microcode/intel.c | 10 ++++++----
> >> 2 files changed, 15 insertions(+), 10 deletions(-)
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Greg,
> 
> If you're concerned that this isn't a fix, keep in mind that this is going
> to be a prerequisite for https://lore.kernel.org/patchwork/patch/969070/ ,
> which is a bug and was sent to stable.

{sigh}  No, go read the file please...

greg k-h
