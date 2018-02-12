Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeBLWue (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:50:34 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37603 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933119AbeBLWsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:51 -0500
Date: Mon, 12 Feb 2018 23:48:39 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the nand tree
Message-ID: <20180212234839.7097af7e@bbrezillon>
In-Reply-To: <20180213093153.0958cff1@canb.auug.org.au>
References: <20180213093153.0958cff1@canb.auug.org.au>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018 09:31:53 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Boris,
> 
> A whole series of commits
> 
>   558783726c98 ("mtd: nand: mxc: reorder functions to avoid forward declarations")
> to
>   e385e291129e ("mtd: nand: mxc: remove now unused code")
> 
> are missing a Signed-off-by from their committer.
> 

Should be fixed now. Thanks for this report. Time for me to add an
applypatch-msg hook :-).

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
