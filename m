Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeBOFZJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 00:25:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbeBOFZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 00:25:08 -0500
Subject: Re: [PATCH] Build: Scripts/Makefile: Remove Repeated Lines
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Progyan Bhattacharya <bprogyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        narmstrong@baylibre.com, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>,
        Joe Perches <joe@perches.com>
References: <20180214092558.5846-1-progyanb@acm.org>
 <20180214224937.3f2feb80@canb.auug.org.au>
 <CAGyWO1-9scERtpPw5CCwQcUbCU0SpcqpNq2eiBWRtwpRC-kB-A@mail.gmail.com>
 <20180215160520.5828f900@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bec02b84-316b-a41a-91ea-e0957d358ee3@infradead.org>
Date: Wed, 14 Feb 2018 21:24:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215160520.5828f900@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 09:05 PM, Stephen Rothwell wrote:
> Hi Progyan,
> 
> On Thu, 15 Feb 2018 09:50:03 +0530 Progyan Bhattacharya <bprogyan@gmail.com> wrote:
>>
> 
>> PS: I have another question, Is use of range expression within case
>> statements allowed in Kernel? If not, are we using If-Else ladder for that?
> 
> I am not sure if we have a policy on ranges in case labels, but it is
> not standard C (well, C11 at least).  If-else ladders are certainly
> common.

I found 964 case ranges in 4.16-rc1.

or you use something like:

	switch (val) {
	case 5:
	case 10:
	case 15:
		// handle multiples of 5:
		break;
	default:
	}



-- 
~Randy
