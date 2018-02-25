Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AH8x227N/9BnHjk/2D7HNf6CUwCfK61084dq4Mu5woGq6yzrKJmixZX5528Z0Xao7fapw5kLfAmf
ARC-Seal: i=1; a=rsa-sha256; t=1519545552; cv=none;
        d=google.com; s=arc-20160816;
        b=DU7Oj0Zzt4YJ0VANpiIYKPZlYYXr0gyZJiGXbvQA2yGppzOe79g4osoMYthYUJf6+d
         yFdwDB9PePpTLDUYiNcH6811E0LR3atyyniDpi9EM2/IuC/TsNK4fskvVb3t1wLfr9Dx
         KVPMNt5hHAHnAWBZfbuLgWlRX6nTTNJuE4C9qrYv0uAwETQ309vTcyXHP9PDwufTOOkv
         xVs1LR2Jp7Ppy4X3vy4jgpgn+RbZkPVQzAZzxj11a2kVQu0r5Qp9hzdLT4cjSTZnRbXx
         CNKmAkEziDpQSZrcmdMXVeo7cd1tEJEAZdc8kZEd1ezJS7adlgS7NFRhDPZSDEd7sjNz
         QTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=YScGXsQSfrTqDrqlPEAo/IukGZ0Q+/LRn8h/uLlYFOo=;
        b=pcBTssrZFLmTntXXDxsLPtvr3OXmcMyQbxYn44B7nkN4lqPe3kRbPukBkKd5ckhafA
         Ko/Qglm2N/2SNHBYqwJoSmInfX5dHKPo9hoT67Xc4FzOMrjllgG6UpyoXFaJj8lI88Gh
         BtekWoS2pEYw7pkeZKrwcZJ0cKZhcslYYG/jwmc5g9cJ4/jwKxpBPcNx+sEq+SOjHqY1
         GobGhMx5/yVUTXHAqmPSjDQfUDrUBsWZkIjZXSPDP7rU6DqnWLxYJlW0cHRkEHkyize4
         s9ja5ZdcSxkQ2EeWN5Qg8x+nTV/UPuabkIb0s6n60Jz21IH5z3zTQfRyCmh59ltSJts3
         bCKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=CviplQeA;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=AG6ZHpvg;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=CviplQeA;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=AG6ZHpvg;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:z2ySWpllPXtIXodpfPjy9CoBfkrGTWfbYSl7H51c0Y_yJgIVYfIIXA>
Date: Sun, 25 Feb 2018 18:59:07 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: sfr@canb.auug.org.au
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	tycho@tycho.ws, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Pull Request for linux-next
Message-ID: <20180225075907.GB9456@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593358997453174821?=
X-GMAIL-MSGID: =?utf-8?q?1593358997453174821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Stephen,

Would it be possible to get the development tree for
scripts/leaking_addresses.pl included in Linux-next please.

The tree is hosted on kernel.org

https://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git/

I have created a branch called linux-next.  This branch is not tagged or
signed.  I'm super new to kernel maintainer branch management, ATM the
tree mirrors GregKH's staging tree setup i.e 3 branches

	master
	leaks-testing
	leaks-next

Development done on leaks-testing.  Once patches have been rinsed
through LKML move them to leaks-next.  Any holes in that?


thanks,
Tobin.
