Return-Path: <kernel-hardening-return-12928-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+KXz/iQZZHunJ/FB5N9okVibRZ//jXXoO2d6VejZsH1svRELIkQp1xawHmhYUM4cMPw/vL
ARC-Seal: i=1; a=rsa-sha256; t=1523282581; cv=none;
        d=google.com; s=arc-20160816;
        b=KS2DOU+jQMs7pz/30ZVD7Xhv98gMnVl5ZpsznJa7pTatCZvywRCzCn5meC+Z8QIHQo
         P7qpnuUIxfQgTc54A3JxIrKOzc2k9W464NmqymKjND2Zu+RZmfRDoh5D6zRH4L85bgm+
         2G5E6mg6CoRbQMr1W0ahShtQm3ZZynP37LFKTDl/hEcxUkndwoUsdPbZ1YWSHCkXyc06
         OrQVL40FRE+IcG9POakE4CNzD6d6OgRDYf+VF+72qQHftXrgYErON9q+rZMnJ6oS3zAN
         xKQwcDwqz4v2L3bAcdsVvFKwz4IZAhYALSz7Du7Dwrk/NIxQuIF2h0S8MHugVsgQbqM5
         t1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=wVxLk5XDpKzBSD8oOYw7w2fDrsS34vP/P+S5WwEHAv8=;
        b=qXDC+Pdl9zSYfCnx9cbRGlSh36fVKxvs2oxOAI1VxgJm0YhKnf00PLbbn3r/Whqf3d
         mtc2aIGLsm6cjfS7BL1BtyPNjd3IRJFLFzcq5SJr48Dc4DkK4hb7lyEeiWWNDVouSk4I
         I7Ll791LRRZxgbv+7zgmipFXKhr4SAbrJcyIiLtfzPGUy9rFXHPCHMYKA8z2utd7WCzn
         q4lqw7gg8fQ0rVLCvvMscCGln2DePtuXhpzVDXClSreFClG3lRpmCu6ebFzSmIcj6+ZC
         Uubu7SBnYLV/eZRsiuUlc03NWy/refvOcUtfTlJ8//eIPAF/1laaORSIDWlqVG1P1nWP
         omZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YR8QRVlK;
       spf=pass (google.com: domain of kernel-hardening-return-12928-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12928-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YR8QRVlK;
       spf=pass (google.com: domain of kernel-hardening-return-12928-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12928-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
References: <1523282044-22075-1-git-send-email-s.mesoraca16@gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Mon, 9 Apr 2018 16:02:22 +0200
Message-ID: <CAJHCu1+68h8n8EZNk=V8uv+=fGfpy62Xq6q4Dfjw8p7Lkbo8kw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Remove several VLAs in the crypto subsystem
To: linux-kernel@vger.kernel.org
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>, Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Eric Biggers <ebiggers3@gmail.com>, Laura Abbott <labbott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597277047906530259?=
X-GMAIL-MSGID: =?utf-8?q?1597277555754202795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Please ignore this thread, I sent the old patch-set again by mistake :(
I'm sorry for the noise.

Salvatore
