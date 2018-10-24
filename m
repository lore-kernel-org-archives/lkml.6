Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF61EC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CE82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CE82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeJXRQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:16:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46894 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJXRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:16:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id a193-v6so2620411qkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 01:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9gD44pBd3zh4Ilz402wt5bdubAQPKJ5oEuVf6RtxN0=;
        b=SAaB+JyG0uniIdRIzhJmwENhEIaClu8oj0vR+zyLNnWrChx90n7EWw58mErFbw8XoF
         Vogq6ZGVzM4LlOeC3GflfxBpf7x8t1W/m58Z7rbe2yxHvL7pOnxHD9FMAm3ldJKM8HTy
         9rjIZKVh4eUIOpcdadqmbcYOhl7wpV05L59/+cO/b/hVyMzX2JNXA8Sr94mkoW5d8w8l
         g5mm9XSxJQveyWcvpqnxc6uvdJYka6ERmTvTM2gIF5nB1cFwbqvgVvYGSDzGaQzGdJvz
         58To9WyBtb/vy7/peAGtT+ivbaC+oeY1vI/hicPor1Da4eUq3OE3igP6GvX1nfBjvy1z
         iftQ==
X-Gm-Message-State: AGRZ1gJcLqGzZCqexSjld4KoOukiRlShKz7uT2wac91wb+JjpTj2yN7I
        enxTZIelcv1EcOM9805UiaHB5Q==
X-Google-Smtp-Source: AJdET5dLnJxNPFjWxce/BZwTEu8fLnnoH6ITLadCGQ+SWK0/IKrj2O5hKLdcgQ7fspguRknKiCTckg==
X-Received: by 2002:a37:914:: with SMTP id 20-v6mr1455008qkj.135.1540370958475;
        Wed, 24 Oct 2018 01:49:18 -0700 (PDT)
Received: from [10.15.240.149] ([109.144.210.120])
        by smtp.gmail.com with ESMTPSA id 23-v6sm2079778qkn.11.2018.10.24.01.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 01:49:17 -0700 (PDT)
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording,
 and add an interpretation document
To:     NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
Date:   Wed, 24 Oct 2018 01:49:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87y3ar80ac.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2018 02:20 PM, NeilBrown wrote:

<snip>

> I call on the community to consider what *does* need to be said, about
> conduct, to people outside the community and who have recently joined.
> What is the document that you would have liked to have read as you were
> starting out?  It is all too long ago for me to remember clearly, and so
> much has changed.
> 

I joined much more recently than many and what I would have wanted
then is an interesting question. I probably would _not_ have wanted
a code of conduct when I first started working in open source. I also
said things in my younger years I regret and probably wouldn't have
said if I was held to a higher standard of conduct. Younger me frequently
put up with behavior I wouldn't tolerate today. Younger me also
greatly benefited from the experience of other kernel developers
giving me firm feedback in a helpful way and saying no to bad approaches.
I don't believe I would have continued if I hadn't been given that
feedback in a useful way.

Today, I think the code of conduct is a very important addition to
the community. It's a stronger assertion that the kernel community
is committed to raising the bar for behavior. I have no concern about
patch review or quality dropping because most maintainers demonstrate
every day that they can give effective feedback. We're all going to
screw that up sometimes and the Code of Conduct reminds us to do our
best. Most issues that arise can be resolved with a private e-mail
going "you might want to rethink your wording there."

What the Code of Conduct also provides is confidence that more serious
community issues such as harassment not related to patch
review can be handled. It spells out certain behaviors that won't
be tolerated and explains how those problems will be dealt with.
Will those problems actually be handled appropriately when the time
comes? I can't actually say for sure, but the kernel community works
on trust so I guess I have to trust that it will. I really hope I never
have to report harassment but I'm glad there's a process in place.

Thanks,
Laura
