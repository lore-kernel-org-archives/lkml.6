Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B209C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FA420841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FA420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeJKRKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:10:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726886AbeJKRKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:10:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9B9fOJ8135425
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 05:43:40 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n20vd7x2r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 05:43:39 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Oct 2018 10:43:36 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 10:43:33 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9B9hWjr52560012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 09:43:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 736FFAE057;
        Thu, 11 Oct 2018 12:42:15 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DB45AE045;
        Thu, 11 Oct 2018 12:42:14 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.86.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Oct 2018 12:42:14 +0100 (BST)
Subject: Re: [PATCH] MAINTAINERS: Add me as a keys/trusted maintainer
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     David Howells <dhowells@redhat.com>, zohar@linux.vnet.ibm.com,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 05:43:20 -0400
In-Reply-To: <20180917204457.GA6716@linux.intel.com>
References: <20180831085504.GB12908@linux.intel.com>
         <20180814145759.11581-1-jarkko.sakkinen@linux.intel.com>
         <22213.1536857154@warthog.procyon.org.uk>
         <20180916191903.GC7473@linux.intel.com>
         <1537162822.3056.7.camel@HansenPartnership.com>
         <20180917204457.GA6716@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101109-0016-0000-0000-0000021194AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101109-0017-0000-0000-000032690964
Message-Id: <1539251000.11939.6.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=896 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-17 at 23:44 +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 16, 2018 at 10:40:22PM -0700, James Bottomley wrote:
> > On Sun, 2018-09-16 at 22:19 +0300, Jarkko Sakkinen wrote:
> > > On Thu, Sep 13, 2018 at 05:45:54PM +0100, David Howells wrote:
> > > > Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > > > 
> > > > > David, what do you think?
> > > > 
> > > > Which David?
> > > > 
> > > > I think you need to ask James and Mimi since they're the current
> > > > maintainers.
> > > > 
> > > > David
> > > 
> > > Right, of course, sorry!
> > > 
> > > James, Mimi?
> > 
> > Not having seen the email thread, I assume it's a patch to add Jarkko
> > as a Trusted Keys maintainer?  If so that's fine by me.
> > 
> > James
> 
> Yeah, that. Thanks James!

Thank you for agreeing!  Have you made the change to MAINTAINERS?  If
not, I'm about to send James Morris the linux-integrity pull request.
 I can include the change.

Mimi

