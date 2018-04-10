Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+plWE9rV7GaRDv2jvGAw16lbQdLJG2hHGbEO+qhS0ON5UfdbaTxRUv6qEOyslfwoCfo5J0
ARC-Seal: i=1; a=rsa-sha256; t=1523390670; cv=none;
        d=google.com; s=arc-20160816;
        b=h5AOuu1vN/eteklThgEfWbpf8hKAqSJOlSeAm11DlYn98xOIGDmdwGRXQ+BLG5PhKZ
         FraBMEA8oiDi4wKDB+CX0taR3gfeVig+Na3lURVWelfso8NebWD1pPgrr377fE3RzHJX
         E3aYowZ5JCMm88jwDCeajKPaM83OQ1jWKZTAydxkwA/lPeju1U92Ls1lHSo6MLoeGsAC
         N4TOTCHDT75M5NlBcSNmk5aUca4foEOERsn5XDIN6HKBL0Hn+ZSu+vYOzA1kPinEQekk
         GfbzCqk2YdNwnmuTH0wxHAMuUtmJqOvdJ74zCBvuZiXb7QYIzlorYFJbZ5UsCWxHJGxB
         oLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=ympwuOlvz3/D0Qjuj4u/+/xFaaW3PCxKXMmzPqSzPSA=;
        b=w3rqq/dte/zoChpvIu+RTRWnCRVnRFGr4CAQZH6ie6rNq+kagNlMUtg9PhU7G8zpSa
         3+azpHG4YgQiehXk18ZXj15qeq7jqg7eDQabVWO9JD6hEN9mtn0eXhkEdgSQuudWYZWT
         r5uRsLlehu4uy6eccbmrcXroibTRNegvyaIgbMUrLfqdgWNErYIHwSU9jq69N73cm7p9
         GjZsADeqKVFGftiCh5A4BRKKdTkdhWVX83E+LDRq23dRvETBUanrkVqE54GuYKwmHQl1
         VZX40U/QILcCxMO+c7L0mh9VvfUB7TTiaE3DXbx3BIo7tvioFX7/9TPLyzRy8ZLEbWdj
         Z7Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDJUE2 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 10 Apr 2018 16:04:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751611AbeDJUE2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Apr 2018 16:04:28 -0400
Date: Tue, 10 Apr 2018 15:04:24 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Libor =?utf-8?B?UGVjaMOhxI1law==?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v2] Add livepatch kselftests
Message-ID: <20180410200424.xlypsabmvjxrbe3q@treble>
References: <1523373354-10801-1-git-send-email-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523373354-10801-1-git-send-email-joe.lawrence@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597372746598481553?=
X-GMAIL-MSGID: =?utf-8?q?1597390895151977777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 11:15:53AM -0400, Joe Lawrence wrote:
> Questions for v3:
> 
>   - Should we split off the atomic replace and shadow variable update
>     tests so that the this patchset could be merged before the ones
>     listed above?

Don't split it up on my account.  We can just merge this one shortly
after.

-- 
Josh
