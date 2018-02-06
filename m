Return-Path: <deanbo422@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-577776-1517902879-2-582845014407737644
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25, FREEMAIL_FROM 0.001,
  RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.214.67', Host='mail-it0-f67.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: deanbo422@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517902879; b=c1LKNpltyOLGhMm2R0+NYWWbCTRFhSATu46dZchNmNuajo4
    S+0wFY2BB+AR38LNiOjU2jMC0TqX40Y9GH+gIggcprLEQaGodem8aJrN1xWVhFig
    4tsTZ++aQb7yCjLHHWXJG4OoM3KPcinsTObrHRNnTBwF2wDfVRelObJEtJtqh06f
    B6xm270Pqhat4/AZuAhpsarJGxOLAbBmS1qGe3isA6WX/FpSwZUFKgbzdczMjRWO
    ABya9COVzVr947+cD3mZNsYWck4Ol/yTMeoRYX7qdSN/2yxDtEPLScRUETCbzCwi
    S2RuKrr2daAPppaTmCKJLqAeFi/LhcsXee3QEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type; s=arctest; t=
    1517902879; bh=KQ9yLceww5/wefMG/uy1a6a/MNfsXVt86zWTYCL+2CQ=; b=p
    Cby+PH95A58UBgfSMopkN97XgKgUivTYNS2/Mo+txxE6vQiPXeWlwVCxibrsbn1S
    2xFqeaXzWXJXLki/8V/i0bkCKvNjgR0QlpD0JsEmBbmhZkLrY/Pj3YMvwSnlZ1WL
    NuxaAGGpFnFxS/1imX4GtyScnb5Tz2+ZqFkx445kNxxVPRv+QJE+2UVqv1wwDx/4
    1MOUAjiELGvm2ZI83G+mjnnX3aHAqFb0p7hmxhChPBeljH6geDT6gcoUD+7OGK6R
    EIpUkGwsPgT7WMYCv7vaPdwNNub6jCjL/GI2SY3c2P38vRGw20yZtFmF/V7IBVRO
    vGX4dQyCttVApYSyZz0cg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r4AWF50t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.214.67 (mail-it0-f67.google.com);
    spf=pass smtp.mailfrom=deanbo422@gmail.com smtp.helo=mail-it0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T2wHfnUt;
    x-ptr=pass x-ptr-helo=mail-it0-f67.google.com x-ptr-lookup=mail-it0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r4AWF50t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.85.214.67 (mail-it0-f67.google.com);
    spf=pass smtp.mailfrom=deanbo422@gmail.com smtp.helo=mail-it0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T2wHfnUt;
    x-ptr=pass x-ptr-helo=mail-it0-f67.google.com x-ptr-lookup=mail-it0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226ygniC4yXxWOzS3h2q+7kZFKjiTk+m69dLfwfMT+djVfUJGQb4zch8qF9LlWRPKCepbxjpz9sbcb6CowcQg4I=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0GQDrj+7kc4YB1_ZC1vCWmMtSiYeKsNir_27FvY50Kmg@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <4a602db0a58cc858515c3c669d5ac34c567b061c.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0GQDrj+7kc4YB1_ZC1vCWmMtSiYeKsNir_27FvY50Kmg@mail.gmail.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Tue, 6 Feb 2018 15:41:16 +0800
Message-ID: <CAJsyPhwHmMrXmN2-NW3ZyvRvTWR0vio_bQO+GDBf30DVp=5LTw@mail.gmail.com>
Subject: Re: [PATCH v6 19/36] nds32: VDSO support
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>,
	Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>,
	Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	Vincent Chen <vincentc@andestech.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-01-18 18:28 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch adds VDSO support. The VDSO code is currently used for
>> sys_rt_sigreturn() and optimised gettimeofday() (using the SoC timer counter).
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Dear Arnd Bergmann:

We find a small bug here which make LTP 20170929 clock_getres01
fail. The bug is in __vdso_clock_getres() function. When argument res
is NULL, -EFAULT error code is returned now. But, the returned
value is 0 for SyS_clock_getres under the same conditions.
Therefore, testcase thinks it is a bug.

I will modify the code as below and add it in the next version patch
if you think it is OK.

@@ -209,7 +209,7 @@ static notrace int clock_getres_fallback( ...
 {
         if (res == NULL)
-                return -EFAULT;
+                return 0;


Thanks

Vincnet
