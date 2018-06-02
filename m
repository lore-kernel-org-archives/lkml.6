Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeFBNTX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 09:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbeFBNTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 09:19:21 -0400
Date: Sat, 2 Jun 2018 15:18:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:TPM DEVICE DRIVER"
        <tpmdd-devel@lists.sourceforge.net>
Subject: Re: [PATCH v2 0/2] fixes for v4.4
Message-ID: <20180602131858.GF31493@kroah.com>
References: <20180530204440.27299-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530204440.27299-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:44:38PM +0300, Jarkko Sakkinen wrote:
> Decided to add Enric's commit because it is also a bug fix instead
> of modifying Chris commit.

Why just 4.4 and not also 4.9?  I don't want to take patches that would
cause a regression for people moving from 4.4 to 4.9, so can you also
provide 4.9 backports of this?  If so, I will be glad to queue up both
sets of patches.

thanks,

greg k-h
