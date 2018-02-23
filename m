Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AH8x224GVFDZtHIclfAhg5DKTxNrv/49NlWnwL01derkTRZ7RMj9dTlzDB1PyXkiyOfWajVQmwtb
ARC-Seal: i=1; a=rsa-sha256; t=1519399231; cv=none;
        d=google.com; s=arc-20160816;
        b=T0H6KoYqLMTNvnWr7HEY/2ROkSnqawKswSjAWkglyYInI8efm6EWlem7tn80mOIJ3l
         IXu2FO1RrB2lJ97W1IhfY1qNH8OsatIbAsFa8ccoiae/fcDO1wpkncgxlYqd9GhDtwAC
         2tsJcJuA1BcDKy8NUp5FHtXxeqoQi1imHRayTIaCD0V4ALSpv56M+xHVxSyP4FvrfAbv
         dfEJrJumA7UlXB43hsCjlW38vjfJiw7pQwGjNIdm1ALMGwVuXYagySCnUjAmVTDolHND
         MpBkEDBJDtbaoxMLQqxM/70OI8xF8d8vkHbubDCbW+K+krKn9aIxpvERwZv0LFsSvjbP
         7/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=yLAPNBhWZUMRvKz+ZyhzyZ4zayFMb0vUBEcYjsUz7lc=;
        b=nZ4Sm3Fzo7QB+y7clai1lONR9C+zQU8WgIPMoAkMphg4CFb+38mspdukiKnCZrUA42
         qqUeBtjtN+TwWrJFE4a3dUo5n1b104qz9jc3qYJ4D+6JxcXYMK/JDlDl477xAb1hgcPn
         ORhBkYD8/Qk9vR4baP7JGXVyFlF6n6/oCTFJ7I2e9vPmvsHfjEwxf+o6jtRgJUU0v7Jy
         1tZFmDMqgzKSmuXLqAmiRW6eaeHrQezO2RwpNHWXDS5uSAqRzNhcNJXDs4xnW54R7QxD
         nXXPeJd62cxHGdpfRfbhW9Wy3fFuSEoFg7/r03JjWtNcRa6O53BcGUJ6Z1RfIfW7sYi4
         mmmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 23 Feb 2018 08:20:29 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: linux-block@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] block/loop: add documentation for sysfs interface
Message-ID: <20180223082029.731acffd@lwn.net>
In-Reply-To: <20180217061304.GA14083@mordor.localdomain>
References: <20180217061304.GA14083@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592627550453000826?=
X-GMAIL-MSGID: =?utf-8?q?1593205568143866083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Feb 2018 11:43:04 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Documentation has been compiled from git logs and by reading through
> code.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
> For drivers/block/loop.c, I don't see any maintainers or mailing lists except
> for LKML. I am guessing linux-block mailing list should be okay.
> 
> Changes in v2:
> - Add linux-block@vger.kernel.org to the recipient list.

Applied to the docs tree, thanks.

jon
