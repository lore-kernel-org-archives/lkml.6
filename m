Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeBSSOD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 13:14:03 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.31]:33726 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753396AbeBSSOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 13:14:01 -0500
Subject: Re: [PATCH] CIFS: fix sha512 check in cifs_crypto_secmech_release
To: =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
References: <20180219171113.GA16636@embeddedgus> <87zi4428l7.fsf@suse.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <3eb514ff-d659-80ef-3e09-aa39c829f862@embeddedor.com>
Date: Mon, 19 Feb 2018 12:13:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87zi4428l7.fsf@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1enpwu-001jIH-Ks
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:57172
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aurélien,

On 02/19/2018 11:27 AM, Aurélien Aptel wrote:
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
>> It seems this is a copy-paste error and that the proper variable to use
>> in this particular case is _sha512_ instead of _md5_.
> 
> *sigh* I re-read this a lot yet still missed it. Minor memory leak
>   fixed, good coverity catch and thanks for the fix!
> 
> Reviewed-by: Aurelien Aptel <aaptel@suse.com>
> 

Glad to help. Thanks for the review.

BTW I think this should be sent to stable too.
--
Gustavo
