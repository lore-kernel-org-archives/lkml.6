Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2097833-1522237201-2-2727166433589709291
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522237201; b=TET/DLYllJCIpWtOk3sMz6/3pXEbDUUm8MkwWHcElWQD48m
    3Ii73BhanzrYbXjgGgTlLHAEsiB0/FtiNV7+vNVJUoQdJ3qcBGlfXoRKSIBa9GEi
    k2jW5VqDaPjuhCNDKj1XFFCPz9fLPknXiTQOU4WqPfmN5f7v+WDlnyAyoY29zuhT
    p408uYeoaCGVAkw/Q16OOueiGWaoxfJmZ+fHvUUOWf2bpdJMnJRjvZWZGmRen4Gx
    uTUvdb0/Lck892nmn/D7yKzvRu75TUR8YMhSrpKoBhC4RzkCxCFQKwxiR5FZhmmg
    T5uSBcJ0EStlT4WydYHOw+TTh3Ll9cSHP00MlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522237201; bh=t
    M/uPXWSYnUYGNRzbZbzvF5CrXQucda9q6bycw9Zf2U=; b=gIEbRVtfMcyh1XxsA
    s8o9c0Gd6eh+pAwxdT4Iv8w1S3y3H7CUjdfovpziPTVGLxD5xBBk3UKEdAJRUXFK
    lnxKuN202GE22oqthD3VCw2rvMsDYO4urRiC6PI7VJLel++HNbIpyYiMJotkJEqV
    wVaRlBq56+TUYFGM1CdF4ubZpImwM4WJ1uuhyB+MbBHDJ1d7XgBF1TUf13+geR+Q
    4faTt90Bmx8TbEyRX139CMM15pHr/RC+s3ABsYwvKgv763hg/A/FV583rpyLAgZI
    8OpJb9XacCYgy5/FEvXbCYI1FS+rY483BLfP65swzzh9iBEOHKUK71P4vCSCvbZ1
    S06oQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBDCji88nDDzBkmJ1n0U5g2XyntPei7QWH/jBTIX4Vmtr5XESPNzH3PQLIlLu8lmOZX/wwvbCjTO60aephIEy9YlY6omEJjQWiKQiAFMqNagNLhW4xu5
    Cs61b3bw1Lb6iBvZ/sR0zNadkjFzK3mg6Eoh4sj+rGkKl1bQQxso6qhD8VfG+pCVjOWa7B9AruMn92PG+BMrApfgFORTugTR32393dNEDI+j508c6ydc/k8d
    hqc/vnpOFOAQNaWN5y4Qog==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DfNHnWVPAAAA:8 a=DDOyTI_5AAAA:8
    a=P4xzMIlCggcGCuQcRGYA:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 28 Mar 2018 13:39:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: wilc1000: replace kmalloc + memcpy with kmemdup
Message-ID: <20180328113951.GA11213@kroah.com>
References: <20180326171629.28700-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180326171629.28700-1-colin.king@canonical.com>
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
Cc: devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ganesh Krishna <ganesh.krishna@microchip.com>,
 Aditya Shankar <aditya.shankar@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 06:16:29PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Replace several allocation and memcpys with kmemdup and add in some
> missing memory allocation failure checks.  Also fix an incorrect 
> -EFAULT return with -ENOMEM.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/wilc1000/host_interface.c | 75 +++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 29 deletions(-)

Doesn't apply to my tree anymore, due to patches submitted before yours
:(

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
