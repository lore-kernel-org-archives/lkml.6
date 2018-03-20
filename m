Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AG47ELsSu5rZdVgvTCSajKuvVsMaF3espUHIelx0ZJh4zkkcbCxz+E3NK06JZ2T9ikDcRWa2Kyer
ARC-Seal: i=1; a=rsa-sha256; t=1521526090; cv=none;
        d=google.com; s=arc-20160816;
        b=HCmy/87sqmc37oljZncdk9J06xlxGpdUGouo7ZwG73NoUms2+ldoDagzbA7Lv0EEyb
         lfZ6wQ2Y9J4V8d63L9wOK3y9QY/Hl4v2UhnXWUwxwNHy2x13ECf453ZAa8oSxmo2Xy6p
         ohiv5fmOYTyHG+hlkuHQLgWyQOunREKKryWRfmiqvCZQWl0RFrAJrtStriluQ2uW2LSN
         WFlYMjux70Z1xT1cjW3s0oJhpHCsprlu83iGuFHqujABxAmF5dFvGQ7RMgzKoDKPzOzi
         E/aJXbJoAstYZP8A6GSTPxhb+GRqKGMVU7h27kMccGEqe2F3UVt9aJNhhTB1cCgY8jOq
         T2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=F1yLJ5myzolPHL8QUPTDOWLieHT4rIAr6WcvMQsmzPY=;
        b=OP8FjgLmtgY09NZ8T2FAWLXOPcCleuXujFwri4PO6427+s+hl0o3VWinl/o1qEJcsZ
         bqhWOy/OchqizrILvN6OrbnxDWUi7m8N2c3LtG4nXc0qjkS6xt2VWRnQM14+xPU8obFq
         rrBF8fsZj3swKetQ8ipOtk4N6fFMMRZZrTUCugJR6V1g0bLmaB6ou9gMYmI7Ld9vIXKQ
         /qZAOZpYaetLi3QZP1Ir2qJC6jWYP7GhnCqksb7mIAxaBYhbV81VsK14zPi+okVuT1n9
         sYpZKsJ9hbbCoA6uF8sa+Lep4+Vn6GaVSp6NO+qty38k68HqdmBeKAK+XO77bkGnu3Pb
         n2Wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.36 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.36 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3871:3872:4250:4321:5007:8603:10004:10400:10848:11026:11232:11658:11914:12043:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: unit42_cfb936ae9510
X-Filterd-Recvd-Size: 1645
Message-ID: <1521526087.12047.1.camel@perches.com>
Subject: Re: [PATCH 5/6] staging: ks7010: Fix line over 80 characters.
From: Joe Perches <joe@perches.com>
To: Quytelda Kahja <quytelda@tamalin.org>, gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Date: Mon, 19 Mar 2018 23:08:07 -0700
In-Reply-To: <20180320055815.32651-5-quytelda@tamalin.org>
References: <20180319185125.GA13209@kroah.com>
	 <20180320055815.32651-1-quytelda@tamalin.org>
	 <20180320055815.32651-5-quytelda@tamalin.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595435140471595805?=
X-GMAIL-MSGID: =?utf-8?q?1595435742153135909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 22:58 -0700, Quytelda Kahja wrote:
> There is no reason for comment describing the BSSID check for loop
> to be spaced so far to the right.  Move it above the for loop.
[]
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
[]
> @@ -844,7 +844,8 @@ void hostif_scan_indication(struct ks_wlan_private *priv)
>  	ap_info = (struct ap_info_t *)(priv->rxp);
>  
>  	if (priv->scan_ind_count) {
> -		for (i = 0; i < priv->aplist.size; i++) {	/* bssid check */
> +		/* bssid check */
> +		for (i = 0; i < priv->aplist.size; i++) {
>  			if (memcmp(ap_info->bssid,
>  				   priv->aplist.ap[i].bssid, ETH_ALEN) != 0)

this could also use ether_addr_equal
