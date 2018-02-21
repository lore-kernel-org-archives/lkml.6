Return-Path: <Jason@zx2c4.com>
X-Google-Smtp-Source: AH8x225ugIX7zAdvwFxuSdVM4wH6cOuLmxLr9itEcBgQQPYVZmUNhpJevsA+7pYrBCC902qbbTNT
ARC-Seal: i=1; a=rsa-sha256; t=1519182484; cv=none;
        d=google.com; s=arc-20160816;
        b=Dp5oep/+tKSRi8VRG26r9R+yickQie07DUHC3Bwb7Oi3y5IXiUpoxn1d93mw/PnxnD
         vXQEDRo0Ts5q6cQcfKHUf/aifT4GsDPPiTbqtIwUJTexcxS/NYmLE+S4Y5UtkzJUfXCL
         xsjK5dIhS1bv+VSVRvNSA0qbFvgOqE6jCvSfYxe5tz8r44PSz3gHxv1T2btYWHH6aAVu
         22hV87eXHijinCvxDgK5Fl6VqnH+2+WsCtIxg0xS1/wagzBr4aUgRLVBAaxn4+3sfpYM
         S1X0uD6XOYUhMNM/6WemIWmRYtmpF3UdHIrL7p8xkeuhqA8/RpYEOqZrga7b+KR2NWS8
         8Gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=uKgFkudF76iYuS+ekiTDNPpchtWyYpxmnfAw5a/tIjA=;
        b=CI8MNNLxWnv1x+gBDkNpbREzEVBJK3H2OS7fBkQXds0COdJppVA4APGUM24toTJfe3
         Jc7RArjAmOLLg02kOEjkMFVtKMjExXBWgrb89SwXrgS2NdGs0mcvPVelQGPIiIoR7Rcf
         DjdycC2cNtP2x5AOp2vUCaUA/oRMSM/XhACPwiy8sd2zSCU9YJJyTiOnlyTRqFRdo1wK
         /KnTW193cVrUXzRvf6tnEEd1il1Vdjw+KHgIRZvzFjskYsgPsIgeChHbbnBZHshIvbei
         XLuSiE0lxEN3UmcwZzvGdArDlr20tPHnKzkIbN/fV6yqCdh/WjPOcV8YPkgt6BMiQMgV
         sIoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@zx2c4.com header.s=mail header.b=a6oye3ph;
       spf=pass (google.com: domain of jason@zx2c4.com designates 192.95.5.64 as permitted sender) smtp.mailfrom=Jason@zx2c4.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=zx2c4.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@zx2c4.com header.s=mail header.b=a6oye3ph;
       spf=pass (google.com: domain of jason@zx2c4.com designates 192.95.5.64 as permitted sender) smtp.mailfrom=Jason@zx2c4.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=zx2c4.com
MIME-Version: 1.0
In-Reply-To: <20180204220746.12441-1-Jason@zx2c4.com>
References: <20180204220746.12441-1-Jason@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 21 Feb 2018 04:08:01 +0100
X-Gmail-Original-Message-ID: <CAHmME9pFFjX89ixw6Zqv0J_7eAd8eGyzUzTU4zzGOnc1e9XPfQ@mail.gmail.com>
Message-ID: <CAHmME9pFFjX89ixw6Zqv0J_7eAd8eGyzUzTU4zzGOnc1e9XPfQ@mail.gmail.com>
Subject: Re: [PATCH] random: always fill buffer in get_random_bytes_wait
To: "Theodore Ts'o" <tytso@mit.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591509863893639891?=
X-GMAIL-MSGID: =?utf-8?q?1592978293139936074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ted,

Can you apply this?

Thanks,
Jason
