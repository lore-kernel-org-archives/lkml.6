Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeDTLUN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:20:13 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:60008 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754549AbeDTLUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:20:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Apr 2018 13:20:10 +0200
From: Stefan Agner <stefan@agner.ch>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, mhocko@suse.com, catalin.marinas@arm.com,
        torvalds@linux-foundation.org, pasha.tatashin@oracle.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] treewide: use PHYS_ADDR_MAX to avoid type casting
 ULLONG_MAX
In-Reply-To: <20180420111510.GA10788@bombadil.infradead.org>
References: <20180419214204.19322-1-stefan@agner.ch>
 <20180420111510.GA10788@bombadil.infradead.org>
Message-ID: <d91c35be6f85a20028910babb35243d0@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-2.41 / 15.00];
         RCVD_TLS_ALL(0.00)[];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_HAS_DN(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-2.31)[96.81%];
         ARC_NA(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.2018 13:15, Matthew Wilcox wrote:
> On Thu, Apr 19, 2018 at 11:42:04PM +0200, Stefan Agner wrote:
>> With PHYS_ADDR_MAX there is now a type safe variant for all
>> bits set. Make use of it.
> 
> There is?  I don't see it in linux-next.

The patch "mm/memblock: introduce PHYS_ADDR_MAX" got merged earlier this
week, should be in the -mm tree.

--
Stefan
