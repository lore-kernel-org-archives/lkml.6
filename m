Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeE3QrH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753663AbeE3QrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:47:06 -0400
Date: Wed, 30 May 2018 11:47:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Trivial quirks cleanup
Message-ID: <20180530164705.GI39853@bhelgaas-glaptop.roam.corp.google.com>
References: <152599011048.234504.9006188618412032582.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152599011048.234504.9006188618412032582.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 05:09:06PM -0500, Bjorn Helgaas wrote:
> [Sorry for the repost; network hiccup here.]
> 
> Trivial reorganization (move quirk infrastructure to the top) and
> whitespace/comment style cleanup for consistency.  No functional change
> intended.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: Reorder quirks infrastructure code
>       PCI: Clean up whitespace in quirks.c
> 
> 
>  drivers/pci/quirks.c |  978 +++++++++++++++++++++++++-------------------------
>  1 file changed, 485 insertions(+), 493 deletions(-)

I applied these to pci/trivial for v4.18.
