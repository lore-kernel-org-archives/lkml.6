Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AB8JxZoeNrJpG6OGTzLDqOu9ozSeg21lAbr3o2F35RxjZgThXo51tiIHyRHO5/QgdHN6Tku0BJGJ
ARC-Seal: i=1; a=rsa-sha256; t=1526248149; cv=none;
        d=google.com; s=arc-20160816;
        b=bq9BpYAu8emngPQ/uekHcLK9N3fMGujqmc7eyvc14wnaOiZ3F8mLyfgt4Xm8QlVTMj
         3UxEPnnYDFo5VxZKm3/B46p6eC2J8thNgQZtC9BkrKxsw3BtqxAZGubafNFZI3WdA6w5
         b1NRVkTFZ3KHK4XSBWGzvGrnL95zhxQETnO17fwalwckoPP/8Hzp8B/vWl8p5DY/gN+6
         WrTUIeolCauoCgyCW3tV4RzxQm7GeTcvnkc0JGqD2wmSv2w5a1sID4tzS1fUjcQekkN2
         4yJJBPZWeQSc8iCNt8ewGa2uAv3CMW+M1eS66sFShq7C1zP4UZZW7UiR+eEh3b8nQEPM
         ozyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=Mwj07RDV+AMacP6hsbuANl6GrUXUHjUpc8gpVJnDzHI=;
        b=uLFpQfiRgysGkbUa+0FQMJ4BtPJRLmZ6JjAt3stCYzJNIRs8WTFNJnEBNWTtDyvceI
         0WbBhc/OKNFUOy4Jyz8wIXcLzlmhM7Rdz6QFpRTjW3wDwLX9y9tlQiqb48HnK3yjQVNG
         UsqNVvma9dBMccpO0KJy1w168nf3IzuAeIMqoaSRZDNH5+X4DCmRX/2cg5dEno8YbkSf
         AXrU0CtPOy+tj6/rxD2TpZ7w/k/uIG624tGyKyObqrT1oYg0W1kImQNAzXumOmYS2l39
         CEFQcStFD5u09moGL1NkgObR5BvrNeLSWTg+WCkdo219bnUv20whAGBALZEU0WFfZQsN
         aXjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.177 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.177 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:4321:4384:5007:10004:10400:10848:11026:11658:11914:12294:12296:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: feast87_158587d0c9534
X-Filterd-Recvd-Size: 1780
Message-ID: <039ab80bd6a653505e606bf87fceae156fe127e1.camel@perches.com>
Subject: Re: [PATCH] staging: speakup: Fix coding style
From: Joe Perches <joe@perches.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Greg KH
	 <gregkh@linuxfoundation.org>
Cc: w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	speakup@linux-speakup.org
Date: Sun, 13 May 2018 14:49:06 -0700
In-Reply-To: <20180513093830.lwspfmjaxjixpaew@var.youpi.perso.aquilenet.fr>
References: <20180513093830.lwspfmjaxjixpaew@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600380656622822002?=
X-GMAIL-MSGID: =?utf-8?q?1600387180029635828?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-05-13 at 11:38 +0200, Samuel Thibault wrote:
[]
> @@ -68,7 +68,7 @@ int spk_punc_level, spk_reading_punc;
>  char spk_str_caps_start[MAXVARLEN + 1] = "\0";
>  char spk_str_caps_stop[MAXVARLEN + 1] = "\0";
>  char spk_str_pause[MAXVARLEN + 1] = "\0";
> -bool spk_paused = 0;
> +bool spk_paused;
>  const struct st_bits_data spk_punc_info[] = {
>  	{"none", "", 0},
>  	{"some", "/$%&@", SOME},
> @@ -1782,8 +1782,7 @@ static void speakup_con_update(struct vc
>  		/* Speakup output, discard */
>  		return;
>  	speakup_date(vc);
> -	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0])
> -	{
> +	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0]) {
>  		synth_printf("%s", spk_str_pause);
>  		spk_paused = 1;

probably nice to change the assignments of
spk_paused to true&false too
