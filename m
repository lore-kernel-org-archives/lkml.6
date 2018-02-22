Return-Path: <outreachy-kernel+bncBCK63FO5TUHRB3GKXPKAKGQEBTTC7TI@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519314284; cv=pass;
        d=google.com; s=arc-20160816;
        b=Rc48/KwD/d3NTwxAMyYHY+PsLY/089U4zMyZzxnNkfUmuvigu/iQSIgTEPBpD9ZroI
         F51foaOTAE7SUvYrptr4CnGgjD30IriIS9QkAaay+7sHNqxbH3DH5CFFNX6mvVOcjvKb
         TpWPknjHVGA0x2wjf4X5Rf8xZVbLmYsLl6+lHvQOINVQgzqpIhlIgW0ngwth9qxolzwi
         jVi71SeT0b638OPBgzp0SudLnc4Eil+aK5NEnZwg3DGOBTT4xsDNgkIW5QFb++JygU4n
         AiYowZPmw0DW99PG7/rwCeBRO45oPziYAO+AY1ceSAjDKRMx4dA4YZRB2oE939pFSE7Z
         lVYg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=vn3uKWq5kPlnNMmOpztZD/pZunRoxNazZ21TIRD4YhQ=;
        b=GXVZVcUrbXSSl76PTQ/QzYNpFL/XM0TiqxKzajJEWnvBZfk+lbNqNJZ7KrBR9axD4j
         xr5icyGynygghJJYSVuHblFszXJr9cDF+GQN/DoJvTaCh3GDgLWV4NkOLi+CEvgq0NWV
         2F7ABdRMHN/+K6uutwSIGw503ptZGLKZvnSOegaxamkKxjgrUFC9yHkuULi2Fhq6XDlN
         LDJ73QFT1tRtc9BlpGTvLhtZCzuNddY4DKeK/F3bAp/cUz3pdv95kgDaWmghSrYsHQC5
         OAvC7UkAfjX436+TDsg/ZcVm4PAkPehi7C4U6Oguyf+Sek+4ODVThksHqEYR/yx6mdXo
         BZbA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=A2gk2CHA;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrb3gkxpkakgqebttc7ti@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRB3GKXPKAKGQEBTTC7TI@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=A2gk2CHA;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrb3gkxpkakgqebttc7ti@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRB3GKXPKAKGQEBTTC7TI@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519314284; cv=pass;
        d=google.com; s=arc-20160816;
        b=jjxvh+eRRCqtooX+70bwCu+ZeI+x7nuk/R/SviqGIW9sl7udtw8OB2i9yqYHqHeTwa
         mdei/s7ZUs4GqQmPgM2ccff88nFKxsI2U49DwJlJpsKpMgeUr3I7kT2ES7BdHyMyLSHl
         jEWyyjMywFJkInuh0wXSUqV9Y08e/p2sOUYNEBKCk3FC+nMAH7EwY407yW8biL005K0O
         DIwUrREC+ge7EeAyRCsGj7zSPgr7v0ldPPCS08qy8W0A3zGMTgVUZqeGxqhOIk9m5pTn
         P+N4NCudzYZfX4XN41Y2fhB+KsNZklKuTJd+YDPbtHsG4kEYmVBeYqN+19P9tHt0dkfK
         5pxA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=vn3uKWq5kPlnNMmOpztZD/pZunRoxNazZ21TIRD4YhQ=;
        b=aSq9xAs5rhu3tBLUBbFnSFnWTfMqoLq9z1Q8ocvPHHmOS7MMcGrStVP0RXtnNEUR9w
         ImhIxqHd7dfbd+SZpgzG3xYNW3kT0552UKGwTUUxwbGR1yX4jHnIUBmQsJOEGDGU3DEj
         z14Ll2KWSkcjnSDXtNBXf35XiYA8HgQjxlibdMTl/vtf8m0+c2DrBTjig0zbD/uPlZpC
         W9W4jhSYpnyYpQAgyIcMyWI6dUr4x+aRMDNoQ/5XsLsYyXN5cGDJWe2GakLCec93usKW
         U3ivmi5E6xSH7Jh5CUMZAPPp2rEDlbEQGmsKM6ll2Cka3PQN1c5NkiExzo6wSBXJWRjj
         CItQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AH8x226+QVbQlfaddCyvgzbnAIk0SxPml0HfHFlOiOXeUOQY9eVYcevpoJA2buN1/69STAxkfXgV5g==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519314283; cv=none;
        d=google.com; s=arc-20160816;
        b=wrryt5a+DYU/obTMsTYAs/qwWIZ9A5L8ocbzIcI5tUVgLbQbLpD8IM5TFcwh8tX+tW
         NOSoKqF6xhr8+82ENNCEDxRmO7dUfsx9n3iakpmor7qCbMbpLzQ3G8DPaJjHQg+q4Shq
         rINnux03zDtR+ACVbThojACgHqJ8PnkdC8Y03xd6jE7QCQ5GF3LYUw+ZLMVFS6PjXAbp
         hEPJgNxBETUz9XfpCk7b2MSJWGs3K4BC3OnhDC94MVV94i2NJNWxIF+cmvuE/JJc9VSq
         gxvMZ/FaAdZslPx60nyWs29A/TWY6Hn4skLy5o1v5TLQlcAv04ZQNIJWuKDQ9aGSh/dR
         NuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=e6IeqGWPKTXZjEkjB4GrMjtFmEpa6TUVCevwAXm8iTI=;
        b=qKuJqn4ZzM28teDkebGQE+hXSo4luM40D4UfJOoY2U73MTIuVrko3rqX2yeda/8FlT
         EgorPymdcu219mkLpHT1YQJxMi8HsUOYUVziEOT/QyV5Tf4gE9zqPDY9TPgksie5IIF8
         jXdR/skRGhBzSz9X3WTfC37ZTVeVVE9JEwZamRx1T8oIkpB9+QbNyojfWSesHMgauORf
         nJPUdDg/+z9As75o2P2tBzek56S5k11cPV/enTLEHNPfjFNI56DfzfKMoDhKFUpY9Bz2
         gJbkmaMvTD62++Ih5Rkx05mgG9Z/0rA27CZnYpEWewm9uLBK0I8aryTDlD9kBuanyVI0
         A9Fg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Thu, 22 Feb 2018 16:44:32 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v4] mtd: nand: Replace printk()
 with appropriate pr_*() macro
Message-ID: <20180222164432.0f2b1e56@bbrezillon>
In-Reply-To: <1519313367-3360-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1519313367-3360-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: boris.brezillon@bootlin.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as
 permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593115543103484483?=
X-GMAIL-MSGID: =?utf-8?q?1593116495323959999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018 20:59:27 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> The log levels embedded with the name are more concise than
> printk.

If you don't mind, I'll replace the above sentence by:

"
Using pr_<loglevel>() is more concise than printk(KERN_<LOGLEVEL>).
"

The patch looks good otherwise, so I should apply it soon.

If you're okay, and Julia and Ezequiel are okay too, I'd like to move
to the next step and have you work on an ->exec_op() conversion
(jz4780?).

Of course, that does not prevent you from continuing the
printk()/dev_xx() conversion.


-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180222164432.0f2b1e56%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
