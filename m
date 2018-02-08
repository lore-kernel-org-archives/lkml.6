Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518099217; cv=none;
        d=google.com; s=arc-20160816;
        b=YmPVWlV7eSVbH20TtEDrrbbg0HRt21k4oz+CW0XJU34pHZ4nBnMBy+zBKzhOh1rsz5
         w63fxCK9qtH+sCU/EWeYbgtecK+eL7VdL34s7grVmVFLP3ZhijlXm/KdlXqVUvhpLCo1
         nWb84e0Z+elqAzDkl2w9fABL4wNAyBpV1ww8btt0LPN1mvuVbOTv42qVqjxboezeK1S1
         16gqIAJg+ZPVvX0fvu6f8MeY6c5JSsMo7sNQ7TUa2xzcVWh37jgMlQ8jLrl8fgnUd7bi
         Cm4CZClFD8h0XaBnTwTpvzYHDjBeaSb/9czKndmZb3yAttYn45eID+fPxm5zrqBeDMz8
         +x7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gHoH9vpQ/+QFwNeBdyK1AzfKDIwIOarYdl1I3uEshMY=;
        b=h6Reg/m4oOzfFemRizjJFj/+wldq+ugCuqDOhxRcFpjd687SrpsrmZjuZMnUrzrU4x
         gTXpK5ywdjsWopOttfMH7HEDV99MY54BCSCoQXGnBrqURxyWSMN3pFWpKY/Izka1lJl9
         Y6fgW4PGJpNEhSebN0isjlsHqWZuPCrCFkDzGhP7+f/dMouHGxuCNGKjbRLZW302CyrR
         ENO0POPUAqVlxc/pmQNfnJ3d9hssNH+nPEWIvJjVsQMVit7CgHytJ28qJ5OB07gv/itl
         mnzm94Uk7CZ2m330+q4GwD3GD5dM6jK/8cvyhBoJACdFCZ71a0ZOMu508ywExp3g5g19
         PMkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=sKm0Zo2V;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=sKm0Zo2V;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x227XvpmsJOIJBhcNiuJdlk+BP9aqFq0tFJAW6Tgq6XkGdtO0LOeUPp05ESBTBs4JnwjNhz8ZtrXZ5SUP97Vowqw=
MIME-Version: 1.0
In-Reply-To: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:12:56 +0100
Message-ID: <CAOFm3uEfnG8kc4UNOAUq5Ycb+GpfZsA9Yymbmu6omuDYLPBxMg@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI: Add SPDX tags
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590692248375427525?=
X-GMAIL-MSGID: =?utf-8?q?1591842404726544611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Bjorn,

On Fri, Jan 26, 2018 at 10:32 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to
> files with no license") added SPDX GPL-2.0 tags to several PCI files.
>
> These patches add SPDX tags to almost all remaining PCI files.  For ease of
> reviewing they're split into several cases (GPL v2, GPL v2+, etc.)

Better late than never: thank you ++ for this: my hero!

> One file (drivers/pci/hotplug/s390_pci_hpc.c) specifies only "GPL"; I don't
> know what to do with that, so I left it unchanged.

This is the way to go when there are ambiguities alright. One
interpretation of a bare GPL is GPL-1.0+ but the context matters a
lot!

-- 
Cordially
Philippe Ombredanne
