Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeEBMjd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:39:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeEBMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:39:27 -0400
Date: Wed, 2 May 2018 05:39:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/10] PCI: Deprecate
 of_pci_get_host_bridge_resources()
Message-ID: <20180502123923.GA10783@infradead.org>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <aca0d89cd8c1551a83b87ffab29fcd6e1d59a61c.1525067324.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca0d89cd8c1551a83b87ffab29fcd6e1d59a61c.1525067324.git.jan.kiszka@siemens.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 07:48:42AM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> There are no in-tree users remaining, all are converted to the managed
> variant. And it is unlikely that any out-of-tree user got the resource
> management right as well. So deprecate the interface and push users to
> the managed version instead.
> 
> To avoid raising a warning when exporting a deprecated symbol, wrap the
> API with an inline and export an internal name.

Don't deprecated it, just remove it.
