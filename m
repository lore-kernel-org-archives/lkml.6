Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753873AbeCFSgr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:36:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932418AbeCFSgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:36:44 -0500
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 06 Mar 2018 13:36:36 -0500
In-Reply-To: <1520353933.5393.21.camel@HansenPartnership.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
         <20180305125642.GA3425@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
         <20180306074932.GB3624@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
         <1520353933.5393.21.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030618-0016-0000-0000-0000052D97E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030618-0017-0000-0000-0000286AAFC8
Message-Id: <1520361396.10396.396.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803060204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 08:32 -0800, James Bottomley wrote:
> On Tue, 2018-03-06 at 08:06 +0000, Winkler, Tomas wrote:
> > > 
> > > 
> > > On Mon, Mar 05, 2018 at 01:09:09PM +0000, Winkler, Tomas wrote:
> > > > 
> > > > Why you need cover letter?  What are u missing in the patch
> > > > description
> > > 
> > > If you submit a *patch set* I *require* a cover letter, yes.
> > 
> > It's good but it is not must, you are inventing your own rules.
> 
> As long as the Maintainer is the gatekeeper, you're not going to get
> very far with this argument.  The fact is that a lot of subsystems have
> varying rules; often undocumented, some of which are even in conflict,
> like alphabetic vs reverse christmas tree format for includes.
> 
> A cover letter is actually one of the more uniform rules.  It's
> referred to in submitting patches, but not actually documented there.

I've heard that some maintainers are moving away from cover letters,
since they are not include in the git repo and are lost.  I've seen
Andrew Morton cut and paste the cover letter in the first patch
description of the patch set.

Mimi
