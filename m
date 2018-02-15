Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165859AbeBORxG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:53:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164213AbeBORxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:53:03 -0500
Subject: Re: [PATCH] Build: Scripts/Makefile: Remove Repeated Lines
To: Progyan Bhattacharya <bprogyan@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, narmstrong@baylibre.com,
        akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>, Joe Perches <joe@perches.com>
References: <20180214092558.5846-1-progyanb@acm.org>
 <20180214224937.3f2feb80@canb.auug.org.au>
 <CAGyWO1-9scERtpPw5CCwQcUbCU0SpcqpNq2eiBWRtwpRC-kB-A@mail.gmail.com>
 <20180215160520.5828f900@canb.auug.org.au>
 <bec02b84-316b-a41a-91ea-e0957d358ee3@infradead.org>
 <CAGyWO1_tmrSB8WwyARGWXhYCz=SL-xqqU4d3Y0A1vqGWQ_8Trg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <45b314c4-a087-ee0e-d4ad-79f5ee6ac807@infradead.org>
Date: Thu, 15 Feb 2018 09:52:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGyWO1_tmrSB8WwyARGWXhYCz=SL-xqqU4d3Y0A1vqGWQ_8Trg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 01:38 AM, Progyan Bhattacharya wrote:
> I think some merge error happened in my local workspace.
> 
> Yes the file is correct in Linus's tree as well as current HEAD of linux-next.
> Thanks.
> I will update my tree accordingly.
> 
> About the nonstandard range statements in case, should I rewrite them. I think If-Else will be easier to read and understand.

I don't see a need for any such change.


-- 
~Randy
