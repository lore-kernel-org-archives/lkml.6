Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeBBSKU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:10:20 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:46065 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbeBBSKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:10:08 -0500
Date: Fri, 2 Feb 2018 10:10:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxfs: fix building with LTO
Message-ID: <20180202181007.GA13102@infradead.org>
References: <20180202154706.1624997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202154706.1624997-1-arnd@arndb.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
