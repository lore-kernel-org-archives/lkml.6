Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeC3Qcj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 12:32:39 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.164]:30844 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751263AbeC3Qci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 12:32:38 -0400
Subject: Re: [PATCH] ISDN: eicon: message: remove redundant check
To: Joe Perches <joe@perches.com>, Armin Schindler <mac@melware.de>,
        Karsten Keil <isdn@linux-pingi.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180330154648.GA13995@embeddedgus>
 <1522426759.2210.46.camel@perches.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <17ba7cdf-7e53-36f0-5ef0-f81aa3c560ca@embeddedor.com>
Date: Fri, 30 Mar 2018 11:32:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522426759.2210.46.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f1wxB-0013Ld-DD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.54.187]:39558
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/30/2018 11:19 AM, Joe Perches wrote:
> On Fri, 2018-03-30 at 10:46 -0500, Gustavo A. R. Silva wrote:
>> Check on plci->internal_command is unnecessary.
> 
> Probably all of these are unnecessary too:
> 
> $ for length in {7..2} ; do \
>      grep-2.5.4 -rP --include=*.[ch] -n "^\t{$length,$length}break;\n\t{$(($length-1)),$(($length-1))}break;" * ; \
>    done
> drivers/staging/wilc1000/wilc_wlan.c:691:				break;
> 			break;
> drivers/media/dvb-frontends/drxd_hard.c:2261:				break;
> 			break;
> drivers/media/dvb-frontends/drxd_hard.c:2266:				break;
> 			break;
> drivers/media/usb/gspca/sn9c20x.c:1860:			break;
> 		break;
> drivers/isdn/i4l/isdn_common.c:624:			break;
> 		break;
> drivers/isdn/i4l/isdn_common.c:642:			break;
> 		break;
> drivers/isdn/i4l/isdn_common.c:654:			break;
> 		break;
> drivers/isdn/hardware/eicon/message.c:13890:			break;
> 		break;
> sound/usb/mixer_quirks.c:1832:			break;
> 		break;
> 

Oh, cool.

I'll take a look at them.

Thanks, Joe.
--
Gustavo
