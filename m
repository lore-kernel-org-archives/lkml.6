Return-Path: <gilad@benyossef.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520519248; cv=none;
        d=google.com; s=arc-20160816;
        b=0nNmUAKaSZD+UdLWxdgcWDP5eSKVZW7/xH5L6ZZxVPfILxVrNshiPaaBfusg90HHsO
         iqQaOc0g1OcTzrMopz0Qbknz0GQo5DNDlPXzYe0yG0icWyAeVM1i9pSQoBbIsLmtVYNg
         66kTUD0X+J1qBPJyIli1uhht+xSyG5XaMUZO7i7Wj8JHJnjT1EKEHJwquwh+CmCC5cx5
         4zRHx4hAnlGiKw1VgkM10nAZEh6cGcMmK4p484vss/Wykb9CYnMnTJC4Rk5RCnUvxCMv
         6usKHKtzZtDwQwZGeeA6hTYQVf/szS/kJGLVoqwXa7kX2PCkVcvy8lRIrRdeb0yoIqqe
         gL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=NNhUR729TnUryzhsqIfUb+kAPfu6iOjdFZ+Z/Ix+0ls=;
        b=pHz+5a0doKnn7YkXFiN0smaVyUVKQ8iElQgUXLG6QrSds+hsgElZUGFb+ivz1n0wJ8
         4x9xcZmRhtcKT7Tk9Pg1AHm46s9jelpg5ebUV0OKEGS1UuLDUdRt9BzYvD5/mwcu5z9l
         3ym+y/itzPc/YnMSstcmSYTIn97gbaSWxIQcSvpsQS+Yxb/+SEkT4p5C30Y5UwKeax3W
         UYrhSUanD6uCxYLcmP6ylLgI7QX2kzXf00i8o9opa4IBdwfk48Ks7Q7HZityuW8ReiQx
         Hb49QT0DIVrGj4N1YjJqLd8m7qJv2WYKtXle5+b0BvtIaTDCLDbMEx9IfIUHW7jbfiUY
         5Idw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@benyossef-com.20150623.gappssmtp.com header.s=20150623 header.b=cK8nFZ6+;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of gilad@benyossef.com) smtp.mailfrom=gilad@benyossef.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@benyossef-com.20150623.gappssmtp.com header.s=20150623 header.b=cK8nFZ6+;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of gilad@benyossef.com) smtp.mailfrom=gilad@benyossef.com
X-Google-Smtp-Source: AG47ELsD+2aRpMO/ZZ1FEmKuYi2oEV19WHnbx9egejnReSsaZXl3qQ6YnP9ZbEOcoH6K0u2zDfnLuII81UxSs1A9CQw=
MIME-Version: 1.0
X-Originating-IP: [217.140.96.140]
In-Reply-To: <20180308110819.v4zfw6iru2tg3ssv@mwanda>
References: <1520498678-32175-1-git-send-email-gilad@benyossef.com> <20180308110819.v4zfw6iru2tg3ssv@mwanda>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Thu, 8 Mar 2018 16:27:27 +0200
Message-ID: <CAOtvUMcgyfgwtiNqe5CBzh9wDrLO+bnoLr356UxUZ5DDD8Fr5g@mail.gmail.com>
Subject: Re: [PATCH] staging: ccree: remove ccree staging copy
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, Ofir Drang <ofir.drang@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358433276712536?=
X-GMAIL-MSGID: =?utf-8?q?1594379991607142862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 1:08 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Congratulations.  :)

Thanks goes to you, Greg and all other contributors and reviewers that
help made this happen.

You have my eternal gratitude and a an open invitation to a free
beverage of your choice, adult or otherwise, when we next meet :-)


It's worth mentioning I'll be giving a presentation next week at
Embedded Linux Conference US about some of the surprising benefits we
got from the process -
https://elciotna18.sched.com/event/d47bcefac0cd7dd456ad35d0f6ec9159

Come say hi if you're there.

Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
