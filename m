Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKhCu2fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3467A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932397AbeFFJLN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:11:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59633 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932260AbeFFJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:11:11 -0400
X-ME-Proxy: <xmx:LqUXW-cGDHzOkqX92gQ5F5b5kg3dA7KW4_hqCmXBJuG1OgxSI0uuqQ>
X-ME-Proxy: <xmx:LqUXWxaE952FkN7dPZP5amkmK4wCxGCWXLCsN04JTvVglWniBr2JwA>
X-ME-Proxy: <xmx:LqUXW5riBHlUvXSfWb0Zzuw4tim5Efp_DD9A4bC-zKU4-kKSeDlHZA>
X-ME-Proxy: <xmx:LqUXW80qxplNJ79LW2nUyk-YhWfpPhSmwDj75j7SEyGH-YiQGaXKRQ>
X-ME-Proxy: <xmx:LqUXW2pRi6NdM1auZAVpainSqKFoQ7J5UtTfFtGEqiHktIAuFTo1Ag>
X-ME-Proxy: <xmx:LqUXW-pV1zgXX5HtRKqt-NR-GO6inWRcX3RM-Fel1Vb0mLi_oEP2vQ>
X-ME-Sender: <xms:LqUXW_kGJ80vhO7nwpROyQS1hXnkzrPAwICIk2h-3sKjJjmbOX4Srg>
Date: Wed, 6 Jun 2018 11:10:47 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: manual merge of the staging tree with Linus' tree
Message-ID: <20180606091046.GA28264@kroah.com>
References: <20180606190858.7d4c27ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606190858.7d4c27ac@canb.auug.org.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 07:08:58PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/ncpfs/dir.c
> 
> between commit:
> 
>   1c5fedbb508f ("ncp_lookup(): use d_splice_alias()")
> 
> from Linus' tree and commit:
> 
>   bd32895c750b ("staging: ncpfs: delete it")
> 
> from the staging tree.
> 
> I fixed it up (the latter removed the file, so I did that) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Thanks, I figured this would show up, not a problem, the file should be
just removed.

greg k-h
