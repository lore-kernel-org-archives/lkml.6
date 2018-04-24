Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758180AbeDXNyO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:54:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758145AbeDXNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:54:10 -0400
Date: Tue, 24 Apr 2018 06:54:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: use #pragma once
Message-ID: <20180424135409.GA22709@infradead.org>
References: <20180423213534.GA9043@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423213534.GA9043@avx2>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 12:35:34AM +0300, Alexey Dobriyan wrote:
> Bring /proc into 21st century.

Please explain what this actually buys us except for being pointlessly
different from the rest of the kernel?
