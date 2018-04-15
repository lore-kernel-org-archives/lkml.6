Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDOAlh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 20:41:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDOAlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 20:41:36 -0400
Date: Sat, 14 Apr 2018 17:41:34 -0700
From: Matthew Wilcox <willy@infradead.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: repeatable boot randomness inside KVM guest
Message-ID: <20180415004134.GB15294@bombadil.infradead.org>
References: <20180414195921.GA10437@avx2>
 <20180414224419.GA21830@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180414224419.GA21830@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 14, 2018 at 06:44:19PM -0400, Theodore Y. Ts'o wrote:
> What needs to happen is freelist should get randomized much later in
> the boot sequence.  Doing it later will require locking; I don't know
> enough about the slab/slub code to know whether the slab_mutex would
> be sufficient, or some other lock might need to be added.

Could we have the bootloader pass in some initial randomness?
