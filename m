Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZrfqK6A3SiSUSjHKPKWshHKgzFOwIgl9GkScBUXMT3zocsZH/Z43eipWm1I4OnOhOGDuBAc
ARC-Seal: i=1; a=rsa-sha256; t=1524869803; cv=none;
        d=google.com; s=arc-20160816;
        b=ySgvL3zK7Ax+Rk6dz05MX57KUGsieXrTCNVeKZ6iXTWP9PojgOQaULKcotP4ACs6GX
         MHHdYtNrcrIlM6leq9luqiCTeIePtO3iYu7SNrqT3JLe5sHYjzC1hWzkexSBPlErWwJq
         tvs2ZRSl6bYZ5lPn6voR0vrYxyZT3yeS5wlPd29n+DnFVrWhXYruFXvNkG2lHj1cD1Ep
         HAJJecVxgEWtjr73zuS8OcAQKldiDVCAfSTD/bXnq05I3QNgw6+319QzP+PcTSz9m4S7
         A2+d7PbqtFZADL4fyc74n7YCS1j0bQgIJtgZspPYgXllDvchHhIG2x+URYn91vFuZMG0
         x6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :date:arc-authentication-results;
        bh=XZx+1MpW8MQ2CQPgv8IwZuQTCzqqWd8YILKvK1LcEk4=;
        b=c4nsIfk8oG9gg/mMOi4mKDCAHtbgkLFMnndsPcqQBB8itfsX3M0ZlMz1dplz8vhpD4
         POhUG46GDHGmg/8bSDjwOGsUiejSv0iPMPVRJo6EMy1pRdd1KaxBPCHspKEK9TYpJxK1
         /JdB20+pwQVbQBSh0bH9cw3txjklZ8ENl9l2CCpqtosJnNTKv9sOGsWBPJb07K9uvYUZ
         Mr71xR//4M+A4RDb+fOn49wb7Ia0DeIDJupfk9JYBw8RN0i1kXfLQCZiPnOxxLsto1+A
         Wsaoof+NWZdkJVJEDyHQ9cBdMa3O2tuM//AnNl5SQ42MiJznMFEsMGcryfllAUam+Gcr
         sZHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932662AbeD0W4m (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 18:56:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:55266 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932373AbeD0W4l (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 18:56:41 -0400
Date: Fri, 27 Apr 2018 16:56:40 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: dev-tools: kselftest.rst: update contributing
 new tests
Message-ID: <20180427165640.437f3b8e@lwn.net>
In-Reply-To: <20180419102825.2990-1-anders.roxell@linaro.org>
References: <20180417084631.11242-1-anders.roxell@linaro.org>
        <20180419102825.2990-1-anders.roxell@linaro.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597982439415965732?=
X-GMAIL-MSGID: =?utf-8?q?1598941878604172401?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 19 Apr 2018 12:28:25 +0200
Anders Roxell <anders.roxell@linaro.org> wrote:

> Add a description that the kernel headers should be used as far as it is
> possible and then the system headers.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thanks.

jon
