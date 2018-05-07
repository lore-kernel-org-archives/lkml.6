Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeEGQRr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:17:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52112 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeEGQRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:17:45 -0400
Subject: Re: linux-next: Tree for May 7 (net/xdp)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
References: <20180507153147.166ee38a@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e9890e95-16b4-4540-301b-43f17a824808@infradead.org>
Date: Mon, 7 May 2018 09:17:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507153147.166ee38a@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2018 10:31 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180504:
> 

on i386:

net/xdp/xdp_umem.o: In function `xdp_umem_reg':
xdp_umem.c:(.text+0x47e): undefined reference to `__udivdi3'


-- 
~Randy
