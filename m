Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938084AbeE1MmO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938911AbeE1Mly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:41:54 -0400
Date: Mon, 28 May 2018 14:41:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 286/496] macsec: missing dev_put() on error in
 macsec_newlink()
Message-ID: <20180528124133.GB19525@kroah.com>
References: <20180528100319.498712256@linuxfoundation.org>
 <20180528100331.887783491@linuxfoundation.org>
 <20180528121644.4wftwxql43eoug5h@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528121644.4wftwxql43eoug5h@mwanda>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 03:16:45PM +0300, Dan Carpenter wrote:
> Hi Greg,
> 
> I'm sorryt.  This one was buggy.  We did a revert of it in commit
> bd28899dd34f ("Revert "macsec: missing dev_put() on error in
> macsec_newlink()"").
> 
> You have queued for 4.8 as well.

Not a problem, thanks for letting me know, I've dropped it from both
queues now.

greg k-h
