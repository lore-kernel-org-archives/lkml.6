Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx48ssLCf159QR6ZDP4Wz9HU0LxqISzntZgQgTz8N7BrWl/yHTeNs3T9SKC66tfBiWhHCDMYU
ARC-Seal: i=1; a=rsa-sha256; t=1522395854; cv=none;
        d=google.com; s=arc-20160816;
        b=Mx/pdMxojcNd6vAsp27Ytwj12uO4YEFQp+pLGIQXOKjf9a7XpaMAO2tcOVVP151OIq
         YuWBSJwwL7VTfNeK0OEcaFpHY1GHM/R45Q/jgj6QSBqoZcNYch4lSydVP2TnPmJbni1n
         RMAOUtaKCuhEZ1FFXlPTyxE5MbxGp0YmyEJxbT2bhQgSWB/gAY7z4b5G4vXmeUvbXWlr
         0p+DPWYks4rakxPHu0Oq6ZXbeljbVbD52YEv8RxZoKgKncIkGB5RbcO46KmMVUUqKUdn
         OPPDZhAckV9ARkDmT0x+cwTPJn5E0tyiB4b3zT2YCmAnrqpYqvtgQ/25jhjgh1qO2duj
         1tSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=xIo7vHPxyZoj7Tj8p+ioRxBaSdSy1Lyaz81bR7Zz/Jo=;
        b=XfBoSr6EqAL+uMcpCig0TFg7GQ/P9dG113E8DVVl2mRc3625d54BcZotWob6Xkbf2a
         7qLIZolbI6N55DeRJYoQrrgarXFH8YsIzGebblvWB6oBm3A9bQsKONmriOTVQIkGgt2p
         +A71mbeF0+Enjm1JHFWX3KQUcLWj1MX70IHOpuBrnt6FpD6dvjXJZF+5ZRxpq1udRQXg
         vb3p+P0RpesWyKkLzr0yZVxPAYuVf3319ZcQKlwerEwErEbe1dDAP6Yt8MveZPrOtfuo
         +d92TCJhc8DN+UDHXAoh1G4ywLcgKO6LJEDwInskmp1qVgJMoMyLHSn3VT/puhLgedGy
         MQAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.198 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.198 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7628:10004:10400:10848:11026:11232:11658:11914:12043:12114:12296:12438:12555:12702:12737:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30030:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: quiet76_7c052cbe8c802
X-Filterd-Recvd-Size: 1938
Message-ID: <1522395850.2210.42.camel@perches.com>
Subject: Re: [PATCH 12/76] staging: ks7010: Remove trailing _t from 'struct
 hostif_mib_set_confirm_t'.
From: Joe Perches <joe@perches.com>
To: Quytelda Kahja <quytelda@tamalin.org>, gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 00:44:10 -0700
In-Reply-To: <20180330070842.25224-12-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
	 <20180330070842.25224-12-quytelda@tamalin.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345548609782886?=
X-GMAIL-MSGID: =?utf-8?q?1596347754903198757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-30 at 00:07 -0700, Quytelda Kahja wrote:
> The "_t" suffix is not needed for structure names in this driver, and is a
> reflection of an older typedef system that is no longer in place. Replace
> all occurences of 'struct hostif_mib_set_confirm_t' with 'struct
> hostif_mib_set_confirm'.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
> index 5261810fbc76..7a0e0c610c50 100644
> --- a/drivers/staging/ks7010/ks_hostif.h
> +++ b/drivers/staging/ks7010/ks_hostif.h
> @@ -175,7 +175,7 @@ struct hostif_mib_set_request {
>  	struct hostif_mib_value mib_value;
>  } __packed;
>  
> -struct hostif_mib_set_confirm_t {
> +struct hostif_mib_set_confirm {
>  	struct hostif_hdr header;
>  	__le32 mib_status;
>  	__le32 mib_attribute;

It is probably better to remove unused structs
