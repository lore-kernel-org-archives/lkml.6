Return-Path: <agruenba@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522779509; cv=none;
        d=google.com; s=arc-20160816;
        b=mRNxMPKtPlY2umZrR1nGScSiPjKUtnQrDVjPxr6+Z9oZLaceSoSPzLJT9GvOROiDOe
         lYErT/RA4dGlkGeRDNutbQxpOj4ahzrH9Vv8wGpnaAEgeO+OULojwkWKzeL9MeWopzew
         jBrite/zT/w2CpbZrfGawN71VHkk+SLjsCT9lYc1s0Vi8kBUTAIlVa2HPWdK9GkJTMzG
         PcJZYhIMPinNNk+lZSvAe0Njthjzu1FqBVlN53YtttkgIGjgRPNLc/SJ5ZyWMDtGbES1
         NpX5HD+KkVznBfkHavrMwqVviFxdd2JHU7QhDD4hp5Rdqdi/2i4QBZfid2L+bkQfz5Ru
         ZaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=jca1lp0eMElvNYRBRuLVdTM7DFujiGj9njFjYJV9jwU=;
        b=0cBRnwoXZB3EWXiDTNgqFLxGXPGxSDPMQhVo16hLsBYw3FJ2SpFDy+KfYLSRxWmrEs
         uBeRBlpZnTYmqhk5xmQEmIl8O0hy1jUoUCCNMUYBLnBlowKdW0CVrWKiKt8qyU7X7WEr
         QusBIEQAr7xZR7LKD+8EvHNw/TLYiCreNbaDn/PRbFGeqN0sBRxwwNkz+pFWcKQCxTu2
         pvO/layOUD3dBrwGyUIBn4UkLuSh6SJ3eb8U/ku7iHX0zQfAqedN1eyH/1Qu/PZhLKTo
         YdrPXCC9uvKW+4O3CwxdawaBmmGE9gB9izOWuArjlGGVNUoBOFzNscqodpK3zBpg29Cs
         7mPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of agruenba@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=agruenba@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of agruenba@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=agruenba@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4+Gjfzyw5kSDqzIZvRtOvme8URziMhcD1z3lH20jruzXj+G38PhVdHpOPE8hZ15DbZQqYs8iUedPoZVdYjVK7w=
MIME-Version: 1.0
In-Reply-To: <20180403172055.GB15938@kroah.com>
References: <CAHc6FU4B9SeO_5LcVmf4OhYeYW0K1V+LjKe2TJ9U4DipVCqNVw@mail.gmail.com>
 <20180403172055.GB15938@kroah.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 3 Apr 2018 20:18:28 +0200
Message-ID: <CAHc6FU5myOjE9R=Dx7w7OJrCdL1K06PyCw1fYY-rNdgUk64=BA@mail.gmail.com>
Subject: Re: How to get lockref patch merged?
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	Bob Peterson <rpeterso@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596723278896067339?=
X-GMAIL-MSGID: =?utf-8?q?1596750046739451940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3 April 2018 at 19:20, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 03, 2018 at 01:13:00PM +0200, Andreas Gruenbacher wrote:
>> Hello,
>>
>> what's the best way to get the following lockref patch merged? The
>> maintainers file doesn't list a maintainer. Should we go straight to
>> Linus? Does one of you want to take it?
>
> Andrew normally takes lib/ patches, but:
>
>> We have a gfs2 patch that depends on it.
>
> Then just include it in your patch series for gfs2 through the normal
> path you use for that.

Ok, will do. Thanks for your help.

Andreas
