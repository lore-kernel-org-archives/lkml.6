Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AG47ELskATXFeRBAoybUK3Ze5ALPjR1mGGqw55iHgxdwIU8sPGLiw4U+gGuwg1HG6aJad298Tasd
ARC-Seal: i=1; a=rsa-sha256; t=1521577959; cv=none;
        d=google.com; s=arc-20160816;
        b=t1EcLXS56gNhCcB0EVws++hAmFvn6Qy1YsYlGYYMZUIDLhMM2Gqf3GCwkEarUDjsyX
         M6UMkPljHrEoXnjSamAcU2Xi2mQGPyG04H2ArsolxMoFhMfkaRpHJC4isBLPLs16fgsm
         KprcmGvOXQSAQZB8v2TqeyZG2b8ZwEGU0QoJprdHG1jBAMzcOJhSMncxT31KUCHFLuSk
         eAYUjEHwyl/4oG9Yahwc4U+o/2sDEcRu1KTmhYBkgvQA+MhD+F9oqAjxoRAU0VULqW/V
         Get/SDqrOpivTYLzHnBblXImCkoPPsHWdipTkSia9OjaVFjjYVggNrEPKAQbZTyeOPOt
         NGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=kGTiyybuvBwa4pIvTcTX7+MjPTzkTiq0pxFKEos7poY=;
        b=nzULoegMFMZU1D6I9wiBRboI+rUa/v3B+IP4A2eaCEX9f6uL6X4d/GMq/T3Q3L9RZZ
         HZFQBPgXR67BIRHM/WoHcw9uh8xG+rxtTie9aCUa+bx6L2c9tGxML2L53Ov9cYhm6PBc
         T8a/hJ/WzBchXZ6SSURGqKS9UPfgVBAJZdoPccuvs7VcYRVMcR9WnNL1ON0yE2HWrEL8
         yS+KPKn+71Ii9hQ5wPUaMt4U2EbnXqthctiM5jBtQbmTdpq2dE6+GbutfjNYnmzBofUi
         qz5ECjD1A4s0xhEoTzVMI9Lja0vhEMUvHPaJZVkO/0HVtZuz3iqJfr0vHms+IKn2gevw
         +OZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.173 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.173 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:4321:4385:5007:6119:6742:7903:8957:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12438:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21433:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: coat43_8b3e9fde6db00
X-Filterd-Recvd-Size: 1818
Message-ID: <1521577955.12047.26.camel@perches.com>
Subject: Re: [v2 PATCH 5/5] Staging:rtl8723bs clean spaces
From: Joe Perches <joe@perches.com>
To: Paul McQuade <paulmcquad@gmail.com>
Cc: gregkh@linuxfoundation.org, davem@davemloft.net,
 stephen@networkplumber.org,  Linyu.Yuan@alcatel-sbell.com.cn,
 Larry.Finger@lwfinger.net,  keescook@chromium.org, hdegoede@redhat.com,
 johannes.berg@intel.com,  colin.king@canonical.com,
 arvind.yadav.cs@gmail.com, arnd@arndb.de,  devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Date: Tue, 20 Mar 2018 13:32:35 -0700
In-Reply-To: <20180320202622.13339-5-paulmcquad@gmail.com>
References: <20180320202622.13339-1-paulmcquad@gmail.com>
	 <20180320202622.13339-5-paulmcquad@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595489757959780796?=
X-GMAIL-MSGID: =?utf-8?q?1595490130404950440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-03-20 at 20:26 +0000, Paul McQuade wrote:
> Used checkpatch.pl to clean up spaces around if and for statements
> to make it easier to read

Perhaps the commit message can be made clearer.

I think this is technically correct, but it would
be nicer to describe these changes as moving braces
to the more common kernel-style locations.

> diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
[]
> @@ -20,8 +20,7 @@
>  
>  void rtw_os_free_recvframe(union recv_frame *precvframe)
>  {
> -	if (precvframe->u.hdr.pkt)
> -	{
> +	if (precvframe->u.hdr.pkt) {
>  		dev_kfree_skb_any(precvframe->u.hdr.pkt);/* free skb by driver */
>  
>  		precvframe->u.hdr.pkt = NULL;
