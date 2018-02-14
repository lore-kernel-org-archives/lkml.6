Return-Path: <garsilva@embeddedor.com>
X-Google-Smtp-Source: AH8x224QWVI3Jsw3WdzrIGds/JPh0Ca2Bx6ez1vop221oP7nEh7gjAJWxocZs9MLsChFFAOwTu0q
ARC-Seal: i=1; a=rsa-sha256; t=1518645886; cv=none;
        d=google.com; s=arc-20160816;
        b=V8remLzf3jgTOFFZP0H2jB+XT7c7DJm+5MBAxmt72NRO7KyiZKLkAKVIBtcqkbRIJ+
         +CBWAzo0DGGRJYVFjCzjE+WymJgEXnjRFY3qUyiteeblHotckZeZrUyeCrslneNIzVqx
         LqrppIIaDLOGHe2KAsuTEVrlA0hm5UoqPNMxYUw/AOjW3IBGbpf0cbO8l7xNqkJ1bqRS
         CvgYb673+FOpaPIsgeCkY/ULjEmmb3y+e4F3eTKh8cj+Kqwj9P5vaSKVSR7uP4UORuRy
         V6vfJr82ALOqGrezFb6nGsAJnwSqP9dGL4g3UPDpfG9dMCyQxOU0jsWc9WaeSHiz1COY
         +rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=bkP/Bd/zr7L1nR4iZgPEHjZlViOjfqEg8z2vPH/9Jto=;
        b=p9QifIIk6pq3N1zreYTzoy/kFUoVKZhvuD3l2zA8yIJMDCDNF5Zv5rU+ntVVG59bRT
         m5cdbnsB8wP4XYLzHnJtkYPWiQfTxwbXbRGv7j51Fjf+sUmSVvp4umUHCcEfVZU+rI6m
         D8orpG8HMbjQkwxA3AlhOvT3iCljqJNB829m65dMPrf3ZaYWkHGjlFCgbqpj6Vmed8Dm
         YatBaXZqbDgDDENKEXTmuz4iCuMPpQkeixip4gBSbSmgk8UrgPPDNrkadzSLSHX0UKuf
         /Q+Hmchvrwt/NVrUo8t+adQy/tdxFlKQ6z+ryC7chqMUH0wXuYber6XBqtA+tXU41qBg
         Jwpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of garsilva@embeddedor.com designates 192.185.143.4 as permitted sender) smtp.mailfrom=garsilva@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of garsilva@embeddedor.com designates 192.185.143.4 as permitted sender) smtp.mailfrom=garsilva@embeddedor.com
Subject: Re: [PATCH] ipmi: kcs_bmc: mark expected switch fall-through in
 kcs_bmc_handle_data
To: minyard@acm.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Haiyue Wang <haiyue.wang@linux.intel.com>
References: <20180214173029.GA15661@embeddedor.com>
 <9098c6c8-83e5-5e1f-519b-68e14738c24a@acm.org>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <2392e121-3094-375c-7b98-6bbc18fae18d@embeddedor.com>
Date: Wed, 14 Feb 2018 16:04:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9098c6c8-83e5-5e1f-519b-68e14738c24a@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1em5AT-000yXU-DF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.4.238]:35326
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592398376863502226?=
X-GMAIL-MSGID: =?utf-8?q?1592415628523713906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/14/2018 03:46 PM, Corey Minyard wrote:
> On 02/14/2018 11:30 AM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
> 
> Thanks, queued for next release.
> 

Thanks, Corey.
--
Gustavo
