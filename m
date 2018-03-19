Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970556AbeCSSxv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 14:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970328AbeCSSxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:53:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524BE21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 19 Mar 2018 13:53:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI: Clean up whitespace
Message-ID: <20180319185342.GE77194@bhelgaas-glaptop.roam.corp.google.com>
References: <152098048688.43178.2089454526004328425.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152098048688.43178.2089454526004328425.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 05:35:21PM -0500, Bjorn Helgaas wrote:
> Clean up the Makefiles and some comments.  No functional change intended.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: Tidy Makefiles
>       PCI: Tidy comments

Applied to pci/misc for v4.17.
