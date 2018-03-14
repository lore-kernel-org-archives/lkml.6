Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeCNLWN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:22:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNLWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:22:12 -0400
Date: Wed, 14 Mar 2018 04:22:12 -0700
From: Matthew Wilcox <willy@infradead.org>
To: chenjiankang <chenjiankang1@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yisheng Xie <xieyisheng1@huawei.com>, wangkefeng.wang@huawei.com
Subject: Re: BUG: unable to handle kernel paing request at fffffc0000000000
Message-ID: <20180314112212.GB29631@bombadil.infradead.org>
References: <270af3b0-ab0f-9ee5-d5d6-3e86983b8d9b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270af3b0-ab0f-9ee5-d5d6-3e86983b8d9b@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 04:14:01PM +0800, chenjiankang wrote:
> 
> 
> hello everyone:
> 	my kernel version is 3.10.0-327.62.59.101.x86_64, and 

That kernel version appears to be an internal Huawei kernel.  It's
probably impossible for anyone outside Huawei to debug it.
