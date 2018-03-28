Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2970238-1522264029-2-9090445785447597739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522264029; b=Vtu+1Ek7GGCKbpjMaUeajpjHQ7xrL19dWw238wZFsLJHRE/
    UEkzx4+xLKfQzqk0iEEA+78DKRnDBaIDFyLUios7SYsjJ4gJloYDEF/I8jLVzxxo
    sv2T38bfeLrahp51MRkCPIeOlZztollb6Go4aQGs0iE9Ard+fzbwZH/H0DFYGvsg
    Op1FgC2g1nOpMNV2N2pALEUv8peqwKKunyCfRZZVJ2Djey5Y7BsoQHXcDtBWdYOB
    kDF6FTN51HQaONlE6uXXEACvs+ydQU2hcHD5FuUcMSF2GKJy397fpGFhT+5/ZvWk
    O2RCJAnLsWmFpP6MbzHkCbOFhnJVbUUGwWFeg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522264029; bh=dJQNjq5qldFZUodosT1+PKijz3WclPvTKSQP53/0iwU=; b=v
    DrrPXtkXID7bBE/81uiWBtipe8/qjGMM50vwohrAbl8Xlg3/4i/1L2fLfCOUTXce
    4MXMJC21VhrL9rW4aGczIMk+cRrfnYtP5N3C+fBvQ66fsghaFTfNAvfj1ar/cnyg
    XmyvYcx+1suWIWUTx9V9Bluu5FivLEs7pIoec84KusXlhYi5wpceHi5TXczNaNKC
    qKbi1LeiI/qeGL3SvTc2DjvZ3PSV752vtUcCw0b3WISNxOZlbkIUy3oSMMNqgrjb
    MMAd5lIUZcGpxo+iNo04Rul0pCvMh2PHGPb0kkqxKZ9AtxlXQfmQsi+ae8C4CSAT
    bQ7dXtZsQZhoySShIjI/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=W2oeM5Om x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=W2oeM5Om x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCosbD2OmsC32KNIpqtwNtM01tDEvEYhA0iyv24vL5Or1UComVe3NBSwSmLXB58xPpnr6EJjqOykhdUNC+/70kOgxDZldDXm8X7ea5RMIpyDKU7+XGuB
    i/caJAaEkxa8/BbGFav/v2KWCga2ETKdC3JoLC4VQJG2Y5Qsuv4nGhg91L53gidLWo83P0K4/YD/gmkPcBGkCL4olGZMKxcvGveE2d4NFf5rdZ0AvCR5t3X1
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=HpFSncBSp1MA:10
    a=v2DPQv5-lfwA:10 a=7IsmsMqpS1G-BXXvzCQA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeC1TGt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 15:06:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41520 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeC1TGr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 15:06:47 -0400
Subject: Re: [PATCH 4.15 000/105] 4.15.14-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180327162757.813009222@linuxfoundation.org>
 <20180328184423.44nhfdfy26l37b5p@xps>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <12e0d7ea-4d62-41bf-40fa-e6005460c9b6@oracle.com>
Date: Wed, 28 Mar 2018 12:06:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180328184423.44nhfdfy26l37b5p@xps>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=903
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280196
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/28/2018 11:44 AM, Dan Rue wrote:
> On Tue, Mar 27, 2018 at 06:26:40PM +0200, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.15.14 release.
>> There are 105 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu Mar 29 16:27:29 UTC 2018.
>> Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64 and x86_64.
> 
> There is a regression on arm32 in libhugetlbfs/truncate_above_4GB-2M-32
> that also exists in 4.14 and mainline. We'll investigate the root cause
> and report upstream in mainline. I suspect the cause is "hugetlbfs:
> check for pgoff value overflow", but have not verified yet.

I'll also take a look as this was a patch I introduced.  

-- 
Mike Kravetz
