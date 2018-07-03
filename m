Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9FDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6B924E9A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6B924E9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeGCGKe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:10:34 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:7211 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753999AbeGCGKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:10:33 -0400
Subject: Re: [PATCH] docs: update kernel versions and dates in tables
To:     Tim Bird <tbird20d@gmail.com>, <corbet@lwn.net>
CC:     <tim.bird@sony.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1527114014-26240-1-git-send-email-tim.bird@sony.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <4111a2f2-b03b-5f07-929a-680c86b71771@sony.com>
Date:   Tue, 3 Jul 2018 08:10:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527114014-26240-1-git-send-email-tim.bird@sony.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 12:20 AM, Tim Bird wrote:
> Every once in a while, we should update the examples
> to reflect more recent kernel versions.
>
> Update the tables describing kernel releases, the merge window,
> and current longterm maintained kernel, from 2.6-era kernels
> to 4.x.
>
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>  Documentation/process/2.Process.rst | 72 +++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
> index ce5561b..a9c46dd 100644
> --- a/Documentation/process/2.Process.rst
> +++ b/Documentation/process/2.Process.rst
> @@ -18,17 +18,17 @@ major kernel release happening every two or three months.  The recent
>  release history looks like this:
>  
>  	======  =================
> -	2.6.38	March 14, 2011
> -	2.6.37	January 4, 2011
> -	2.6.36	October 20, 2010
> -	2.6.35	August 1, 2010
> -	2.6.34	May 15, 2010
> -	2.6.33	February 24, 2010
> +	4.11	April 30, 2017
> +	4.12	July 2, 2017
> +	4.13	September 3, 2017
> +	4.14	November 12, 2017
> +	4.15	January 28, 2018
> +	4.16	April 1, 2018
>  	======  =================
>  
> -Every 2.6.x release is a major kernel release with new features, internal
> -API changes, and more.  A typical 2.6 release can contain nearly 10,000
> -changesets with changes to several hundred thousand lines of code.  2.6 is
> +Every 4.x release is a major kernel release with new features, internal
> +API changes, and more.  A typical 4.x release contain about 13,000
> +changesets with changes to several hundred thousand lines of code.  4.x is
>  thus the leading edge of Linux kernel development; the kernel uses a
>  rolling development model which is continually integrating major changes.
>  
> @@ -70,20 +70,19 @@ will get up to somewhere between -rc6 and -rc9 before the kernel is
>  considered to be sufficiently stable and the final 2.6.x release is made.
>  At that point the whole process starts over again.
>  
> -As an example, here is how the 2.6.38 development cycle went (all dates in
> -2011):
> +As an example, here is how the 4.16 development cycle went (all dates in
> +2018):
>  
>  	==============  ===============================
> -	January 4	2.6.37 stable release
> -	January 18	2.6.38-rc1, merge window closes
> -	January 21	2.6.38-rc2
> -	February 1	2.6.38-rc3
> -	February 7	2.6.38-rc4
> -	February 15	2.6.38-rc5
> -	February 21	2.6.38-rc6
> -	March 1		2.6.38-rc7
> -	March 7		2.6.38-rc8
> -	March 14	2.6.38 stable release
> +	January 28	4.15 stable release
> +	February 11	4.16-rc1, merge window closes
> +	February 18	4.16-rc2
> +	February 25	4.16-rc3
> +	March 4		4.16-rc4
> +	March 11	4.16-rc5
> +	March 18	4.16-rc6
> +	March 25	4.16-rc7
> +	April 1		4.17 stable release
>  	==============  ===============================
>  
>  How do the developers decide when to close the development cycle and create
> @@ -99,37 +98,42 @@ release is made.  In the real world, this kind of perfection is hard to
>  achieve; there are just too many variables in a project of this size.
>  There comes a point where delaying the final release just makes the problem
>  worse; the pile of changes waiting for the next merge window will grow
> -larger, creating even more regressions the next time around.  So most 2.6.x
> +larger, creating even more regressions the next time around.  So most 4.x
>  kernels go out with a handful of known regressions though, hopefully, none
>  of them are serious.
>  
>  Once a stable release is made, its ongoing maintenance is passed off to the
>  "stable team," currently consisting of Greg Kroah-Hartman.  The stable team
> -will release occasional updates to the stable release using the 2.6.x.y
> +will release occasional updates to the stable release using the 4.x.y
>  numbering scheme.  To be considered for an update release, a patch must (1)
>  fix a significant bug, and (2) already be merged into the mainline for the
>  next development kernel.  Kernels will typically receive stable updates for
>  a little more than one development cycle past their initial release.  So,
> -for example, the 2.6.36 kernel's history looked like:
> +for example, the 4.13 kernel's history looked like:
>  
>  	==============  ===============================
> -	October 10	2.6.36 stable release
> -	November 22	2.6.36.1
> -	December 9	2.6.36.2
> -	January 7	2.6.36.3
> -	February 17	2.6.36.4
> +	September 3 	4.13 stable release
> +	September 13	4.13.1
> +	September 20	4.13.2
> +	September 27	4.13.3
> +	October 5	4.13.4
> +	October 12  	4.13.5
> +	...		...
> +	November 24	4.13.16
>  	==============  ===============================
>  
> -2.6.36.4 was the final stable update for the 2.6.36 release.
> +4.13.16 was the final stable update of the 4.13 release.
>  
>  Some kernels are designated "long term" kernels; they will receive support
>  for a longer period.  As of this writing, the current long term kernels
>  and their maintainers are:
>  
> -	======  ======================  ===========================
> -	2.6.27	Willy Tarreau		(Deep-frozen stable kernel)
> -	2.6.32	Greg Kroah-Hartman
> -	2.6.35	Andi Kleen		(Embedded flag kernel)
> +	======  ======================  ==============================
> +	3.16	Ben Hutchings		(very long-term stable kernel)
> +	4.1	Sasha Levin
> +	4.4	Greg Kroah-Hartman	(very long-term stable kernel)
> +	4.9	Greg Kroah-Hartman
> +	4.14	Greg Kroah-Hartman
>  	======  ======================  ===========================

Is  4.14 not very long-term stable kernel ?

>  
>  The selection of a kernel for long-term support is purely a matter of a


