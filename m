Return-Path: <outreachy-kernel+bncBCS4V27AVMBBBJFHXPKAKGQEPTGB64I@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519309733; cv=pass;
        d=google.com; s=arc-20160816;
        b=Sft9uX90UYZh19pf9Z7VJQe7+TSKoiQb9ck0a+9VqPqZOCYpDm+gM6vBQ2tUDRIbvK
         SGSPChMcwaz6XHqQzaTRZweMOs3CRDHCuP2kYtJM5GT3f3OKNBSpOQer8qKR+untlgPx
         mrdJFW9Mx4eUHPQJ8hg/XfqTYVtuKQweUQqJN+30FuJFrczgAAwf1vLpciyOB2EfwwJi
         7zrs1XF/hiKAWgwV5CAxvLVZastbOMAl53apzBTGakUvqnNNgShys6uJVMO/zMs3PSnw
         ARjsTZJnIBL+b69amjx4UVOUZ8YCjp7WU0td7F5ny+vq/uNWII+6x5mzzXn1eAsW+A7L
         xsKg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=/1SEeFl+mfHPHtifZR60Ejm47F1yRkquXh7fdcrxG6A=;
        b=oyjTFXMbaMM4rkJHozGEiYT32b1Ta7tSgzlEiU9WUps7n554QFOo9HglNlOCI0wIhl
         abygoj5SO1FqaKEu+3MZ4bNKw+V7gbIyLGZDN/5Qn0lndvks8XYovWyfM+o12/K8L1O7
         G6/pMKa/nVc9WzDvXCT+yyDP+Y0VEkSDWzngtSNeEOLldrl5GdnEWOczj97i+GvzMYrV
         dmgpU7CULm3iyL75Pb4ue1ByImuLjWIbNxjQsdi1vjD0eRuroeN+AfFmlOFtx5YCYmWT
         yk78iqdr2jrCkmuS7trKlYByzhNHfWxEGF3gdQ3u0lNiICUg7lF63iAoQayT+HPeaTh+
         82yA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=AiWDjWNW;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcs4v27avmbbbjfhxpkakgqeptgb64i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCS4V27AVMBBBJFHXPKAKGQEPTGB64I@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=AiWDjWNW;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcs4v27avmbbbjfhxpkakgqeptgb64i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCS4V27AVMBBBJFHXPKAKGQEPTGB64I@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519309732; cv=pass;
        d=google.com; s=arc-20160816;
        b=DzVBiOZJPeJOuRIhYoO/yELvZCq0tQo8/hIUTbVzDTeiauy/OLbls9LTpaMCJAgVy1
         /gyTc3fqGpos005da1mwnNZ54bQddE8HpkQDzdzV4cAi8Lx/N0lMSuGfm0YjKOs0vDhD
         Rie3c7BFOvb0TBZS14ojHCKX033tDI84iPgo5rSRNayxlZugPsbKetdFTJH6gGWqQnMe
         6Z0/nER4b2c86eKraHB90JeZga0WoxQeqhaqTKNnz6Dq4vYyEH3MwLJuKOO5RBkJWPyw
         x3rICUwsLUQrZ/ePhKwGll2MbQeWzJ2za+0jbzDLs3zp8IDBAMOxnp8MHMSo37xou7z/
         Fjzw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=/1SEeFl+mfHPHtifZR60Ejm47F1yRkquXh7fdcrxG6A=;
        b=I3xmeIa1CS+trK/FjJMYoCSLLVdeCusnznXA8XEAIhecPhGb+V5DYrMSoadh8tCDDK
         NA0UesHtZZzcT6Fd+pvRWTmtFCHlXE1v262XAlO2nidq/2nYjKI/OctpQw3g15U2pczM
         jkWq8bOxe51N/+jHMlH/bpwskV1ETnyrknmTeK6V6E+QoStTzarCatQQH71R7GDiot5F
         /NNhgcrVJKWbhBNz7xgmlzGEfmgu0BKIq1Dl0ahkspuSefME/HPPPIOX/ULSwu5YE/8C
         28DoPYW/UNMsshyXPtdOx5ZjClJ0ubjOBuu8BGLCtVnXX6cXMAKPmDR77VJjDhGO7vVc
         W2cw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x22672eeAJOfbt216jEiirEUKrYAjQtZRT/Agm9BuZL0AYYVPX86exSB/a2n55QEHyYz81Se/ww==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519309731; cv=none;
        d=google.com; s=arc-20160816;
        b=DBbMCIFJpfMBpUuk43VbN8eoG6yQv8POA7T+dxtoRe3xyRvkLQ0ShDMEay0GwUKKQv
         FYqB01B469scS9pL58+824p29N+uT+t4c4fvKs4yVxNm0Udwzh3AnACzRDGBP6B0Ah9o
         qJhn8KbXznXW/Wven4FKjxXgNOmPGHHZZq9DMOfUoLQ2DNq5hzDyxmqzbfwMnFvwiOem
         PGTQmOuw7j9da9bvbI6eZmfAJqaxgXupyC6vG4NGhmsmQdBh+Ano/kgAlY2sOD6eYpzb
         UY26/OfKVD54AxlhO1yZleqAPPNl+hh2zP7XgujB4cUKFlTwfX8Vewvn5szB1lvnT4nK
         l/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=2AWHWEyfHETZACdElTNj0crLyXtwBXp2Dyiou2ec84c=;
        b=fBXXxQg3xrmmF4yx+1yzbTwy4eZF9GYzwKCDQ2fF17zd81cOjfGCcntTF9J9s8wxNW
         nSvWrptlTBf0fY43kPoLuvO1zW5XocaBji2kYP5S6X4wwC3N4fT2duACMm5IXAqeikXS
         Vyj6nRjqaub64+KlOKhk75P0kXIQ5RE1dymKuh8oMtnTLFmYdlNYCOMudJ6gMR+92vY7
         ueU970Koln64f65e5NMN+gqwWuuSGWjXgEzTuh25btaFIjnNUUZFeE9WLgxODB+dFAAj
         5tNanPI8p2EijPc3I96tZwlYoYYu0I1Rx3/rG62QvAjMiFQcZvn/+E8Z1Q720RoV4V+M
         jCuA==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, dwmw2@infradead.org, computersforpeace@gmail.com, marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v3] mtd: nand: Replace printk()
 with appropriate pr_*() macro
Date: Thu, 22 Feb 2018 15:30:09 +0100
Message-ID: <2093598.TLbMltDcSo@blindfold>
In-Reply-To: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1519305014-2547-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: richard@nod.at
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning richard@nod.at does not designate
 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593106783204445682?=
X-GMAIL-MSGID: =?utf-8?q?1593111722938928556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Donnerstag, 22. Februar 2018, 14:10:14 CET schrieb Shreeya Patel:
> @@ -438,7 +438,7 @@ static void __init doc2000_count_chips(struct mtd_info
> *mtd) break;
>  	}
>  	doc->chips_per_floor = i;
> -	printk(KERN_DEBUG "Detected %d chips per floor.\n", i);
> +	pr_debug("Detected %d chips per floor.\n", i);

<bike-shedding>

You are aware of the fact that printk(KERN_DEBUG and pr_debug() are not 
equivalent?
Not a big deal, just want to make sure that you understand what you are doing. 
:-)

</bike-shedding>

Thanks,
//richard

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/2093598.TLbMltDcSo%40blindfold.
For more options, visit https://groups.google.com/d/optout.
