Return-Path: <outreachy-kernel+bncBCK63FO5TUHRBLNNXPKQKGQESRJ76AY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521407662; cv=pass;
        d=google.com; s=arc-20160816;
        b=wGs6fTbWSS1Bb22zEDRj1VeXhVp7zMg66L2MTs/BFvrCtw+BRt96W7UOL07KE1U942
         olg3DmI/wqNplZf71DmLu20woowNK4WEK7Yecl2sHYPXmymxL7deaY2LNVj5KP7sLNAT
         YTyLJwqxZGviShEhtUqRr7qHSpTMbXIgTOi+DzF/+euI8nntpaCSC22y/6qeLCX+3TOp
         DFdHfW3OPLckpGGFqQI/DC0pI4VYwf6AcuEGBCj0mqkmkxy7rBkZoYVsmRB20pZ+rijE
         19CYD8IwJXa/GyNwAEyyM9kGZ/1+2PKbHwkl4fJWjV6TS1Q6DZUPFgKtzI5HoP2h144m
         97rQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=ZmLu2q7GVYBUv/4jW3h4ane79pmPsohWLM4nXXLJfpk=;
        b=Y0QCW6yVPXpVavOKNEGkUI+KpG+DkYH0KKg0J18HSOR3IUR1X1qEG8ylUtBtiI6wKt
         Lm8tfi6VF9OVjUPmAxbMqaxmb/6+yNot1S/EveyBq8RhHRKscRcxwP6yjvhX8+ROF6yZ
         jKScz12YDOS44LIFs/cCvEcBlTT1vDapPZXZVUkTJaVlC0aR13pUN5Jy/BmjDo1Z7sc3
         8Bn5dhXG6wnx7sP6rsgYx3QoGPHvo0P4lMUwtNY/7gc1lvK7UPKnUcPnOw2i67MJ1XUL
         zcmLQD4uTJ+hzdIfEo9Q3QiBhIDTgD59Hw3XVNr3Mft/ycCzyAXzC/B5j1QPAPNToRP5
         vpBQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=ibWjgxU0;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrblnnxpkqkgqesrj76ay@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBLNNXPKQKGQESRJ76AY@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=ibWjgxU0;
       arc=pass (i=2 spf=pass spfdomain=bootlin.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbck63fo5tuhrblnnxpkqkgqesrj76ay@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCK63FO5TUHRBLNNXPKQKGQESRJ76AY@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1521407661; cv=pass;
        d=google.com; s=arc-20160816;
        b=0hvfaZ0vz8MZA0meVZ5aRpOytGuCwoY/KvBsozTFfrO+ssFdTG9YeJEQwq7nBE/vSX
         MHHmbgsGG6HPI+Mt0phWjarvd8U6y0k0+ajurxQ/LX+Sf0S6570eLCCA56/X8ZlZoxWE
         d9SN75TOBBx4h5vbP8MLhHwAhrZKlwqg3U7nWcrwgZxElPFOlquaxWGzbbKkXCwvEJ7K
         9eGqbVD/n/pPDimDE1eFefr8cueV802ryJdhW+a5SZmQSaWbQrS0o/hvvMMOu24fYWWp
         jdQ7MLroQ77mr0O/2B9IFC9yiancQpaoFhkMS1ZLvK+uG+OIAtyB1b/IXgpAHyBXZPtM
         9ihQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=ZmLu2q7GVYBUv/4jW3h4ane79pmPsohWLM4nXXLJfpk=;
        b=rbMloLEBZq42iiwYVYi3YdE1hMoppBoITBtwePH+0BJuO3szWIWNCKror/MatkOzmp
         0V0Kx9BeXfR+RN67SCMDHljPh7qivvecN7Itxk3+ajIXpFekXitkYN58o4qtQEPOYJl9
         lQ7ebsZ396FYwwJC7uFAvlKg3Z+IbM7O84Ki6NN4wibqWIDTprbhHhexE1pQLYKwBja4
         uA+QQWF7+3w/zMKJNkE2Te7HUbc5/T5fi/PqedulE/ZrDsf83TBpUI+kMadRKa1IfI+w
         nASLx+gP1H1bsYFlk0gYRl3yfusuKVxrp3TJvkoSGtLFGT0Dax4oNBpV9z3JbcbInTcA
         obDg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELsoBWoUsmQqgMjPk9xwl8QR1YRGaWKSJOFP9cq6vaaul1elQ/H5JTdyr53DUDbX6facwNv0TQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521407661; cv=none;
        d=google.com; s=arc-20160816;
        b=DovOAsoajsEU8BhRdJSEl8CPS4sDikVeA7ADTi4pyjAri4HJpCfEdUQmWnuGbWfWpR
         ixw3ZO/BGqsX5YCnGpZvBI7LjmmJNtAP7W3Ztkp9l8M6PFtlNz66tcW+ltSU72YVjyCq
         m2MHiO7QJI5oFEXP30cURiZ55SIXw33Gt9lJwpCqSRO3xwYDIWhAruPPgsSa4uf3FQbn
         gXkjdczzSQuU5o+EZv0uVpJ23wWIxX8xEUlkJGMUSiBJ2HtIkVmHW8TrAmSfuD638yjy
         MWTpcVVc9LbFbKMpuGHVORJcJr1e4sB1popG9F1ZU3GKC6rDr2JYL9a1oRyRGgImzXu9
         7vRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=WpLFhoYijHIi1Q4dfm0JS+VIRnwsOiLsJ91LTFfzh2E=;
        b=bnd5hRf9H1bBV3371Ruhl5aKbvF4c5PHwCF23NLGriiezZNVym2F5HUyTapSSK/jzA
         oP8I4cdhmhr1H9J2ykSjKGUKfzOkMXUxEz4Ey1I8d7tSu+s3Mq4Mq/AfxKNTK5GxB9Cp
         KKBt2gYBQyccbZFRSqXqqXcuLjCZKZoq1+MaEfZrhMMDyUn3w731AwnGvXWLtceybKsp
         wXt7tP2cVmiAd/3+JvndzZIydgStj2Iyy0ayWvsYIgx6ycL6YZua7ILsBdT4QoaMKiGW
         OkmVuMVU7gENsuSUymd4qGh2YrWiJdLxN+oNwpnKUKZlHFzidqIiLK4zrMyYonAYoCj9
         Uouw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Sun, 18 Mar 2018 22:14:09 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at, dwmw2@infradead.org,
 computersforpeace@gmail.com, marek.vasut@gmail.com,
 cyrille.pitchen@wedev4u.fr, maximlevitsky@gmail.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 ezequiel@vanguardiasur.com.ar, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH NAND v5] mtd: nand: Replace printk()
 with appropriate pr_*() macro
Message-ID: <20180318221409.65945850@bbrezillon>
In-Reply-To: <1519317082-4790-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1519317082-4790-1-git-send-email-shreeya.patel23498@gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1593119442965474552?=
X-GMAIL-MSGID: =?utf-8?q?1595311561170376990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018 22:01:22 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Using pr_<loglevel>() is more concise than
> printk(KERN_<LOGLEVEL>).
> Replace printks having a log level with the appropriate
> pr_*() macros.
> Define pr_fmt() and remove other additional macros from
> the replaced printks.

Applied.

Thanks,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180318221409.65945850%40bbrezillon.
For more options, visit https://groups.google.com/d/optout.
