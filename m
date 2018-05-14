Return-Path: <justin.skists@juzza.co.uk>
X-Google-Smtp-Source: AB8JxZqM98ykuR4kbTD8JAuX9tltqWuV9wO8g31WgpuEAB1YiRCWzbdDwCBhmuKjHNgTi+wRGWjl
ARC-Seal: i=1; a=rsa-sha256; t=1526305940; cv=none;
        d=google.com; s=arc-20160816;
        b=Ggi9Uy9sFjWoIdu69/vf9wzeqlJW5CYpxa6X4cSwYs0VFpIF6xttNI753vARlxetxM
         kl7QdDx1qyuGra+DTTuqfivbXTGrVcI6okxCIqL40wNfFFZiN4tcXUXq/4/PfdCMS+Zz
         T1HsTYDy4LpDzccmR7/VDChk1youYuUdG8qw/l2Y6vRRt52uDBFs4yOQr1Vwx+8ADlas
         RxZQ/yLF+mlv/soF2EEbFXGKA19oR8B+pisj2zu4UZH5sSzrEsml2f9NGrf/fNCBpk79
         Wb1Z7KX1D5GVr1uyKuLl4xoiK0BcF7hgceJlUDHnKKQg4YOcH5DPkbuBay+3OdRh9GNH
         y4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=importance:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date
         :arc-authentication-results;
        bh=+/O2IDftlo/vvlb57EF2fEcstV3F1DyVDfCSuAIWI1Q=;
        b=nIza4wpAuIqwQE/8bFVtdWutok6uPKPZEaczg8YwIn+rX+fgVPw6a/5M9grHaStxty
         UCHT1SJ8qlz+tDJpMZJf+O/bTPZS9rFgM1BdFkzjxbcirwWynpl/AhnIKp1gXhrSjAVJ
         btAqrQRO7kXuno0/CmOVeI9WoDEMK0MMK9j0GidUDi0xKGQ8qOTfJsGFQ4w1ejDMxlzI
         5Q0S+7yUsIfk3ZDkFia+tJ+gKCaWBYswSCEI7PE6hPsCrBwt1grwFXZuBLpeUgPyi1sH
         8PLJXk7y3VkHdHr8JLPpZPpjrtl09Eo/zix/zOhnd7oS2OSkYd2PqtImqYo9DZg9SPl7
         HRiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.74 is neither permitted nor denied by best guess record for domain of justin.skists@juzza.co.uk) smtp.mailfrom=justin.skists@juzza.co.uk
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.74 is neither permitted nor denied by best guess record for domain of justin.skists@juzza.co.uk) smtp.mailfrom=justin.skists@juzza.co.uk
Date: Mon, 14 May 2018 14:52:16 +0100 (BST)
From: Justin Skists <justin.skists@juzza.co.uk>
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Cc: Todd Kjos <tkjos@android.com>,
	=?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	devel@driverdev.osuosl.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Message-ID: <121696744.206121.1526305937025@email.1and1.co.uk>
In-Reply-To: <20180514132945.jofe4rb3ml4muusa@mwanda>
References: <20180507011328.11982-1-natechancellor@gmail.com>
 <20180507011328.11982-2-natechancellor@gmail.com>
 <20180514132945.jofe4rb3ml4muusa@mwanda>
Subject: Re: [PATCH 2/6] staging: android: Clean up license identifiers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:wH8z8672KceYMZleFAxQG/SnLko1OKtqJ1OwNLGIp/C82tMdDwj
 wIJ85UpElTZOsBdYyOZ3qpb2CkIQc+yartR4Q1I0v9G/SNRlItea+0LoZDiFxbXZBexL3rI
 28WxGEk13K0vX5Yl+wTserca16YXwPox8St4grFJzskQuwGrc7eNBK4vvS5H9LmrdtaVzHp
 ateRwmNDKKRC/6uF4aXQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2izQGQi5Tyk=:PpoMZjANEwpSNbgVVNSa/o
 /SkVURc/58Tn3D7+x7P0I62WXifb8dPs+QgieqFWpZ5ifkkXqARhX+/JQ2EGxERFpBqK3uHdZ
 DyU4BaAXKwlBsJmsHd4RAjxB0r+KeC8DwVfriKUqG/mcj4bXf9rx0lokFPZiqLtTaTrbg4Zo3
 sNTt/a+1rYsUMrIaAs0ooeZ/pDqHvgbsIM3sObpCTcj2wAAyjBuZzVXSBOT8HKV85hprC2yMy
 Q3qbcaSA1vAf6xH/PdkdZkSdTNVcu8fle86Uat3K9E+p9Vy6fACfmXOTuoZylXnOgGiRyKE2H
 Jsa3qfT7ul58G0wfnhDSuOzc5+YuRHSN9J6dUOrUG2rkmSw50JBF1HqnfkeR8GASrsl7CFV7M
 iJQ3PPxBHiG2VpW2VGHI38frowFyO49PNp6oIjNmtT8XBuH4o1jIOIHAUlTK7pobzEsYJHbOu
 fkzJ9BTgWrI8W9r75z7p6seHyxr0bhjIMqNHkxhjnz7iTNy8Lvilp75wCJU43/GXBTXxRPdWQ
 zfiVh+MWU3aQVPjea2Ia2IRac31brf6HcjFMlebZ1Y3jPBUDwmSJO4HdEpPK7T19qLaPYbfWI
 Z8SkCKiHbpCkZX9Q4vMOF5XY2bGgbTqP7j18axtL8jjkAi2jAzOSvBS5ZskCr42qk7M180Bva
 XZ2s1Q5FhS5cm4Z/S/8iFE70vkCXf/7ZhQjfAsEnWBE0kYQcqGjLAEgn8pquwKkETuzKzaUzX
 7MLVpjbJ9OApMAr6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599765852290250435?=
X-GMAIL-MSGID: =?utf-8?q?1600447777606656225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On 14 May 2018 at 14:29 Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> 
> On Sun, May 06, 2018 at 06:13:24PM -0700, Nathan Chancellor wrote:
> > Add the identifiers when missing and fix the ones already present
> > according to checkpatch.pl.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/staging/android/ashmem.h        |  6 +-----
> >  drivers/staging/android/uapi/ashmem.h   |  6 +-----
> >  drivers/staging/android/uapi/vsoc_shm.h | 10 +---------
> >  drivers/staging/android/vsoc.c          | 11 +----------
> >  4 files changed, 4 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/staging/android/ashmem.h b/drivers/staging/android/ashmem.h
> > index 60d7208f110a..1a478173cd21 100644
> > --- a/drivers/staging/android/ashmem.h
> > +++ b/drivers/staging/android/ashmem.h
> > @@ -1,13 +1,9 @@
> > -// SPDX-License-Identifier: (GPL-2.0 OR Apache-2.0)
> > +/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
> 
> 
> // was correct for SPDX headers.

Sorry, header files use the /* ... */ format. :)

https://elixir.bootlin.com/linux/v4.17-rc5/source/Documentation/process/license-rules.rst


Justin.
