Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AG47ELsXL/ztsgHsTtbhl1aHdRqamW/+me633NsKYb6sd8fTowc6Z9VZcHUKJ0fMEEVVyIdmCGny
ARC-Seal: i=1; a=rsa-sha256; t=1520863390; cv=none;
        d=google.com; s=arc-20160816;
        b=yO8k1fVulE5IDKeuzpr+Kt9hVNtn8NFRowVsepAQCxEGDWj0yIbPqnRSVQ+WJYDhbb
         mGXvglnLF52ke7PLAvqqEfSe106WUJdliRVhqj/ImhR72Apaw/awqKXnJy+axf58qrwe
         30or8Yf8sWMq9RNkKaz3L6k/0AJLqO/6S9AGqSdZpFOqmqAvqDM00Ic9xc5ubXomnySO
         jZe0mXNwqMa+8aWYGNB24upIjenAo8/QBNGHfyfCAN8/nwlixi+/c+aLFRLBi0rYH79T
         SlezGHrsiQ8oZWRfPGOiDGZinyFIv6dXj7erx6rXaBO+MywWfy+xtTOJKBsMVmKGIWrW
         Wnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=AEv8v0DKP9lHsENkwe++w0We/zdBkiQKisu+XNDutOs=;
        b=xt4xCVk39X7aQ4MGVVF4o2wD9469vlSCVqWWB91CZTQxwrcc07LDy8IT8l6zKccMur
         D0KFg0diPVnWiVZuqVlX+bFix9dil6dqeXeeP3qvU2feB1XrjWdDRhj5BhO0W4KTjfqj
         caub/1d7AP7WGPJ732qvlEctkY/DTCQdoFuCrXIN3acOtBkoKFZ/omEKpPe5O+riC1Sl
         JEsVd39D7l8h4wdT3e7+Olxkz9EjzzdKM4u+HTj3/aKOQ6+ylbzrIcomksxoDLaiRK4a
         BrBdth9Ew85HpUe52f7Cf44n9G77RcvpcfjG4J/zyGIBVPAvsJ6pQgDBf6v3aHY7sl48
         iCNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Mon, 12 Mar 2018 10:03:06 -0400 (EDT)
Message-Id: <20180312.100306.1226474832894044539.davem@davemloft.net>
To: dvyukov@google.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 syzkaller@googlegroups.com
Subject: Re: LKML admins (syzbot emails are not delivered)
From: David Miller <davem@davemloft.net>
In-Reply-To: <CACT4Y+Z7E1e05R1pBhS4oD7Moy8sn3N7POvuDTCYNDYDc_uE=Q@mail.gmail.com>
References: <CACT4Y+Z2-Z6GN0SDb5jySJkCrTRxf9qvdzuyM_OoruCTB9EoqQ@mail.gmail.com>
	<20180308.150309.1043571795208899259.davem@davemloft.net>
	<CACT4Y+Z7E1e05R1pBhS4oD7Moy8sn3N7POvuDTCYNDYDc_uE=Q@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588652385455174541?=
X-GMAIL-MSGID: =?utf-8?q?1594740850604214490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Mar 2018 09:56:42 +0100

> But I don't see kernelci.orgbot referenced anywhere in the emails.
> E.g. in the one that was linked above:
> https://groups.google.com/forum/message/raw?msg=syzkaller-bugs/OkwLGoS6UQA/hHAtCdnNBgAJ

I'm not referencing that one above, I'm simply reporting what I've
seen in the vger bounce logs.

> Could a dot in email address produce the same result? E.g.
> To: foo.bar@something.com

No.

> Is it possible to revive autoanswer@vger.kernel.org? It would
> hopefully allow us to debug this without bothering you.

Sorry, no engineering resources will be put into the current
setup as we prepare a new system based upon mailman.
