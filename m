Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx48/0Ajg3aehFHhiW5mO5Om95JLkKaZbOf90VsNhPPv8yXa2KKIFIwOEzv8WX1MlakT457I+
ARC-Seal: i=1; a=rsa-sha256; t=1523820270; cv=none;
        d=google.com; s=arc-20160816;
        b=KWrCDgtWIELN2fUKhNOiC4CfaYh3o5EBplxnunAoJ1OU1GYPO/PdZVjVMhXEH0AC5c
         8QxPcqcaKbBojyd/fV4ZzUjcwxUtFvzNS0fJdeYs+q4YkvbehX2xHXjkZvYFiRxTbK60
         AiyPOonrULL0L7bvPco2/cWxECQAcPUeWW73lpXUa6w8zPsy0C17wXXM3yHHACaFPj4K
         QWR9Jo1tPkeNCFO48qWssRW4Rm8VRLLU9P/6LlioLsQBRWz/yT4kiQktVUgTHnj+Ntgp
         EYdhWI6opY1qXPFhtseCnk97s7GanfGO7GSpHCS7PvWAelVF3efmRmOR2nct7mtMEhmw
         jdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=wYTdudFTIFyCx+Q8mNTuLi1XY0pqw7o3rJpolRr64sA=;
        b=eRb8JGIl9djXYvAcQQPtYD7FtYiZuG1Mnqd0h9VyrYH0iuFpz4jfVJ9rRohRdssl1/
         hY8Dpc5fw9JNO1DFq7Pc9uAjou8y6BnzKtz5a3gd9HfbQkHdIcfXg4EOl3/QFvhGBP/S
         DcEHOfsJHWYTN/oganEpfQzDv/LlYU6GD1GxFizqBbaTaIDaXnf7CzdaoSDMPUZSSLbx
         7GBjG0pwBTHhYSEH4beVvmiEF/ztXWeBXyrv9fWuM1HQNZdzfVieiZC2nZJYg0bpdnT8
         dHOAONGeOZ/h9iM5sTXqWqs7Y69HTG1gh4jjXiYgY66ophYCbSCR9qn54isbdww7eO8l
         JbRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.51 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.51 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2911:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3870:3871:4321:4425:5007:7903:10004:10400:10848:10967:11232:11658:11914:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21627:30012:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: cloud50_26c80822f4152
X-Filterd-Recvd-Size: 1644
Message-ID: <e82d25e0d82a55eba1097eab3c679ad5f667e999.camel@perches.com>
Subject: Re: [PATCH v2 14/14] staging: iio: Remove ad7746 from staging
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>, =?ISO-8859-1?Q?Hern=E1n?= Gonzalez
	 <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 15 Apr 2018 12:24:23 -0700
In-Reply-To: <20180415164351.2666a114@archlinux>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	 <1523637411-8531-15-git-send-email-hernan@vanguardiasur.com.ar>
	 <20180415164351.2666a114@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649768754128760?=
X-GMAIL-MSGID: =?utf-8?q?1597841363563712016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-04-15 at 16:43 +0100, Jonathan Cameron wrote:
> On Fri, 13 Apr 2018 13:36:51 -0300
> Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:
> 
> > Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> 
> Please have a single patch (with move detection turned off) for this and the
> previous.

> Allows easy review by showing us the code but doesn't lead to a stage in which
> two different versions will build and hence probably break bisectiblity.

Moving both files in a single patch is fine but
move detection off is much harder to review.
