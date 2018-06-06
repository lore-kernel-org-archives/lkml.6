Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="irXH15bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAE52607F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932472AbeFFJr5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:47:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33561 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932268AbeFFJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:47:56 -0400
X-ME-Proxy: <xmx:y60XW_4-GUJ08HIl0LEGrsCp-8Jxfadrcy6oC7OOP6K7U1P-LqKiMw>
X-ME-Proxy: <xmx:y60XW9bHEgfZwSufWGtp1WPDmTNQ-TzJE9UgHqGko-x_VStMibng6Q>
X-ME-Proxy: <xmx:y60XW7x2DhkdtibIuRAXsdHaRe3RHegJiUOCVq_UInGa5oNmpgdFbA>
X-ME-Proxy: <xmx:y60XW45ERHS67RtB4L6_PIX6f4scOl7RL9Hs8OuorAQW7uIFLLn6nw>
X-ME-Proxy: <xmx:y60XW6QwQC73guhBm2D34B2S-SvGD9yaKdIHtwdE6Xt8GLfCbQBUrg>
X-ME-Proxy: <xmx:y60XW6V5jREYuc9ndVuWXogbPZO7UyXAQmQ6dA49a0lPoRqVvjf5YA>
X-ME-Sender: <xms:y60XW2A5fuucF7i6RC4vqMhGs2ywj6ptCUeaCOWJcFb9_LikfeiTlg>
Date: Wed, 6 Jun 2018 11:47:32 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the staging tree with Linus' tree
Message-ID: <20180606094732.GA30903@kroah.com>
References: <20180606191205.27b1290c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606191205.27b1290c@canb.auug.org.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 07:12:05PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging tree got conflicts in:
> 
>   drivers/staging/ipx/af_ipx.c
>   drivers/staging/ipx/ipx_proc.c
> 
> between commits:
> 
>   fddda2b7b521 ("proc: introduce proc_create_seq{,_data}")
>   db5051ead64a ("net: convert datagram_poll users tp ->poll_mask")
> 
> from Linus' tree and commit:
> 
>   7a2e838d28cf ("staging: ipx: delete it from the tree")
> 
> from the staging tree.
> 
> I fixed it up (I just removed the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks, those files should just be removed.

greg k-h
