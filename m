Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2162513-1522237855-2-2003787799801433472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522237854; b=gVIx2BoWeQSwZnqAYqIyBBVo5sdvAw/avn1JMd4ybn4Yp9W
    Yizcph+NyfaIt8y2K6t61ToLUDCK3kh5aJi+f6SEIeoJfy6sSbYMSeCSUST/+Ujv
    GeNxM8TLpkYSAjVgCW3cWA75qjFEhFGR34C3yIKE3HO3C227siYlhvnYRxMQIUR/
    e9tv1chdpgqc/b96DJYCj9V/SjfItK60Q03CrcZsLiR+pg42p5/LCxY6PUHEoXlx
    U6zx6bfqEKlAoQNrsTioq1UUoMBzN8qI1ZeH+p7nErcpSd84v1Nf2gRwPcsCKrlR
    lFomtoYHvtLwIbCRk655dBZO534LvGaIvGo7k+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522237854; bh=W
    X0Shi6mWPPvdJash7rwVtAhgRDfjUBVy9extRoAqI8=; b=gEwh/Yvl0Wn1oiKiC
    pHljI8Pj9T4qRkRnFZf3Mxs7PY5mFl5re0Pw7mTWDO/86vE/Bi8DsFU29xnBuvoS
    SyFHdEoY8biAERtig5RfslQ2Q4Q/Es0W2+s/P1UgI/vXP7NNH/C9SfVZf/IKuckX
    6PFUo1BuBQMrczx/gtdUPPSmMn8uAlCQ15ijwIU5dR39sMUw8Dyb9KzHgnEgoWHG
    82AGnqG4iPVxYxRWr/fic0iS9HKhRKRTC51rDQc0sIYUucUq4ErflEXjyybg1zU2
    FN1ECZmjWESifcT28TH/PWOvRvoXzb3R+MdAkuUm75h1S1jN44Yrkq00C/bbJbpT
    UKLJg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHgG51i2Db6O03EPWHdM8O3FHNmfNEtc7kumXh/vLzDfTjVGHMMP17f3ongP2Coxyos67fcnBhq2ewLLRjz/JK6IY/V7UcDnfYTkdOMwA65y7TiD3Jct
    vmBj9M3lFXCsZ5zGGNij84TaJ+0O04JJrL2LbvDc2hWMbfIx/K3GS9kZTrj/WkIPp4vtQXN9woQYWgKx9m3FDaZaOVAMzZ81SRrMnAEdRT5Z4YMwydh7VOYY
    j7tKw2blAbvRV39Io9Jd8w==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=tTzvifc0VybRbgF1_KcA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 28 Mar 2018 13:50:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 1/2] staging: ks7010: Remove trailing "_t" from all
 structure names.
Message-ID: <20180328115045.GA16383@kroah.com>
References: <20180323145807.GA28429@kroah.com>
 <20180324064043.17020-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180324064043.17020-1-quytelda@tamalin.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 11:40:42PM -0700, Quytelda Kahja wrote:
> The "_t" suffix is not needed for structure names in this driver,
> and is a reflection of an older typedef system that is no longer
> in place.  Remove the "_t" suffix from every structure defined in this
> driver.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>

Patch did not apply to my tree :(

Can you do this one structure at a time?  You will have an easier time
of getting it merged that way.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
