Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3258746-1524781422-2-16168350852799659611
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524781421; b=YUxMxJyMTxm5hooYXqaE4fTqlAZHdRz31HSZvzq6E+qzuK2DMT
    2Ek+kBOd5RtoJsEdVDyZ/7tKQfwIUlqJQWDYZDwkaZVh5Q9psDJOmZ+1PBmFqoEG
    cmg3EHdQjmaxA1iT46j6772J4mt7Nx/0nf/+mHzNZwb/Srvv1JQ2+PHaNuEOnb9r
    wRXeGjz2c/Y+WeXCR/OLGnEMbJUAbv93xlMGddUbB5tQQoxv9AJO9eE2/vHWRgzr
    2fBpjLlwmyiVO5zHepMnRUGQZMQplMoUFq1JADR29wnemA4sqbp4ygY6l7/xYJ7n
    Gtm6bP1DNiVdYx7rh6fl4BEmB75cm7JuovTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524781421; bh=FhLv0
    XaaIT1Qa9GITModrDtbt6+X0A50aU+xeR60XTQ=; b=P9Ls/ncz3j+CS+eBkytFM
    Q0F5/vUJsEemYDLJPhY1uEMF9ESRe58jGImS5+dYLpApVpVZ+NNdBr1IxiVvHnGq
    3Sg2jAFFJDMSzXGuUzs/61Ss3dz9QEROGOA3z1Xk+HBpbWlATW9ga6F3k74uj3AF
    U9m8gia7ORCF320XhB+z0Lnoh1TtP8sH3UOn9bRShA6cPe1Y9Xh/trmn3ZwPcljp
    9s7ahB6jVZJd5NuN9OuE+0H8uK1Gxj2giQrh+tYhSgk9zYWnN5P/65NWYLkVEvQz
    UzSWgab9l/rziZfwLMnNgSgz43W1hRvSII/XSepkG4ZURhcYUeN3dRi8IdOJmyVp
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLFAkTip4mYaxwm4PRtafauB99hY1fjlrUBWnihu7JHEj5vRbfIhsB+8Q6Ctze3PjaptmrFpsdsr2YqBKeHEqxYf6Nt6x4zMiZXumIg7eSzUAxmEW27n
    60Aybe5SsoVF/almgo6o6361/hcbrfVHaSKxm8bh2V13ySxqTmVgjQcvLMC6Hxf9y5VuCpNtHOyGUVLZmm1/VDGCiZ1tsXjaqcmW8RBHkOhCnLGqlqy40iI6
    JcJDAD/TrbLHca/JPqYAPw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=T9WpKquR4qr87SYvzn4A:9 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 27 Apr 2018 00:23:31 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH 5/5] X86: Hyper-V: Consolidate the allocation of the
 hypercall input page
In-Reply-To: <20180425181250.8740-5-kys@linuxonhyperv.com>
Message-ID: <alpine.DEB.2.21.1804270022340.1596@nanos.tec.linutronix.de>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-5-kys@linuxonhyperv.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: olaf@aepfle.de, sthemmin@microsoft.com, gregkh@linuxfoundation.org,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 Michael.H.Kelley@microsoft.com, hpa@zytor.com, apw@canonical.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018, kys@linuxonhyperv.com wrote:

> From: "K. Y. Srinivasan" <kys@microsoft.com>
> 
> Consolidate the allocation of the hypercall input page.

Again. You can provide the new way of allocation first, then you don't have
to add code first in order to remove it later again.

Thanks,

	tglx
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
