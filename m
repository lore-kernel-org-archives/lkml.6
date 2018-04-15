Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-732471-1524065817-2-17513929038981951923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_NONE -0.0001, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524065816; b=fBBunoMG1OWIvHnpfyoaWXFc0y82HV8fjMK7m30KUNbuiGh3CA
    LRm2MXbfIxEGT8vJKAiDdE5d6/7XncNKDYYfAxFLfl2O8vcGJOcaYEg4k/fx8/Yy
    ae++8rAK1zArQghj4MryJcEKOP1OHW9as7hZvSQMFSszWMJYUU9evJ5n8Z9v07fP
    fXUUl3cHuKQvQOvmsUsA9hUJAZSIh0oPaAjlFEA0kIaVtBXZ3F9xJaPnfWHu82aL
    tQINRNNVTL6w4gm26sqjeevyNnyF9tK80OWuwVmSXs3rK8Sc6B7uSXTYPLkpnbv1
    aI9rpRI/WUiGQpPA0lU0Iasb4FoNYXdq1ygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=fm2; t=1524065816; bh=Y5s3U4WhLOkL
    H2MNK+BWPxTXF5w16azWJG3nlOpyXtc=; b=AtACQ0t/pVfVt4XCa0r5DKcBdnTC
    vr/co8rLpZjc8n/zZsakGAvYERLHLDI64tK2t/VfK7HD3XMRf7SAsgiS/f9eTnaO
    QwmkYfO+cRbWFmyDoaA8w+5MO1OlBq+T10fa2g9VwtuSPwzTR1cCvnT8h1/YGgZE
    qvrMtRIR/89PKJ9M9MNMWGt5rd68yVt3Ym9ruEF4tup2J1ydWAz6KSlokwRA5iWv
    UB6TOgjCumCkWaqlDAGEOsJf9ACD+noBrvLp33qyExCbhC7MVgm3hi6NQu41XmZs
    ItExyLaXJkuYprmJhSI+wbwNAoC0o7R1PP4w9wqPthCPmuGpOyZhSCYt6w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TDNPjhNA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BKcIcPOP;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=community:mailing-list score=20 state=13
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TDNPjhNA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BKcIcPOP;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=community:mailing-list score=20 state=13
X-ME-VSCategory: community:mailing-list
X-CM-Envelope: MS4wfDt/uIrRFIkTa4z9luhztbEW+rsae1S9BEj8YZ/S8XjKEPaJKguQe7TTKeQ1DQz3eif3G/WvHAG+08uJ7+U824X7xSTF+pJfTc9s0iq6BGGY0WeVo+gT
    z7RR98dQDtFXfXUvCaKMHRRq8Mhlfrklo/o93/3uodQ2FmjVAe+l/4IGm2euxV77GwokV9Vmt9Y9tBlGuBAqZBNYcGLrHrGcKSg=
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=rY4dWIxwDULXyY+dMrlW8Q==:117
    a=rY4dWIxwDULXyY+dMrlW8Q==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=r-ZPyS-gJkIA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=SiqW3_QkAAAA:8
    a=HJY8On2g8vb9oKGfFBoA:9 a=CjuIK1q_8ugA:10 a=VlZU0XKO32wA:10
    a=0-oVHmElw7bdUHZZ8WX8:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Google-Smtp-Source: AIpwx48ybk4B1bnGxSbtoHlib5NCXb5So3UgJeiHpCWT+C1MRLH1q/m79hNrTFF2yMppLYYTS/xHK8OO1WqLFQwvpwE=
MIME-Version: 1.0
In-Reply-To: <CABXF_ACzu=+AKYqPyZwFzFw95KrczVEKaYifmOVuv=YhsvcTtQ@mail.gmail.com>
References: <CABXF_ACzu=+AKYqPyZwFzFw95KrczVEKaYifmOVuv=YhsvcTtQ@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 15 Apr 2018 15:19:21 -0700
Message-ID: <CAM_iQpV8NCEJssynSDi9qOKbSNWLWmafEcRODi3avveP=STBew@mail.gmail.com>
Subject: Re: Softlockup and Hardlockup sample test module
To: Ivid Suvarna <ivid.suvarna@gmail.com>
X-Mailman-Approved-At: Wed, 18 Apr 2018 11:31:29 -0400
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
 kernelnewbies@kernelnewbies.org
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 15, 2018 at 12:47 AM, Ivid Suvarna <ivid.suvarna@gmail.com> wrote:
> Hi All,
>
> Could you please provide some sample test module for causing a
> Softlockup and Hardlockup in latest kernel for SMP for testing
> purposes. I assume there are some Kconfigs to be enabled as well for
> this.


https://github.com/torvalds/linux/blob/master/drivers/misc/lkdtm/bugs.c#L130
Is this what you need?

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
