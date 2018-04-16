Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917043; cv=none;
        d=google.com; s=arc-20160816;
        b=oqMIOJ5LtVFoo+zEZ8tEPUje9ykQnRxk6ij0TvM7DjBeYOxK33O+X65keex5u/Ux4i
         mewtRu93MVAcZe2o3rnul01rYyoz1EE1Mc91vRAk8TbDZrrRPEWW25XGxtP3WWmh/HlY
         NXiQKpUTud8d9iYlgfINLc7+Ml7gW9L4MKQkg1TgG2DRsZIHbgr3umrjrp06TEZmXIWs
         e9PcEJDgaEoO1O2iBY8JUwfNpGQqQO5uUvCJvJR+mi25LYZXUkfa5T2mTkq0v6sNsw/M
         oZB85qLdw/mzMMCYz7hd1icwynNapgSLZYZ56cn8F9CNmsr8dJAcNtpGmFqqehnaJk/a
         ageQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=l6+eAkep19u7QThP0uWEaBp/xOU5AE2AMz2r8pN6fP4=;
        b=PuHlTuLAqfuE5qqT/zhHKYcJgHSa6s0VoXrKFDD6p9Aq+yLauIkgFLVyHLmbU39wBf
         vqnQCtcJ0HhSQPWMGjjNa/6Z369T1eAmQdFzkdOB3t8Bw2mk33oI7iiWN459YNMFZMkp
         VYrJoqU/+sSRP9O4E2MD6lgjfwVowPsHWNl9m8YAhWta0KhTPVKNgwMfeOg1Rw8021TD
         VAxHf2rqXFR9euMHFXEjE99zr7B2NDwJexZRBkbWYeZ/zEA8aVLDupWXAkW26rCs2iOP
         HzRo+G6sD8jcjqv98qLJo3Wz+5SNMLrL2KEaP5qWhTp7whAkwSsIDhXnqLnTMuFD9GfT
         Tq7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dLmXwoJC;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dLmXwoJC;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48MQbKytzYfdwRuo4LJFqsgaIPKqwT0jRkSFckIVVY+EWxwpCdK/B5cqCdLgjO+eHiezKXpdQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org
Cc: Doug Berger <opendmb@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] ARM: add Broadcom Brahma-B53 main ID definition
Date: Mon, 16 Apr 2018 15:17:20 -0700
Message-Id: <20180416221720.31770-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223210923.544-3-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com> <20180223210923.544-3-f.fainelli@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227542953652875?=
X-GMAIL-MSGID: =?utf-8?q?1597942838453822560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 13:09:21 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> This commit allows a Broadcom Brahma-B53 core to be detected when executing
> an arm architecture kernel in aarch32 state.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
