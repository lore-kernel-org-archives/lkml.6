Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeCVGxT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 02:53:19 -0400
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:54569 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752024AbeCVGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 02:53:14 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/5 v4] add compression algorithm zBeWalgo
From: Benjamin Warnke <4bwarnke@informatik.uni-hamburg.de>
In-Reply-To: <CAOFm3uEpDh1jp1+ODzR=TFH0uq08LL2qjqrMLOe+_jE+4Sw_og@mail.gmail.com>
Date: Thu, 22 Mar 2018 07:53:08 +0100
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, minchan@kernel.org,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D63776B2-09B1-428C-99B7-68F4BD9BC7E8@informatik.uni-hamburg.de>
References: <D7FA4547-4FA6-46EC-99D7-F08ACCD3F13D@informatik.uni-hamburg.de>
 <CAOFm3uH1Nw3x6-T1yTMkoX2tpxiwjnerAXDh-WEpyFNROFwAYw@mail.gmail.com>
 <F4F10894-B101-4E46-A39D-7F09DEF2207D@informatik.uni-hamburg.de>
 <CAOFm3uEpDh1jp1+ODzR=TFH0uq08LL2qjqrMLOe+_jE+4Sw_og@mail.gmail.com>
To: Philippe Ombredanne <pombredanne@nexb.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

> Actually to be consistent if you want to use GPL-2-0 (and not "or
> later") you should use:
> 
> 1. at the top, for a c. file:
> // SPDX-License-Identifier: GPL-2.0
> 
> or for a .h file:
> /* SPDX-License-Identifier: GPL-2.0 */
> 
> The doc explains it all. Including the comment style (a topic that has
> been discussed also on list quite bit: Linus had the final word there)
> 
> 2. and in your MODULE_LICENSE macro:
> 
> MODULE_LICENSE("GPL v2");
> 
> .... because a MODULE_LICENSE("GPL"); would mean GPL-2.0+ (e.g. or any
> later version) and this would not match your top level license tag.

Thanks, I have done this correctly in my files, but accidentally written it wrong in my mail.

Cordinally
Benjamin Warnke
