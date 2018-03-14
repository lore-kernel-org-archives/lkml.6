Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521045344; cv=none;
        d=google.com; s=arc-20160816;
        b=HuUaXnZN+lHnPlHnnl/BrsNdQQkrg4n/Z6hpp2EfEor4oLe4Q1u7lQGGlYjrghH78x
         r6UpbWkvgKTPq9teIpV1nHxQTv9kl7kzyIgJvFm5xcF+tSwlLVhdvlPyGJ5FaZ0bukVH
         jB/wNpQJ6XidAu9YdJeQ9+ggAV83g27h/4wrJ/mYjKGI2x9XULohl9AFuSvUuyUXlMva
         41gNxDuGmLA2ahXDZlVqCHywAisSix7GQcoGnDgdNbPOi5hlULUZW4WLikZkrtyO1hPa
         o0Vpk2mPcuFO9WWs6xXnraWlXQJjpStlXYbsnlEtb7pSIF9W5k8aq1pSl9ga5ohQ23eQ
         f4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Tuch+BXfgWJM995C6CUs2hsJriTJBxbhsJaDlmetSKQ=;
        b=zCb1fJA92hoLo11tdVZGPr3NijEjrs2aIWKCcYN0KhDSAe8OQZngyT4wo5+taoJMd1
         oOp+kDZbczAFtvw3mY7XmJWFVWRlyYi5wvgtGEbFnyOWxFGGbfhn2DjoEoJh2IjF26Zj
         H6StcrZKncSpKRmnNaHuaRtsHyKr/vNdcYIRhrw9yNjFyQV4HS6/t2Zb2lB4LCg7zzWD
         pQ3+dtQSV/juNa6ADJazwhkpZ39mQq7Y9uRmvtqfTADnRtSZoGuCTno397uCnX4aM0D9
         PgqQdyATwu6U2mGNQr2kGS2xkV2ParLMQO0PFgEvX6JRGHCOPTW4ltSi0mqeJ6IF2StZ
         eAdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O5pgl4Pm;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O5pgl4Pm;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELt7vFMbGmHcccoaT8R5L1gziPYecJqJEq03JwUB1St3z54Jft7oVYcbtOQROpRSvKc5KzjtfSHbzhpVv9U3jRY=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180314163233.GB4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-47-arnd@arndb.de>
 <20180314163233.GB4279@kroah.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 17:35:42 +0100
X-Google-Sender-Auth: VPy7n619KSS8KbQp_bHqXqDPwxk
Message-ID: <CAK8P3a3YC0N9P_fTt3Oiq6tzpia=SVx+fjY2q7p3nsJwH4=F4w@mail.gmail.com>
Subject: Re: [PATCH 46/47] staging: irda: remove bfin_sir driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
	Samuel Ortiz <samuel@sortiz.org>, Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594929089709235937?=
X-GMAIL-MSGID: =?utf-8?q?1594931642471349772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 5:32 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Mar 14, 2018 at 04:35:59PM +0100, Arnd Bergmann wrote:
>> The blackfin architecture is getting removed, so this
>> driver is now obsolete.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/staging/irda/drivers/Kconfig    |  45 --
>>  drivers/staging/irda/drivers/Makefile   |   1 -
>>  drivers/staging/irda/drivers/bfin_sir.c | 819 --------------------------------
>>  drivers/staging/irda/drivers/bfin_sir.h |  93 ----
>>  4 files changed, 958 deletions(-)
>>  delete mode 100644 drivers/staging/irda/drivers/bfin_sir.c
>>  delete mode 100644 drivers/staging/irda/drivers/bfin_sir.h
>
> I just deleted all of drivers/staging/irda/ earlier today :)

Perfect, dropping this patch from my series then. Thanks,

      Arnd
