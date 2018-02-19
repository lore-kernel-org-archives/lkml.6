Return-Path: <p.zabel@pengutronix.de>
X-Google-Smtp-Source: AH8x224BXVQJMx6tvmI69hv7K1sJT3e+EgawWn0NIMwTKKjJaVTO68q5FFMSUYPQnQ+oIluJ5JVF
ARC-Seal: i=1; a=rsa-sha256; t=1519050246; cv=none;
        d=google.com; s=arc-20160816;
        b=h9Yu1v05Vj1v4F7We5r187DaMeZzHjGb0XjmOXziJU16uQQ7327YdsCAD6aqWqueVl
         J2re7iUalZX+ADTpW0dH3dWYGDVrbm/N9VKEXqcVkqA7Xcx7I8MOGPZRSM936t6oZJVM
         2QdNLwS+Qopwj/kX07RoIYpaezTa5koKGrM+YNZqYd0qCbqq1wQiuaerVrbPNmGwkMfg
         KqOP7OiBnQ0eLzEK8okVTed/fwDqvvB9JJBhK7jmKxeiDPqqTEqIoF0AG/AhOKIdKCX2
         mSn6SqfrTlIUNDKRPQEW3BzGoacQvz8dvXHVP8RaX1+I94TSU5GRrr+qzeLkc3a9j79Y
         Hsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=V5N4DgxhOD062kjla6krHAG0grTHKZCx+Znkmwrv7qQ=;
        b=vt/yZZBDU0/bUFsdjCgFs/yVD0O18etySamkqrtBF117+R+YpPS0dJ0pDAkz8nEd9q
         uAwKToP2aHHvkCFgjAnN63oANJuym5e8e67qLUSE4vUXuazjSgotSKimuMjP5Sj1czq7
         MP9ozUgsZ26ybS0RK1yd3jbvDXI4cwlDH1K23sv8hx35R1mG3kzoHisIe+7LZhtaIbe+
         L8aCdPbe+atFlL/wq6/3V97ArYTtoKdUHmyX4Ovp0ICljDddHmnGA81c8QrfXqH137VK
         4WSU4zr7fv6rr4/rK7TLX4nU5sOYPiS2kCCKhM/8JhDRp4aNZ5IfQfs+KXaV7eEn24im
         3oAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <1519050231.3408.21.camel@pengutronix.de>
Subject: Re: [PATCH] staging: imx-media-vdic: fix inconsistent IS_ERR and
 PTR_ERR
From: Philipp Zabel <p.zabel@pengutronix.de>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Steve Longerbeam
 <slongerbeam@gmail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Date: Mon, 19 Feb 2018 15:23:51 +0100
In-Reply-To: <4305212e-5946-0bb3-1624-ec23a0f37708@embeddedor.com>
References: <20180124004340.GA25212@embeddedgus>
	 <5e53d6d8-d336-da37-fe12-0638904e1799@gmail.com>
	 <4305212e-5946-0bb3-1624-ec23a0f37708@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590432494114663836?=
X-GMAIL-MSGID: =?utf-8?q?1592839631006342518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Gustavo,

On Wed, 2018-02-14 at 14:57 -0600, Gustavo A. R. Silva wrote:
> Hi all,
> 
> I was just wondering about the status of this patch.

It is en route as commit dcd71a9292b1 ("staging: imx-media-vdic: fix
inconsistent IS_ERR and PTR_ERR") in Hans' for-v4.17a branch:
  git://linuxtv.org/hverkuil/media_tree.git for-v4.17a

regards
Philipp
