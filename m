Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525859398; cv=none;
        d=google.com; s=arc-20160816;
        b=u3kf86JZZcqAhR/TIBjDzKOIPX5NDp0VH2rat0gmGa4FRV4yFqOlRd8BN8Oca1ht3B
         SNmuA/LQEhZjAJ3MgriOzEx4+nm3Zs9FUJduhu4dJLcjKRV4q3H2gRahL85svFk2I7uY
         ut9YsH5fWl3MMzGhXOPRM2e3gE8w0KTBDyBqD+7/oVNcH4hQuSkg8aQxEkQ78j6R2ees
         /0e02X5gKi8vpYb+2ImJAaoxtAc0Gr7yO1pYrueRaYJEG+sROctbXJbl+lIx8ER83awH
         04X2dQPOpBWSAbJJQDiNiE4nqpsCs/lAy8tgRxYgo9fu1EYATMAtze2njXdg/c7Npn+2
         9khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=BonEpCIJuQqCQvPTxESjTWAyXToyXaahMC7D1fs3T7c=;
        b=MjfveqGh2FfL/whG/QY3hvwOGCZlg4/733U00ItNuOX4UifNTfGmplxQMKxMCTsQYB
         dKwoH2BcC1J3wmohBRuS30UOkOmCvDlKmVv53Ubv+5u2vXe9CENA14k9ZK2dsm17Xzhg
         uMLWfuwggspgmltKVvGWyK3dVrHSkggIscgj4ab9qyj0Os8S1iSYvHQUd1ZeRRZJtsoR
         W6KuRP/tVU3MJyfofWTutsKYeVrw2ZRTH4GVJOmOrjT8pFVOwm2L6qUg7P3a6roZnlxd
         6ClLY52S/TP2/ndqXbrvy1miw+JA0Rw/7KL/D/kSG8Q2yHbk7KJ+VH9B7pTQ87B0UMSO
         +80w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PjldlnVZ;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PjldlnVZ;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZqumavJJeSXqUFcqFBBvJQRwqY+cyNkZcXbrp8mVsXf3hlVLwCirtZqLmW9T7x3V1RjMph3sw==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 9 May 2018 11:49:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Tony Lindgren <tony@atomide.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: Serdev runtime PM (was: Re: [PATCH 4/7] dt-bindings: gnss: add
 u-blox binding)
Message-ID: <20180509094957.GB2285@localhost>
References: <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180508155608.3bzcbepsmoskhlox@earth.universe>
 <20180509091831.GA2285@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509091831.GA2285@localhost>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599977567023696204?=
X-GMAIL-MSGID: =?utf-8?q?1599979544444273535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 11:18:31AM +0200, Johan Hovold wrote:

> I've cooked up a patch which I'll be sending as a reply to this mail.

Forgot to add the in-reply-to header of course. For the interested, the
patch can be found here:

https://lkml.kernel.org/r/20180509094419.13470-1-johan@kernel.org

Johan
