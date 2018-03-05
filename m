Return-Path: <outreachy-kernel+bncBCS4V27AVMBBB5GJ6XKAKGQELNACN3Y@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520264437; cv=pass;
        d=google.com; s=arc-20160816;
        b=VPzIopvufA3ZVHllJ9bJQeuO9HlJf50kI6O/qu27GFSj2mvU4Gfs4n4a6yMEZO82o/
         5UEnR1FYF9lD505GS/PL/zVKwJN8VZSPzuJTOX0UUeGlBcL7BIoqlFFv05WVVxTwFHG7
         MwHmY++yY6RhmwwskJuUP7s3rq1ftsPSGVpTpCAiL80mVz0OhfREIebaM055WobIY42T
         G9fdCXSkTp+mUsqk0PqpoJJMUAp+cFsV0icUNOZjx/aIXXngpPVx5fkXEK3HNga+ud9l
         Qwfi5g+NHD2t0rufr3Gi1CPy6m2oIGaZRWpGVonMqwTptFQ3IUsjFRPz0uRXJhpAWIj0
         nsqw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=ZVKdGoD8YwA5RhHXYbnGtqiwkYFznJzXoiPNCe210VM=;
        b=O5dZ5x+Iw65FbRuevq4xjVgc9KbitP+dabOvZdnAsF9Yp96S7XxqjK086wPEct5OW1
         4Kq4Av44BLUGGjHBJB12Vk9/IH4q6ZqsLldIJQgxjHO+07k7VsZwjeAFOaxGRh8khQHP
         yrh0bJZuj0yz1/elx+5S/+J8L14vXzy9fzDR2oAVfUXYI9cdk7Bj0ZaeiT7FIvYvdpij
         UZdMtH4m3IpKddkrs4+RYis6yB3xyLdAB1dDCZNLjZO306C7Bto/y8pzAidNNe6B3ww8
         OYIZW5KMvIFhuk0bk9ZifsbyMEKjWO+clJqYqg+laJIP/ADBUqvXh2aGTiwtQAhRO3Jp
         SLPA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=rm07ml1g;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcs4v27avmbbb5gj6xkakgqelnacn3y@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCS4V27AVMBBB5GJ6XKAKGQELNACN3Y@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=rm07ml1g;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcs4v27avmbbb5gj6xkakgqelnacn3y@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCS4V27AVMBBB5GJ6XKAKGQELNACN3Y@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520264437; cv=pass;
        d=google.com; s=arc-20160816;
        b=a/ZcWd08OYke3I0947mbOCxM7stX9L+CL9R9hk1RntlmX2ywk1ZNvL/1Z5j3J34Usj
         /IYgOFE+LCvJey5HOBwvKYTaVZQwyNT3vsVn81kJ9GS5tZqj9onK/iGyI6nXPq97vTVY
         1gPbgSXxkiH/S+m/nUSqI+hk9suXm77wTPAc5FTAp07AhMhlRJsjj3KVWBkFXHKWis4R
         KRlq1r5QECp0Z5B7OTEELJUplDNqaC2M9QmomEbwPyKqI2PbeJqa0Rogl+IPJ2qMb0RR
         lBLnORbNfttxSLShGyk5Y/RJS9xnyJBBFI0i5xdhh13pu3J9o3/q3K/FMR0yH0lQ0bos
         mdyA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=ZVKdGoD8YwA5RhHXYbnGtqiwkYFznJzXoiPNCe210VM=;
        b=RoljGbrv/Gy4sNawJHbJEVJPL1S0OZ4bWIA6kVJJThgz3GFwuITpXSRLG8orGhHHlf
         zBRbr0mieLGsXIGEm9wC8Seuz2FEPu0JM8OYBQHOkz8C30pJXfwI/ccFbW5lrNoALIm8
         Y51qWiUJ75Z4RKF7WI3bJ0yB//MToA+QBJgEZK8dns2OkZ/6dY9vylIuV9UBLa/fnL1W
         TJkCCw2Vom2apRlVuMC4z+jZiNrHMXAamf+sk94vBvgRrG0MkJu/Sn99pXpafECG0NEg
         cB8SOk2aRzE43oG0urssGXFP3HwI0N7oKJHiOwudDfSFdzD0I2RtNpHNWKhiHuvtVAj8
         8zJw==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELtEdjsu/VP+8atlCIcSYbdqnWqCpDK5qxKljkqkwDjax8EBkOSPoBWIQxbZC1dhtF1dXij/Jw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520264436; cv=none;
        d=google.com; s=arc-20160816;
        b=OzI6ahHTNdiZqwQPKtymR17QvqVUGGrAJwqzpTDL9Yfw3XkdEv63czV/8behGY1vTV
         03tagHBem79i2/sZAVuSpeW4F13rFWVTLCTWrmmQHsj+ap2vXqROXwf3plbIJRh9enRm
         4JOP2GqIhwkRA6lk1EVIZN/iHB1ttcc8NClCDmyS2yDmE85iuy0SF0smOokONdr7z9QP
         ahgY9Zt4F/F45FK+4cAnikkitEb8eeZQKvqBU60DrlwTi1jhx1RT3aQoq2MTvgZZwPQD
         FN15XDvRE7XuzS34/KGfYmeyzzRB+eR171hlV2suyTKTzIImY1vh5kZKm9lxt5szZoPt
         qZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=4oRytX3hoD2dzJjrX49NPjYyK0HXFoD3F0cuwUF6bEA=;
        b=ipISREUAPX3951WAD35bcN7GfCPQFkoFwOePtfstzmZiz0PR/taBbLnEkjizgRSoLR
         zAfRFhbPA4L+M2Y03LaOCjRZc9hg400Klkyw/bZslzUAbu4bB2ta1EH7j30Sat9xxOvh
         5zmYUmRtHDffmQ2In+uRaCaAEtOY1F8oArnrD6BsFGEpCC6QNTKmpMCh0wZLHPIxY2SI
         jmnBrO3h9TSKfj9WucAm67ia4zzE8oCCMh2Zutqg0euvn8tihvUFtSjitoA3zYzDCsWT
         9NGJObP8AfsCrpyLVMMzAL3ZGnH61s2EaRXmUJ1fOT9usu52khUWMkCqb4aXwjUkWcng
         uJCw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: boris.brezillon@free-electrons.com, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH] mtd: nand: Added spaces around ('='
 and '<')
Date: Mon, 05 Mar 2018 16:42:03 +0100
Message-ID: <2872216.aoWXzO2rYL@blindfold>
In-Reply-To: <20180303140233.GA9634@seema-Inspiron-15-3567>
References: <20180303140233.GA9634@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
X-GMAIL-THRID: =?utf-8?q?1593925468888777014?=
X-GMAIL-MSGID: =?utf-8?q?1594112802978517874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arushi Singhal,

Am Samstag, 3. M=C3=A4rz 2018, 15:02:33 CET schrieb Arushi Singhal:
> Add spaces around ('=3D' and '<'),  to conform to the Linux
> kernel coding style. Issue found using checkpatch.

please fix real issues. Coding style fixes to existing code just add too mu=
ch=20
churn. Except for drivers/staging/.

If you're looking for a small MTD related project, I can offer the followin=
g.
Cleanup all ubi_assert()s in drivers/mtd/ubi/.
Some of them need to be transformed into a meaningful warning/error message=
,=20
others into a hard error, such as WARN_ON().
Review/understand every ubi_assert() and convert it.

Thanks,
//richard=20

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/2872216.aoWXzO2rYL%40blindfold.
For more options, visit https://groups.google.com/d/optout.
