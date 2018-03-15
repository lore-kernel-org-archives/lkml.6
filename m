Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AG47ELs2qf1Av3PexBQVlXaUourVcV9BrL8lJRkDtYr/erqNV2AzLvZwJ6Yya4roq1LdsNJg+z+Q
ARC-Seal: i=1; a=rsa-sha256; t=1521126021; cv=none;
        d=google.com; s=arc-20160816;
        b=in4OHRjhuYfM4K8h0Zknv/eYWzyqFmqO3kezj2PfIZZCeDygWQf2SrR120TxjwSQvk
         A24WOtWKOaJX/KZGWz75nuehccDec8RhXLFKleOeohP5rQkas539LrjoyLkDdvdaFUAS
         yXzku/gKBQKVgb8PIBEFgKlRkcW6BUmkThlK3QJhumRhBR63VteujSUJGBglzhQ+sEDt
         9FS+rwSiue7FK7RRFalf939Ovwcb+jH5GXOabZTpXZXX/lTwHGmw6eq405cCOlgQU7xK
         9+AxgDV/ESZ6qmJav2eb3dvTb5vqSI0Cdof/tSnLBvUA0MXvd+KnXz1bqlfXGb5DERKe
         oxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=szC8bTkO9ezy0Y5kJ8lFcVkVIIDdewgJ1vU0y62MlpA=;
        b=AWB7blal9/xMaoax/y7Axq9TMzoxYVSFEQWXnAJPNtsAaaJ4eq8PfaL1Rp2JPKyQcm
         UO2gWhm5nre6Q7NUTNhuXLduiv6dxaMt6aAhLH9akCGbIYs7lT9EXfJE4G0K8ah8GlB3
         NmnkqNhW9Rj9J1Gb8wiojjGHVjcx4B2csRD58fufxDXOk5uNevHR79lGpYXC3SLOhgDp
         dctxN3Wj6pddFaQBXwENEdIhW8YsXrVai+G1DxVjCwwKvpykpCZcvHVRkWuJFDrXeYHo
         5NWPatadTDb8lWc/6nDn6wHPJwz0rl4eucMiR8f6wkHihlPD6T1Auwnwf2doo0A3Iat6
         pCkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.44 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.44 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2525:2560:2563:2682:2685:2828:2859:2892:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6117:7903:8985:9025:10004:10400:10848:11232:11658:11914:12050:12740:12760:12895:13069:13071:13311:13357:13439:14180:14181:14659:14721:21080:21433:21627:30054:30075:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: crowd30_2de5f3374036
X-Filterd-Recvd-Size: 1581
Message-ID: <1521126018.22221.8.camel@perches.com>
Subject: Re: [patch 0/4] genirq: Clean up license information
From: Joe Perches <joe@perches.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne
 <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 08:00:18 -0700
In-Reply-To: <20180314211515.429128440@linutronix.de>
References: <20180314211515.429128440@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949825957172254?=
X-GMAIL-MSGID: =?utf-8?q?1595016239281557041?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-03-14 at 22:15 +0100, Thomas Gleixner wrote:
> The following patch series cleans up the licensing information in the
> generic irq subsystem.
> 
>   * Replace boiler plate language and sloppy references with SPDX
> 
>   * Add missing SPDX identifiers to files with no license reference
> 
>   * Use the proper tag format
> 
> While at it clean up the top of file comments by removing pointless
> references to the filename itself and condense the information where
> appropriate.

Hello.

What do you think of the proposal to convert all the tags
to the "-or-later" and "-only" variants that the
https://spdx.org/licenses/ uses today?
