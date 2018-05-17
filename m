Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeEQIOU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:14:20 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38990 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeEQIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:14:16 -0400
X-Google-Smtp-Source: AB8JxZqZ/Oygn8gxBJV2m46h4CyAG1NKux6SHy6/tVujzlojCEntKLWXy0wzjrE/NWaQ2oAOVWLaMw==
Date: Thu, 17 May 2018 10:14:12 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        linux-next <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: reorder paes test lexicographically
Message-ID: <20180517081412.GA1801@Red>
References: <1526025847-13134-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526025847-13134-1-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 09:04:06AM +0100, Gilad Ben-Yossef wrote:
> Due to a snafu "paes" testmgr tests were not ordered
> lexicographically, which led to boot time warnings.
> Reorder the tests as needed.
> 
> Fixes: a794d8d ("crypto: ccree - enable support for hardware keys")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
