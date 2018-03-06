Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeCFI2z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:28:55 -0500
Received: from verein.lst.de ([213.95.11.211]:51618 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeCFI2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:28:54 -0500
Date: Tue, 6 Mar 2018 09:28:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] kernel/memremap: Remove stale devres_free() call
Message-ID: <20180306082853.GA19496@lst.de>
References: <20180306045647.7784-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306045647.7784-1-oohall@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
